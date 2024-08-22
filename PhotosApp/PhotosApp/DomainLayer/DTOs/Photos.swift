//
//  Photos.swift
//  PhotosApp
//
//  Created by Omayma Marouf on 22/08/2024.
//

import Foundation

// MARK: - Photo
public typealias Photos = [Photo]

public struct Photo: Codable {
    var albumID, id: Int?
    var title: String?
    var url, thumbnailURL: String?

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}
