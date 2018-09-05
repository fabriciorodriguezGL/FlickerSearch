//
//  PhotoSearchViewModelTests.swift
//  FlickerSearchTests
//
//  Created by Fabricio Rodriguez on 9/5/18.
//  Copyright © 2018 Fabricio Rodriguez. All rights reserved.
//

@testable import FlickerSearch
import Foundation
import XCTest

class PhotoSearchViewModelTests: XCTestCase {
    
    var photosServiceMock: PhotosServiceMock!
    var viewModel: SearchPhotosViewModel!
    
    override func setUp() {
        super.setUp()
        let photo = PhotoWrapper(id: "12s", farm: 2, owner: "we3", secret: "fd3", server: "d2", title: "se", url: "sd")
        photosServiceMock = PhotosServiceMock(page: 1, pages: 3, photos: [photo, photo])
        viewModel = SearchPhotosViewModel(photosService: photosServiceMock)
    }
    
    func test_inputsProtocol_should_not_be_nil() {
        let inputs = viewModel.inputs
        XCTAssertNotNil(inputs)
    }
    
    func test_outputsProtocol_should_not_be_nil() {
        let outputs = viewModel.outputs
        XCTAssertNotNil(outputs)
    }
    
    func test_search_photos_result() {
        viewModel.search(term: "")
        //todo test the items are the same
        XCTAssertTrue(viewModel.outputs.photos.count == photosServiceMock.photos.count)
    }
    
    func test_search_photos_next_page() {
        viewModel.search(term: "")
        viewModel.loadNextPage()
        //todo: test the items are the same
        XCTAssert(viewModel.outputs.photos.count == (photosServiceMock.photos.count * 2))
    }
    
    func test_new_search() {
        viewModel.search(term: "")
        viewModel.loadNextPage()
        viewModel.loadNextPage()
        viewModel.search(term: "")
        //todo: test they item are the same
        XCTAssert(viewModel.outputs.photos.count == photosServiceMock.photos.count)

    }
    override func tearDown() {
        super.tearDown()
    }
}
