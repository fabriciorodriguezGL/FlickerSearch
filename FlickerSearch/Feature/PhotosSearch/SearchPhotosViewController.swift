//
//  SearchPhotosViewController.swift
//  FlickerSearch
//
//  Created by Fabricio Rodriguez on 9/5/18.
//  Copyright © 2018 Fabricio Rodriguez. All rights reserved.
//

import UIKit
import RxSwift

class SearchPhotosViewController: UIViewController, StoryboardInitializable {
    
    fileprivate var searchPhotosViewModel: SearchPhotosViewModelType!
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    private var scrollThreshold = 0.7
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultStates()
        createBindings()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension SearchPhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - UICollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchPhotosViewModel.outputs.photos.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard  let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier,
                                 for: indexPath) as? PhotoCollectionViewCell else {
                                    preconditionFailure(Constants.Error.cellInitFailed)
        }
        let photo = searchPhotosViewModel.outputs.photos[indexPath.row]
        cell.configureWith(photo: photo)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastScrollPermittedItem = Int((Double(searchPhotosViewModel.outputs.photos.count) * scrollThreshold ))
        if indexPath.row > lastScrollPermittedItem {
            searchPhotosViewModel.inputs.loadNextPage()
        }
    }
}

extension SearchPhotosViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            return
        }
        searchPhotosViewModel.inputs.search(term: searchText)
    }
}

extension SearchPhotosViewController {
    // MARK: - Initialization
    func setDefaultStates() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.searchBar.delegate = self
        self.navigationItem.title = self.searchPhotosViewModel.outputs.viewTitle
        self.searchBar.placeholder = self.searchPhotosViewModel.outputs.searchPlaceholder
        self.collectionView.register(PhotoCollectionViewCell.nib, forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier)
    }
    
    func createBindings() {
        self.searchPhotosViewModel
            .outputs
            .reloadData
            .subscribe(onNext: {[weak self] _ in
                self?.collectionView.reloadData()
            }).disposed(by: disposeBag)
        self.searchPhotosViewModel
            .outputs
            .scrollToTop
            .subscribe(onNext: {[weak self] shouldScroll in
                if shouldScroll {
                    self?.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: UICollectionViewScrollPosition.top, animated: false)
                }
            }).disposed(by: disposeBag)
    }
}

extension SearchPhotosViewController {
    
    static var storyboardName: String {
        return "SearchPhotos"
    }
    
    var viewModel: ViewModelType? {
        get {
            return searchPhotosViewModel
        }
        set {
            searchPhotosViewModel = newValue as? SearchPhotosViewModelType
        }
    }
}
