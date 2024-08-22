//
//  PhotosListViewModel.swift
//  PhotosApp
//
//  Created by Omayma Marouf on 22/08/2024.
//

import UIKit
import Combine

class PhotosListViewModel: ObservableObject {
    @Published var photosData: [PhotoDomainModel] = []
    @Published var errorMessage: String?
    @Published var loadingState: LoadingState = .finished

    private var allPhotos: [PhotoDomainModel] = []
    private var cancellables: Set<AnyCancellable> = []
    
    private var repository: PhotosListRepository = PhotosListRepositoryImplementation()
    private var currentPage: Int = 0
    private let itemsPerPage: Int = 10
    private var hasMorePages: Bool = true

    init() {
        fetchAllPhotos()
    }
    
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
