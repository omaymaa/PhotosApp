//
//  PhotoDomainModel.swift
//  PhotosApp
//
//  Created by Omayma Marouf on 22/08/2024.
//

import Foundation

public struct PhotoDomainModel{
    let title: String?
    let thumbnailURL: String?

    
    init( _ photo : Photo) {
        self.title = photo.title
        self.thumbnailURL = photo.thumbnailURL
    }
    
    init(title: String, thumbnailURL: String) {
        self.title = title
        self.thumbnailURL = thumbnailURL
    }
}
