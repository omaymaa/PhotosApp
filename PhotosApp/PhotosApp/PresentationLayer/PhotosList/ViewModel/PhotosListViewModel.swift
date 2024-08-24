//
//  PhotosListViewModel.swift
//  PhotosApp
//
//  Created by Omayma Marouf on 22/08/2024.
//

import UIKit
import Combine

class PhotosListViewModel: ObservableObject {
    @Published var photosData: [PhotoDomainModel] = [] // Data for UI binding
    @Published var errorMessage: String? // Error message for UI
    @Published var loadingState: LoadingState = .finished // Current loading state
    
    private var allPhotos: [PhotoDomainModel] = [] // All fetched photos
    private var cancellables: Set<AnyCancellable> = [] // Combine subscriptions
    
    private var repository: PhotosListRepository = PhotosListRepositoryImplementation()
    private var currentPage: Int = 0 // Tracks current page for pagination
    private let itemsPerPage: Int = 10 // Number of items per page
    private var hasMorePages: Bool = true // Flag for additional pages
    
    init() {
        fetchAllPhotos()
    }
    
    // Fetches all photos from the repository
    func fetchAllPhotos() {
        loadingState = .loading
        repository.fetchPhotosList()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
                self?.loadingState = .finished
            } receiveValue: { [weak self] photos in
                guard let self = self else { return }
                self.allPhotos = photos
                self.loadNextPage()
            }
            .store(in: &cancellables)
    }
    
    // Loads the next page of photos for pagination
    func loadNextPage() {
        guard loadingState != .loading, hasMorePages else { return }
        
        loadingState = .loading
        let startIndex = currentPage * itemsPerPage
        let endIndex = min(startIndex + itemsPerPage, allPhotos.count)
        let nextPagePhotos = Array(allPhotos[startIndex..<endIndex])
        
        photosData.append(contentsOf: nextPagePhotos)
        currentPage += 1
        hasMorePages = endIndex < allPhotos.count
        loadingState = .finished
    }
}

enum LoadingState {
    case loading
    case finished
}
