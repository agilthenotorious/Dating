//
//  DatingViewModel.swift
//  Dating
//
//  Created by Agil Madinali on 10/27/20.
//

import UIKit

protocol DatingViewModelDelegate: AnyObject {
    func failed(error: CustomError)
    func addCardToContainer(card: ReusableView, at index: Int)
}

class DatingViewModel {
    
    // MARK: - Properties
    
    private let horizontalInset: CGFloat = 12.0
    private let verticalInset: CGFloat = 12.0
    private let numberOfVisibleCards: Int = 3
    private let containerViewBounds: CGRect
    
    private var users: [Person] = []
    private var cardViews: [ReusableView] = []
    private var usersInContainer: [Person] = []
    //private var connectsList: [Person] = []
    
    weak var viewModelDelegate: DatingViewModelDelegate?
    
    // MARK: - Inits

    required init(viewModelDelegate: DatingViewModelDelegate, containerViewBounds: CGRect) {
        
        self.viewModelDelegate = viewModelDelegate
        self.containerViewBounds = containerViewBounds
        loadUsers()
    }
    
    // MARK: - Model Methods
    
    func initContainerViewCards(with users: [Person]) {
        
        self.users = users
        for _ in 0..<numberOfVisibleCards {
            insertNewCard()
        }
    }
    /*
    func getConnects() -> [Person] {
        return connectsList
    }*/
    
    // MARK: - Private Methods
    
    private func loadUsers() {
        
        NetworkManager.manager.request(ApiResponse.self) { result in
            switch result {
            case .success(let response):
                let users = response.results
                self.users = users
                self.initContainerViewCards(with: users)
                
            case .failure(let error):
                self.viewModelDelegate?.failed(error: error)
            }
        }
    }
    
    private func insertNewCard() {
        
        guard !users.isEmpty else { return }
        let user = users.removeLast()
        if let card = createUserCardView(with: user) {
            viewModelDelegate?.addCardToContainer(card: card, at: 0)
        }
        updateFrames()
    }
    
    private func createUserCardView(with user: Person) -> ReusableView? {
        
        let imageUrl = user.picture.large
        let card = ReusableView()
        card.setInfo(name: user.fullName, age: user.age, imageUrl: imageUrl)
        card.delegate = self
        cardViews.append(card)
        usersInContainer.append(user)
        return card
    }
    
    private func setFrame(for cardView: ReusableView, at index: Int) -> ReusableView? {
        
        var cardViewFrame = containerViewBounds
        let verticalInset = CGFloat(index) * self.verticalInset
        let horizontalInset = (CGFloat(index) * self.horizontalInset)
        
        cardViewFrame.origin.y += verticalInset
        cardViewFrame.origin.x += (horizontalInset - self.horizontalInset)
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
        
        cardViews.removeFirst()
        usersInContainer.removeFirst()
        insertNewCard()
    }
    
    func didSwipeRight(on view: SwipeView) {
        
        cardViews.removeFirst()
        // ************** Append to favourites here ********************
        //let user = usersInContainer.removeFirst()
        //connectsList.append(user)
        insertNewCard()
    }
}
/*
// MARK: - ConnectsDataSource

extension DatingViewModel: ConnectsDataSource {
    
    func getConnectsCount() -> Int {
        return connectsList.count
    }
    
    func getConnect(at index: Int) -> User? {
        guard index < connectsList.count else { return nil }
        return connectsList[index]
    }
}
*/
