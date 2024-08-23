//
//  UIImageView+Extension.swift
//  PhotosApp
//
//  Created by Omayma Marouf on 22/08/2024.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()
let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)

extension UIImageView {
  
    /**
     Loads a remote image from a given URL string.
     
     - Parameter urlString: The URL string of the remote image.
     */
    func loadRemoteImageFrom(urlString: String){
        guard let url = URL(string: urlString) else { return }
      image = nil
      activityView.center = self.center
      self.addSubview(activityView)
      activityView.startAnimating()
      if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
          self.image = imageFromCache
          activityView.stopAnimating()
          activityView.removeFromSuperview()
          return
      }
        /// Fetch the image from the remote URL.
        URLSession.shared.dataTask(with: url) {
          data, response, error in
          DispatchQueue.main.async {
              activityView.stopAnimating()
              activityView.removeFromSuperview()
          }
            if let response = data {
                DispatchQueue.main.async {
                    /// Cache the fetched image and set it to the image view.
                  if let imageToCache = UIImage(data: response) {
                      imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                      self.image = imageToCache
                  }else{
                      /// Load a placeholder image in case of failure.
                      self.loadRemoteImageFrom(urlString: "https://via.placeholder.com/300/000000/FFFFFF/?text=Image%20Not%20Found")
                  }
                }
            }
       }.resume()
    }
 
    func enableZoom() {
      let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
      isUserInteractionEnabled = true
      addGestureRecognizer(pinchGesture)
    }

    @objc
    private func startZooming(_ sender: UIPinchGestureRecognizer) {
      let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
      guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
      sender.view?.transform = scale
      sender.scale = 1
    }
    
}
