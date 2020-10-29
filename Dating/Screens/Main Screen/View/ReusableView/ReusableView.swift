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
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var tabBar: UITabBar!
    @IBOutlet private weak var personImage: UIImageView!
    @IBOutlet private weak var infoLabel: UILabel!
    
    // MARK: - Properties
    
    private weak var shadowView: UIView?
    private var person: Person?
    
    // MARK: - Inits
    
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
        cardView.layer.cornerRadius = 20
        
        personImage.layer.cornerRadius = personImage.bounds.height / 4
        personImage.layer.borderWidth = 0.4
        personImage.layer.borderColor = UIColor.black.cgColor
        
        tabBar.delegate = self
        if let tabBarItems = tabBar.items {
            let item = tabBarItems[0]
            tabBar.selectedItem = item
        }
    }
    
    // MARK: - Methods

    override func layoutSubviews() {
        super.layoutSubviews()
        guard shadowView == nil else { return }
        shadowView = addShadow(to: cardView)
    }
    
    func setInfo(person: Person) {
        self.person = person
        
        NetworkManager.manager.downloadImage(with: person.picture.large) { results in
            switch results {
            case .success(let image):
                DispatchQueue.main.async {
                    self.personImage.image = image
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        nameLabel.text = person.fullName
        ageLabel.text = person.age
        infoLabel.text = person.gender.rawValue
    }
}

// MARK: - UITabBarDelegate

extension ReusableView: UITabBarDelegate {

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let person = self.person else { return }
        
        switch item.tag {
        case 0:
            infoLabel.text = person.gender.rawValue

        case 1:
            let location = person.location.city + ", " + person.location.state + "\n" + person.location.country.rawValue
            infoLabel.text = location

        case 2:
            infoLabel.text = person.email

        case 3:
            infoLabel.text = person.phone + "\n" + person.cell

        case 4:
            infoLabel.text = "You do not have the premium access.\nPlease navigate to payments screen."

        default:
            break
        }
    }
}
