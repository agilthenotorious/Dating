//
//  FavouriteTableViewCell.swift
//  Dating
//
//  Created by Agil Madinali on 10/29/20.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var favouritePersonImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    
    // MARK: - Properties
    
    static let identifier = "FavouriteTableViewCell"
    
    // MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        editImageView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func editImageView() {
        favouritePersonImage.layer.cornerRadius = favouritePersonImage.bounds.width / 2
        favouritePersonImage.layer.borderWidth = 0.5
        favouritePersonImage.layer.borderColor = UIColor.lightGray.cgColor
    }

    func setInfo(person: Person) {
        nameLabel.text = person.fullName
        ageLabel.text = person.age

        NetworkManager.manager.downloadImage(with: person.picture.large) { results in
            switch results {
            case .success(let image):
                self.favouritePersonImage.image = image
                
            case .failure(let error):
                print(error.localizedDescription, " in FavouriteTableViewCell")
            }
        }
    }
}
