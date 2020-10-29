//
//  DatingViewController.swift
//  Dating
//
//  Created by Agil Madinali on 10/23/20.
//

import UIKit

class DatingViewController: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet private weak var sampleView: UIView!
    
    // MARK: - Properties

    var viewModel: DatingViewModel?
    
    // MARK: - IBActions
    
    @IBAction private func navigateToFavourites() {
        if let favouritesTVC = storyboard?.instantiateViewController(withIdentifier: FavouritesTableViewController.identifier) as? FavouritesTableViewController {
                    
            favouritesTVC.datingViewModel = self.viewModel
            self.show(favouritesTVC, sender: nil)
        }
    }
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        sampleView.translatesAutoresizingMaskIntoConstraints = false
        sampleView.adjustConstraints()
        viewModel = DatingViewModel(viewModelDelegate: self, containerViewBounds: sampleView.bounds)
    }
}

// MARK: - DatingViewModelDelegate

extension DatingViewController: DatingViewModelDelegate {
    
    func addCardToContainer(card: SwipeCardView, at index: Int) {
        var cardViewFrame = sampleView.bounds
        let verticalInset = CGFloat(index) * CGFloat(14)
        let horizontalInset = (CGFloat(index) * CGFloat(14))

        cardViewFrame.origin.y += verticalInset
        cardViewFrame.origin.x += horizontalInset
        cardViewFrame.size.width -= 2 * horizontalInset
        card.frame = cardViewFrame

        sampleView.insertSubview(card, at: index)
    }
    
    func failed(error: CustomError) {
        switch error {
        case .badImageUrl, .couldNotDownloadImage, .couldNotUnwrapImage:
            break
            
        case .failedFetchingData:
            break
            
        case .noUsersFound:
            break
        }
    }
}
