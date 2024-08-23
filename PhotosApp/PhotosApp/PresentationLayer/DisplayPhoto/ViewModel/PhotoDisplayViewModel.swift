//
//  PhotoDisplayViewModel.swift
//  PhotosApp
//
//  Created by Omayma Marouf on 23/08/2024.
//

import Foundation
import Combine

class DisplayPhotoViewModel: ObservableObject {
    @Published var photoURL: String?
    @Published var title: String?

    init(photoURL: String?, title: String?) {
        self.photoURL = photoURL
        self.title = title
    }
}
