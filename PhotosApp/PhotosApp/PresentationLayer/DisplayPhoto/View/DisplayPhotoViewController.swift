//
//  DisplayPhotoViewController.swift
//  PhotosApp
//
//  Created by Omayma Marouf on 23/08/2024.
//

import UIKit
import Combine

class DisplayPhotoViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var photoTitleLbl: UILabel!
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet{
            // Set the zoom scale limits for the scroll view
            scrollView.minimumZoomScale = 1.0
            scrollView.maximumZoomScale = 6.0
            // Set the delegate to handle zooming
            scrollView.delegate = self
        }
    }
    var viewModel: DisplayPhotoViewModel!
       private var cancellables: Set<AnyCancellable> = []

       override func viewDidLoad() {
           super.viewDidLoad()
           bindViewModel()
       }

       private func bindViewModel() {
           viewModel.$photoURL
               .compactMap { $0 }
               .sink { [weak self] url in
                   self?.photo.loadRemoteImageFrom(urlString: url)
               }
               .store(in: &cancellables)

           viewModel.$title
               .sink { [weak self] title in
                   self?.photoTitleLbl.text = title
               }
               .store(in: &cancellables)
       }
       
    // Provide the view to zoom in when the user pinches on the scroll view
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photo
    }
    
    @IBAction func isTappedToExist(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
