//
//  Photo.swift
//  FlickerSearch
//
//  Created by Fabricio Rodriguez on 9/5/18.
//  Copyright © 2018 Fabricio Rodriguez. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol Photo {
    var id: String { get }
    var farm: Int { get }
    var owner: String { get }
    var secret: String { get }
    var server: String { get }
    var title: String { get }
    var url: String { get }
}

class PhotoWrapper: Photo {
    var id: String {
        return _id
    }
    
    var farm: Int {
        return _farm
    }
    
    var owner: String {
        return _owner
    }
    
    var secret: String {
        return _secret
    }
    
    var server: String {
        return _server
    }
    
    var title: String {
        return _title
    }
    
    var url: String {
        return _url
    }
    
    private var _id: String
    private var _farm: Int
    private var _owner: String
    private var _secret: String
    private var _server: String
    private var _title: String
    private var _url: String
    
    init(id: String, farm: Int, owner: String, secret: String,
         server: String, title: String, url: String) {
        self._id = id
        self._farm = farm
        self._owner = owner
        self._secret = secret
        self._server = server
        self._title = title
        self._url = url
    }
}

extension PhotoWrapper {
    convenience init?(json: JSON) {
        if json.isEmpty {
            return nil
        }
        let id = json["id"].stringValue
        let farm = json["farm"].intValue
        let owner = json["owner"].stringValue
        let secret = json["secret"].stringValue
        let server = json["server"].stringValue
        let title = json["title"].stringValue
        let url = json["url_s"].stringValue
        self.init(id: id, farm: farm, owner: owner, secret: secret, server: server, title: title, url: url)
    }
}
