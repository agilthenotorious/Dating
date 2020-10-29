//
//  FavouritesViewModel.swift
//  Dating
//
//  Created by Agil Madinali on 10/29/20.
//

import Foundation

protocol FavouritesDataSource: AnyObject {
    func getFavouritesCount() -> Int
    func getFavourite(at index: Int) -> Person?
}

protocol FavouritesViewModelProtocol: AnyObject {}

class FavouritesViewModel {

    // MARK: - Properties

    weak var dataSource: FavouritesDataSource?
    weak var delegate: FavouritesViewModelProtocol?

    // MARK: - Inits

    init(delegate: FavouritesViewModelProtocol?, dataSource: FavouritesDataSource?) {
        self.delegate = delegate
        self.dataSource = dataSource
    }

    // MARK: - Methods

    func getFavouritesCount() -> Int {
        guard let count = dataSource?.getFavouritesCount() else { return 0 }
        return count
    }

    func getPerson(at index: Int) -> Person? {
        return dataSource?.getFavourite(at: index)
    }
}
