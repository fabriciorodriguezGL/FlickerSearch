//
//  SearchResponse.swift
//  FlickerSearch
//
//  Created by Fabricio Rodriguez on 9/5/18.
//  Copyright © 2018 Fabricio Rodriguez. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol SearchResponse {
    var page: Int { get }
    var pages: Int { get }
    var perPage: Int { get }
    var total: String { get }
    var photos: [Photo] { get }
}

class SearchResponseWrapper: SearchResponse {
    
    var page: Int {
        return _page
    }
    
    var pages: Int {
        return _pages
    }
    
    var perPage: Int {
        return _perPage
    }
    
    var total: String {
        return _total
    }
    
    var photos: [Photo] {
        return _photos
    }
    var _page: Int
    var _pages: Int
    var _perPage: Int
    var _total: String
    var _photos: [Photo]
    
    init(page: Int, pages: Int, perPage: Int, total: String, photos: [Photo]) {
        self._page = page
        self._pages = pages
        self._perPage = perPage
        self._total = total
        self._photos = photos
    }
}

extension SearchResponseWrapper {
    convenience init?(json: JSON) {
        if json.isEmpty {
            return nil
        }
        let page = json["page"].intValue
        let pages = json["pages"].intValue
        let perpage = json["perpage"].intValue
        let total = json["total"].stringValue
        let photosJson = json["photo"].arrayValue
        var photos = [Photo]()
        for photoJson in photosJson {
            if let photo = PhotoWrapper(json: photoJson) {
                photos.append(photo)
            }
        }
        self.init(page: page, pages: pages, perPage: perpage, total: total, photos: photos)
    }
}
