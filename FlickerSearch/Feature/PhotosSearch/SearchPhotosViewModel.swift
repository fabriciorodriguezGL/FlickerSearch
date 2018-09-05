//
//  SearchPhotosViewModel.swift
//  FlickerSearch
//
//  Created by Fabricio Rodriguez on 9/5/18.
//  Copyright © 2018 Fabricio Rodriguez. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SearchPhotosViewModelOutputs {
    var photos: [Photo] { get }
    var viewTitle: String { get }
    var searchPlaceholder: String { get }
    //this can be replaced by KVO or property observers and closures
    var reloadData: PublishSubject<Bool> { get }
    var isLoading: BehaviorRelay<Bool> { get }
    var scrollToTop: PublishSubject<Bool> { get }
}

protocol SearchPhotosViewModelInputs {
    func search(term: String)
    func loadNextPage()
}

protocol SearchPhotosViewModelType: ViewModelType {
    var inputs: SearchPhotosViewModelInputs { get }
    var outputs: SearchPhotosViewModelOutputs { get }
}

class SearchPhotosViewModel: SearchPhotosViewModelType, SearchPhotosViewModelOutputs, SearchPhotosViewModelInputs {
    
    var outputs: SearchPhotosViewModelOutputs { return self }
    var inputs: SearchPhotosViewModelInputs { return self }
    
    private var photosService: PhotosService
    private var currentPage: Int = 1
    private var totalPages: Int = 2
    private var initialPage = 1
    private var searchTerm: String = ""
    
    private var shouldGoToNextPage: Bool {
        return nextPage <= totalPages
    }
    
    private var nextPage: Int {
            return currentPage + 1
    }
    
    var photos: [Photo] = []
    var reloadData: PublishSubject<Bool> = PublishSubject<Bool>()
    var isLoading: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    var scrollToTop: PublishSubject<Bool> = PublishSubject<Bool>()
    var viewTitle: String {
        return NSLocalizedString(Constants.LocalizedKeys.searchViewControllerTitle, comment: "")
    }
    var searchPlaceholder: String {
        return NSLocalizedString(Constants.LocalizedKeys.searchPlaceholder, comment: "")
    }
    
    init(photosService: PhotosService = PhotosServiceWrapper()) {
        self.photosService = photosService
    }
    
    func search(term: String) {
        searchTerm = term
        searchPhotos(for: searchTerm, startingFrom: initialPage)
    }
    
    func loadNextPage() {
        if !isLoading.value && shouldGoToNextPage {
            searchPhotos(for: searchTerm, startingFrom: nextPage, isNewSearch: false)
        }
    }
    
    func searchPhotos(for term: String, startingFrom page: Int, isNewSearch: Bool = true) {
        self.isLoading.accept(true)
        photosService.searchPhotos(term: term, page: page) {[weak self] result in
            switch result {
            case .success(let result):
                self?.currentPage = result.page
                self?.totalPages = result.pages
                if isNewSearch {
                    self?.photos.removeAll()
                }
                self?.photos.append(contentsOf: result.photos)
                self?.reloadData.onNext(true)
                self?.scrollToTop.onNext(isNewSearch)
                self?.isLoading.accept(false)
            case .failure(let error):
                print(error)
            }
        }
    }
}
