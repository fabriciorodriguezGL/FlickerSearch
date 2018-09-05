//
//  PhotoServiceMock.swift
//  FlickerSearchTests
//
//  Created by Fabricio Rodriguez on 9/5/18.
//  Copyright © 2018 Fabricio Rodriguez. All rights reserved.
//
import Foundation
@testable import FlickerSearch

class PhotosServiceMock: PhotosService {
    
    var page: Int
    var pages: Int
    var total: String
    var photos: [Photo]
    var perPage: Int
    
    init(page: Int, pages: Int, photos: [Photo], perPage: Int =  10, total: String = "3222") {
        self.page = page
        self.pages = pages
        self.photos = photos
        self.perPage = perPage
        self.total = total
    }
    //todo: we can improve this function by sending different responses for different terms of search
    func searchPhotos(term: String, page: Int, onComplete: @escaping (Result<SearchResponse>) -> Void) {
        let result = SearchResponseWrapper(page: self.page, pages: self.pages, perPage: perPage, total: self.total, photos: self.photos)
        onComplete(.success(result))
    }
}
