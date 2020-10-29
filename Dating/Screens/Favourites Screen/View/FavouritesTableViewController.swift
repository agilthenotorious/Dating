//
//  FavouritesTableViewController.swift
//  Dating
//
//  Created by Agil Madinali on 10/29/20.
//

import UIKit

class FavouritesTableViewController: UITableViewController {

    // MARK: - Properties

    static let identifier = "FavouritesTableViewController"
    var datingViewModel: DatingViewModel?
    var favouritesViewModel: FavouritesViewModel?
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favouritesViewModel = FavouritesViewModel(delegate: self, dataSource: datingViewModel)
        setupView()
    }
    
    func setupView() {
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouritesViewModel?.getFavouritesCount() ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteTableViewCell.identifier,
                                                       for: indexPath) as? FavouriteTableViewCell
        else { fatalError("Cell cannot be dequeued!") }

        if let person = favouritesViewModel?.getPerson(at: indexPath.row) {
            cell.setInfo(person: person)
        }
        return cell
    }
}

// MARK: - FavouritesViewModelProtocol

extension FavouritesTableViewController: FavouritesViewModelProtocol {}
