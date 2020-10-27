//
//  DatingViewController.swift
//  Dating
//
//  Created by Agil Madinali on 10/23/20.
//

import UIKit

class DatingViewController: UIViewController {

    @IBOutlet private weak var sampleView: UIView!
    
    // MARK: - Properties

    var viewModel: DatingViewModel?
    
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
    
    func addCardToContainer(card: ReusableView, at index: Int) {
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
