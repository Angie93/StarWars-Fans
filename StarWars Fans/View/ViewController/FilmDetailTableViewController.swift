//
//  FilmDetailTableViewController.swift
//  StarWars Fans
//
//  Created by Angela Velilla Aguirre on 25/8/18.
//  Copyright © 2018 Angela Velilla. All rights reserved.
//

import UIKit

class FilmDetailTableViewController: UITableViewController, FilmsControllerDelegate {

    var selectedFilm:Film!
    var charactersArray:[Character] = []
    var characterSelected:Character!
    
    var hasError = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewResources()
    }

    fileprivate func loadViewResources() {
        self.title = selectedFilm.title
        self.tableView.register(UINib(nibName: "FilmTableViewCell", bundle: nil), forCellReuseIdentifier: "filmCell")
        self.tableView.register(UINib(nibName: "ErrorTableViewCell", bundle: nil), forCellReuseIdentifier: "errorCell")
        self.tableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "characterCell")
        self.tableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "titleCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let filmController = FilmsController()
        filmController.delegate = self
        filmController.getCharactersOn(film: selectedFilm)
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return hasError ? 1 : 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if hasError {
            return 1
        } else {
            switch section {
            case 1:
                return charactersArray.count + 1
            default:
                return 1
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if hasError {
            return self.tableView.frame.height - 100
        } else {
            switch indexPath.section {
            case 0:
                return 220
            default:
                return indexPath.row == 0 ? 44 : 100
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if hasError {
            let cellIdentifier = "errorCell"
            let cell: ErrorTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ErrorTableViewCell
            return cell
        } else {
            switch indexPath.section {
            case 0:
                let cellIdentifier = "filmCell"
                let cell:FilmTableViewCell  = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FilmTableViewCell
                cell.updateCellWithFilm(selectedFilm)
                return cell
                
            default:
                if indexPath.row == 0 {
                    let cellIdentifier = "titleCell"
                    let cell:TitleTableViewCell  = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TitleTableViewCell
                    cell.setTitleForCell("Film characters")
                    return cell
                } else {
                    let cellIdentifier = "characterCell"
                    let cell:CharacterTableViewCell  = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CharacterTableViewCell
                    cell.updateCellWithCharacter(charactersArray[indexPath.row-1])
                    return cell
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if hasError {
            loadViewResources()
        } else {
            if indexPath.section == 1 && indexPath.row != 0 {
                characterSelected = charactersArray[indexPath.row-1]
                performSegue(withIdentifier: "segueFromFilmDetailToCharacterDetail", sender: self)
            }
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueFromFilmDetailToCharacterDetail" {
            let destinationVC :CharacterDetailViewController = segue.destination as! CharacterDetailViewController
            destinationVC.selectedCharacter = characterSelected
            
        }
    }
    
    // MARK: - Films Controller Delegate
    func finishFetchingCharactersForFilm(charactersArray: [Character]) {
        self.charactersArray = charactersArray
        hasError = charactersArray.count <= 0
        tableView.estimatedRowHeight = 44
        tableView.reloadData()
    }

}
