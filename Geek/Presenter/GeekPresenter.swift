//
//  GeekViewModel.swift
//  Geek
//
//  Created by Thilak k on 19/05/22.
//

import Foundation

class GeekViewModel {
    
    // MARK: - Properties
    private var geek: GeekModel? {
        didSet {
            guard let p = geek else { return }
            self.setupText(with: p)
            self.didFinishFetch?()
        }
    }
    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
 
    var geekList:GeekModel?
    
    private var dataService: DataService?
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    // MARK: - Constructor
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    // MARK: - Network call
    func fetchmovie(withId id: String) {
        self.dataService?.requestFetchMovie(with: id, completion: { (photo, error) in
            if let error = error {
                self.error = error
                self.isLoading = false
                return
            }
            self.error = nil
            self.isLoading = false
            self.geek = photo
        })
    }
    
    // MARK: - UI Logic
    private func setupText(with geek: GeekModel) {
        self.geekList = geek
    }
    
}
