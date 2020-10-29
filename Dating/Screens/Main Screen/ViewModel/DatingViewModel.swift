//
//  DatingViewModel.swift
//  Dating
//
//  Created by Agil Madinali on 10/27/20.
//

import UIKit

protocol DatingViewModelDelegate: AnyObject {
    func failed(error: CustomError)
    func addCardToContainer(card: SwipeCardView, at index: Int)
}

class DatingViewModel {
    
    // MARK: - Properties
    
    private let horizontalInset: CGFloat = 12.0
    private let verticalInset: CGFloat = 12.0
    private let numberOfVisibleCards: Int = 3
    private let containerViewBounds: CGRect
    
    private var cardViews: [SwipeCardView] = []
    private var personList: [Person] = []
    private var usersInContainer: [Person] = []
    private var favouritesList: [Person] = []
    
    weak var viewModelDelegate: DatingViewModelDelegate?
    
    // MARK: - Inits

    required init(viewModelDelegate: DatingViewModelDelegate, containerViewBounds: CGRect) {
        self.viewModelDelegate = viewModelDelegate
        self.containerViewBounds = containerViewBounds
        loadUsers()
    }
    
    // MARK: - Methods
    
    private func loadUsers() {
        NetworkManager.manager.request(ApiResponse.self) { result in
            switch result {
            case .success(let response):
                if !response.results.isEmpty {
                    let people = response.results
                    self.personList = people
                    self.initContainerViewCards(with: people)
                } else {
                    self.viewModelDelegate?.failed(error: CustomError.noUsersFound)
                }
                
            case .failure(let error):
                self.viewModelDelegate?.failed(error: error)
            }
        }
    }
    
    func initContainerViewCards(with people: [Person]) {
        self.personList = people
        for _ in 0..<numberOfVisibleCards {
            insertNewCard()
        }
    }
    
    private func insertNewCard() {
        guard !personList.isEmpty else { return }
        let person = personList.removeLast()
        if let card = createPersonCardView(with: person) {
            viewModelDelegate?.addCardToContainer(card: card, at: 0)
        }
        updateFrames()
    }
    
    private func createPersonCardView(with person: Person) -> ReusableView? {
        let card = ReusableView()
        card.setInfo(person: person)
        card.delegate = self
        cardViews.append(card)
        usersInContainer.append(person)
        return card
    }
    
    private func setFrame(for cardView: SwipeCardView, at index: Int) -> SwipeCardView? {
        var cardViewFrame = containerViewBounds
        let verticalInset = CGFloat(index) * self.verticalInset
        let horizontalInset = (CGFloat(index) * self.horizontalInset)
        
        cardViewFrame.origin.y += verticalInset
        cardViewFrame.origin.x += horizontalInset
        cardViewFrame.size.width -= 2 * horizontalInset
        cardView.frame = cardViewFrame
        return cardView
    }
    
    private func updateFrames() {
        for (index, card) in cardViews.enumerated() {
            if let card = setFrame(for: card, at: index) {
                cardViews[index] = card
            }
        }
    }
}

// MARK: - SwipeViewDelegate

extension DatingViewModel: SwipeViewDelegate {
    
    func didSwipeLeft(on view: SwipeView) {
        let card = cardViews.removeFirst()
        usersInContainer.removeFirst()
        insertNewCard()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            card.removeFromSuperview()
        }
    }
    
    func didSwipeRight(on view: SwipeView) {
        let card = cardViews.removeFirst()
        let user = usersInContainer.removeFirst()
        favouritesList.append(user)
        insertNewCard()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            card.removeFromSuperview()
        }
    }
}

// MARK: - FavouritesDataSource

extension DatingViewModel: FavouritesDataSource {
    
    func getFavouritesCount() -> Int {
        return favouritesList.count
    }
    
    func getFavourite(at index: Int) -> Person? {
        guard index < favouritesList.count else { return nil }
        return favouritesList[index]
    }
}
