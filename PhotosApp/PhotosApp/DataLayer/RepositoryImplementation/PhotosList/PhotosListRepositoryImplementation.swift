//
//  PhotosListRepositoryImplementation.swift
//  PhotosApp
//
//  Created by Omayma Marouf on 22/08/2024.
//

import Foundation
import Combine

/**
 The `PhotosListRepositoryImplementation` struct provides an implementation for fetching photos from a remote API.
 
 This struct acts as a repository for fetching photos. It communicates with a remote API through the `PhotosListRepository` protocol and maps the API result to an array of `PhotoDomainModel` instances. The fetched recipes are provided as a `Future` that represents a successful array of domain models or an error message.
 */
struct PhotosListRepositoryImplementation: PhotosListRepository {
  
    private let remoteApi : PhotosListAPIRepository = PhotosListAPIRepoistoryImplementation()
    
    func fetchPhotosList() -> Future<[PhotoDomainModel], ErrorMessage> {
        remoteApi.getPhotos()
            .map { result in
                result.map(PhotoDomainModel.init)
            }
            .asFuture()
       
    }
    
}
