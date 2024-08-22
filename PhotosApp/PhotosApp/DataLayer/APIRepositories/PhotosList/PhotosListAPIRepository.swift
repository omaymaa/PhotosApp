//
//  PhotosListAPIRepository.swift
//  PhotosApp
//
//  Created by Omayma Marouf on 22/08/2024.
//

import Foundation
import Combine

public protocol PhotosListAPIRepository : RemoteAPI {
    func getPhotos() -> Future<[Photo],ErrorMessage>
}
