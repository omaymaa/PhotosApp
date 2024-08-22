//
//  PhotosListViewController.swift
//  PhotosApp
//
//  Created by Omayma Marouf on 22/08/2024.
//

import UIKit
import Combine

class PhotosListViewController: UIViewController {
    
    @IBOutlet weak var photoListTableView: UITableView!{
        didSet{
            photoListTableView.register(UINib(nibName: "PhotosListTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotosListTableViewCell")
        }
    }
    var viewModel = PhotosListViewModel()
    private var cancellables: Set<AnyCancellable> = []
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        // loadData()
    }
    
    private func setupUI() {
        navigationItem.title = "Recipes"
        photoListTableView.dataSource = self
        photoListTableView.delegate = self
        activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.$photosData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.photoListTableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$loadingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] loadingState in
                if loadingState == .loading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
            .store(in: &cancellables)
        viewModel.fetchAllPhotos()
    }
    
}
