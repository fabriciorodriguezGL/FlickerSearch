//
//  StoryboardInitializable.swift
//  FlickerSearch
//
//  Created by Fabricio Rodriguez on 9/5/18.
//  Copyright © 2018 Fabricio Rodriguez. All rights reserved.
//

import Foundation
import UIKit

protocol ViewModelType: class {
}

protocol StoryboardInitializable {
    static var storyboardName: String { get }
    var viewModel: ViewModelType? { get set }
    static func instantiate(with viewModel: ViewModelType) -> Self
}

extension StoryboardInitializable where Self: UIViewController {
    static var storyboardName: String {
        return "SearchPhotos"
    }
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    static func instantiate(with viewModel: ViewModelType) -> Self {
        return makeFromStoryboard(named: storyboardName, viewModel: viewModel)
    }
    private static func makeFromStoryboard(named: String, viewModel: ViewModelType) -> Self {
        let storyboard = UIStoryboard(name: named, bundle: nil)
        guard var viewController = storyboard.instantiateViewController (
            withIdentifier: storyboardIdentifier) as? Self else {
                preconditionFailure(Constants.Error.storyboardInitializationFailed)
        }
        viewController.viewModel = viewModel
        return viewController
    }
}
