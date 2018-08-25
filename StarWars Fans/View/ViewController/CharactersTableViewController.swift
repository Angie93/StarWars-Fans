//
//  CharactersTableViewController.swift
//  StarWars Fans
//
//  Created by Angela Velilla Aguirre on 25/8/18.
//  Copyright © 2018 Angela Velilla. All rights reserved.
//

import UIKit

class CharactersTableViewController: UITableViewController {

    var charactersArray:[Character] = []
    var characterSelected:Character!
    
    var hasError = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.navigationItem.title = "Characters"
        self.navigationController?.title = "Characters"
        self.tableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "characterCell")
        self.tableView.register(UINib(nibName: "ErrorTableViewCell", bundle: nil), forCellReuseIdentifier: "errorCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        fetchCharacters()
    }

    fileprivate func fetchCharacters() {
        
        CharactersController().fetchStarWarsAllCharacters(onSuccess: { (charactersArray) in
            self.hasError = false
            self.charactersArray = charactersArray
            self.tableView.rowHeight = 100
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }) { (error) in
            self.hasError = true
            self.tableView.rowHeight = self.tableView.frame.height - 100
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hasError ? 1 : charactersArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if hasError {
            let cellIdentifier = "errorCell"
            let cell: ErrorTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ErrorTableViewCell
            return cell
        } else {
            let cellIdentifier = "characterCell"
            let cell: CharacterTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CharacterTableViewCell
            
            cell.updateCellWithCharacter(charactersArray[indexPath.row])
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if hasError {
            fetchCharacters()
            
        } else {
            characterSelected = charactersArray[indexPath.row]
            performSegue(withIdentifier: "segueToCharacterDetail", sender: self)
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToCharacterDetail" {
            let destinationVC :CharacterDetailViewController = segue.destination as! CharacterDetailViewController
            destinationVC.selectedCharacter = characterSelected
        }
    }

}
