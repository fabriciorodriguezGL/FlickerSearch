//
//  Constants.swift
//  FlickerSearch
//
//  Created by Fabricio Rodriguez on 9/5/18.
//  Copyright © 2018 Fabricio Rodriguez. All rights reserved.
//

import Foundation
struct Constants {
    struct Error {
        static let storyboardInitializationFailed = "Failed to initalize view controller from storyboard"
        static let cellInitFailed = "Unable to dequeue collection view cell"
        static let parseResponseFailed = "Unable to parse the response"
    }
    
    struct Endpoints {
        static let baseUrl = "https://api.flickr.com/services/rest/"
    }
    
    struct LocalizedKeys {
        static let searchViewControllerTitle = "SEARCH_VC_TITLE"
        static let searchPlaceholder = "SEARCH_PLACEHOLDER"
    }
}
