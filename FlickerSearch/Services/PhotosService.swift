//
//  PhotosService.swift
//  FlickerSearch
//
//  Created by Fabricio Rodriguez on 9/5/18.
//  Copyright © 2018 Fabricio Rodriguez. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol PhotosService {
    func searchPhotos(term: String, page: Int, onComplete: @escaping(_ result: Result<SearchResponse>) -> Void)
}

class PhotosServiceWrapper: PhotosService {
    
    var apiKeyService: ApiKeyService
    
    init(apiKeyService: ApiKeyService = ApiKeyServiceWrapper()) {
        self.apiKeyService = apiKeyService
    }
    
    func searchPhotos(term: String, page: Int, onComplete: @escaping(_ result: Result<SearchResponse>) -> Void) {
        let params: [String: Any] = buildParams(term: term, page: page)
        Alamofire.request(Constants.Endpoints.baseUrl,
                          method: .get,
                          parameters: params,
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON { response in
                            switch response.result {
                            case .success(let value):
                                let json = JSON(value)
                                guard let response = SearchResponseWrapper(json: json["photos"]) else {
                                    onComplete(.failure(ServiceError.parseResponseFailed))
                                    return
                                }
                                onComplete(.success(response))
                            case .failure(let error):
                                onComplete(.failure(error))
                            }
        }
    }
    
    private func buildParams(term: String, page: Int) -> [String: Any] {
        return [ParametersKeys.apikey.rawValue: apiKeyService.getApiKey(),
                ParametersKeys.text.rawValue: term,
                ParametersKeys.page.rawValue: page,
                ParametersKeys.format.rawValue: "json",
                ParametersKeys.noJsonCallback.rawValue: 1,
                ParametersKeys.extras.rawValue: "url_s",
                ParametersKeys.safeSearch.rawValue: 1,
                ParametersKeys.method.rawValue: "flickr.photos.search"]
    }
}

enum ParametersKeys: String {
    case apikey = "api_key"
    case page
    case text
    case format
    case noJsonCallback = "nojsoncallback"
    case method
    case extras
    case safeSearch = "safe_search"
}
