//
//  PhotosSearchViewControllerTests.swift
//  FlickerSearchTests
//
//  Created by Fabricio Rodriguez on 9/5/18.
//  Copyright © 2018 Fabricio Rodriguez. All rights reserved.
//

@testable import FlickerSearch
import Foundation
import XCTest

class PhotoSearchViewControllerTests: XCTestCase {
    
    var photosServiceMock: PhotosServiceMock!
    var viewModel: SearchPhotosViewModel!
    var viewController: SearchPhotosViewController!
    
    override func setUp() {
        super.setUp()
        let photo = PhotoWrapper(id: "12s", farm: 2, owner: "we3", secret: "fd3", server: "d2", title: "se", url: "sd")
        photosServiceMock = PhotosServiceMock(page: 1, pages: 3, photos: [photo, photo])
        viewModel = SearchPhotosViewModel(photosService: photosServiceMock)
        viewController =  SearchPhotosViewController.instantiate(with: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController!)
        navigationController.loadView()
        navigationController.viewDidLoad()
        viewController?.loadView()
        viewController?.viewDidLoad()
    }
    
    func test_search() {
        viewController.searchBar.text = "testsearc"
        viewController.searchBarSearchButtonClicked(viewController.searchBar)
        XCTAssertTrue(viewController.collectionView.dataSource!.collectionView(viewController!.collectionView, numberOfItemsInSection: 1)
            == photosServiceMock.photos.count)
    }
}
