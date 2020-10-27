//
//  ReusableView.swift
//  Dating
//
//  Created by Agil Madinali on 10/25/20.
//

import UIKit

class ReusableView: SwipeCardView {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var ageLabel: UILabel!
    @IBOutlet private weak var personImage: UIImageView! {
        didSet {
            self.personImage.layer.cornerRadius = 40 //self.personImage.frame.height/2
        }
    }
    @IBOutlet private weak var infoLabel: UILabel!
    
    // MARK: IBActions
    
    @IBAction private func genderButton(_ sender: UIButton) {
        self.infoLabel.text = "Gender: "
    }
    @IBAction private func addressButton(_ sender: UIButton) {
        self.infoLabel.text = "Address: "
    }
    @IBAction private func emailButton(_ sender: UIButton) {
        self.infoLabel.text = "Email: "
    }
    @IBAction private func phoneButton(_ sender: UIButton) {
        self.infoLabel.text = "Phone Number: "
    }
    @IBAction private func lockButton(_ sender: UIButton) {
        self.infoLabel.text = "You do not have the premium access.\nPlease navigate to payments screen."
    }
    
    // MARK: - Properties
    
    private weak var shadowView: UIView?
    
    // MARK: - Initializers
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    deinit { }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("ReusableView", owner: self, options: nil)
        addSubview(cardView)
        cardView.frame = bounds
        cardView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    // MARK: - Methods

    override func layoutSubviews() {
        super.layoutSubviews()
        guard shadowView == nil else { return }
        shadowView = addShadow(to: cardView)
    }
    
    func setInfo(name: String, age: String, imageUrl: String) {
        
        nameLabel.text = name
        ageLabel.text = age
        
        NetworkManager.manager.downloadImage(with: imageUrl) { results in
            switch results {
            case .success(let image):
                DispatchQueue.main.async {
                    self.personImage.image = image
                }
                
            case .failure(let error):
                print(error.localizedDescription, " with image url ", imageUrl)
            }
        }
    }
}
