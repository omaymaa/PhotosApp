//
//  PhotosListViewController+TableViewExtension.swift
//  PhotosApp
//
//  Created by Omayma Marouf on 22/08/2024.
//

import UIKit

extension PhotosListViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.photosData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosListTableViewCell", for: indexPath) as? PhotosListTableViewCell
        else {
            return UITableViewCell()
        }
        let photoData = viewModel.photosData[indexPath.row]
        cell.configure(with: photoData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let photoData = viewModel.photosData[indexPath.row]
           
        let storyboard = UIStoryboard(name: "DisplayPhoto", bundle: nil)
           if let displayPhotoVC = storyboard.instantiateViewController(withIdentifier: "DisplayPhotoViewController") as? DisplayPhotoViewController {
               
               let displayPhotoVM = DisplayPhotoViewModel(photoURL: photoData.thumbnailURL, title: photoData.title)
               displayPhotoVC.viewModel = displayPhotoVM
               
               // Present the DisplayPhotoViewController
               displayPhotoVC.modalPresentationStyle = .fullScreen
               present(displayPhotoVC, animated: true, completion: nil)
           }
       }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            
            // Load more data when scrolled near the bottom
            if offsetY > contentHeight - scrollView.frame.height - 100 {
                viewModel.loadNextPage()
            }
        }
}
