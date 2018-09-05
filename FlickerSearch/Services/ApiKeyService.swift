//
//  ApiKeyService.swift
//  FlickerSearch
//
//  Created by Fabricio Rodriguez on 9/5/18.
//  Copyright © 2018 Fabricio Rodriguez. All rights reserved.
//

import Foundation

protocol ApiKeyService {
    func getApiKey() -> String
}

class ApiKeyServiceWrapper: ApiKeyService {
    func getApiKey() -> String {
        return "53b1e3a6e164fe37c6bb0e7df4b0f664"
    }
}
