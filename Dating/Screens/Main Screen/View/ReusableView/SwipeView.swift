//
//  SwipeView.swift
//  Dating
//
//  Created by Agil Madinali on 10/27/20.
//

//import CoreGraphics
import UIKit

protocol SwipeViewDelegate: AnyObject {
    func didSwipeLeft(on view: SwipeView)
    func didSwipeRight(on view: SwipeView)
}

class SwipeCardView: SwipeView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit { }
}

class SwipeView: UIView {
    
    // MARK: - Properties
    
    private var panGestureRecognizer: UIPanGestureRecognizer?
    var initialCenter = CGPoint()
    
    weak var delegate: SwipeViewDelegate?
    
    // MARK: - Inits

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGestureRecognizers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGestureRecognizers()
    }
    
    deinit {
        if let panGestureRecognizer = panGestureRecognizer {
            removeGestureRecognizer(panGestureRecognizer)
        }
    }
    
    // MARK: - Methods
    
    private func setupGestureRecognizers() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized))
        self.panGestureRecognizer = panGestureRecognizer
        addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc private func panGestureRecognized(_ sender: UIPanGestureRecognizer) {
        guard let card = sender.view, let view = card.superview else { return }
        let point = sender.translation(in: view)
        // translation refers to moving an object without changing it in any other way
        
        let xFromCenter = card.center.x - initialCenter.x
        let divisor: CGFloat = (view.frame.width / 2) / 0.436    // 0.436 is radian version of 25 degrees
        let scale = min(100 / abs(xFromCenter), 1)
        
        switch sender.state {
        case .began:
            initialCenter = card.center
            
        case .changed:
            card.center = CGPoint(x: initialCenter.x + point.x, y: initialCenter.y + point.y)
            card.transform = CGAffineTransform(rotationAngle: xFromCenter / divisor).scaledBy(x: scale, y: scale)
            
        case .ended:
            checkSwipeState(of: card)
            
        case .cancelled, .failed, .possible:
            break
            
        @unknown default:
            break
        }
    }
    
    private func checkSwipeState(of card: UIView) {
        var move: CGPoint?
        if card.center.x > initialCenter.x + 100 {
            move = CGPoint(x: self.initialCenter.x + 500,
                           y: self.initialCenter.y + 75)
            delegate?.didSwipeRight(on: self)
        } else if card.center.x < initialCenter.x - 100 {
            move = CGPoint(x: self.initialCenter.x - 500,
                           y: self.initialCenter.y + 75)
            delegate?.didSwipeLeft(on: self)
        } else {
            move = initialCenter
            card.transform = .identity
        }
        
        UIView.animate(withDuration: 0.2) {
            if let move = move {
                card.center = move
            }
        }
    }
}
