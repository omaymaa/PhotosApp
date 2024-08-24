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

 This struct acts as a repository for fetching photos. It communicates with a remote API through the `PhotosListRepository` protocol and maps the API result to an array of `PhotoDomainModel` instances. The fetched photos are provided as a `Future` that represents either a successful array of domain models or an error message.
 */
struct PhotosListRepositoryImplementation: PhotosListRepository {
  
    // A reference to the remote API repository
    private let remoteApi: PhotosListAPIRepository = PhotosListAPIRepoistoryImplementation()
    
    /**
     Fetches a list of photos from the remote API.
     
     - Returns: A `Future` that contains an array of `PhotoDomainModel` on success, or an `ErrorMessage` on failure.
     */
    func fetchPhotosList() -> Future<[PhotoDomainModel], ErrorMessage> {
        // Call the remote API to get photos and map the result to `PhotoDomainModel`
        remoteApi.getPhotos()
            .map { result in
                // Map each API result to the domain model
                result.map(PhotoDomainModel.init)
            }
            .asFuture() // Convert the publisher to a `Future`
    }
    
}
