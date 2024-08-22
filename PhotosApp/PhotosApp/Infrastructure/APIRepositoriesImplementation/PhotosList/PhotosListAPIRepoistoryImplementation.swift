//
//  PhotosListAPIRepoistoryImplementation.swift
//  PhotosApp
//
//  Created by Omayma Marouf on 22/08/2024.
//

import Foundation
import Combine

public  struct PhotosListAPIRepoistoryImplementation : PhotosListAPIRepository {
    public func getPhotos() -> Future<[Photo], ErrorMessage> {
        let endPoint = "photos"
        return request(endPoint: endPoint, method: .get, parameters: nil)
    }

}
