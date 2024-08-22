//
//  PhotosListRepository.swift
//  PhotosApp
//
//  Created by Omayma Marouf on 22/08/2024.
//

import Foundation
import Combine

protocol PhotosListRepository {
    func fetchPhotosList() -> Future<[PhotoDomainModel], ErrorMessage>
}
