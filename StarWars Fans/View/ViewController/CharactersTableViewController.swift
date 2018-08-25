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
    var hasError = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Characters"
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
