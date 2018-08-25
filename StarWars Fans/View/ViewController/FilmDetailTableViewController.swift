//
//  FilmDetailTableViewController.swift
//  StarWars Fans
//
//  Created by Angela Velilla Aguirre on 25/8/18.
//  Copyright © 2018 Angela Velilla. All rights reserved.
//

import UIKit

class FilmDetailTableViewController: UITableViewController {

    var selectedFilm:Film!
    var charactersArray:[Character] = []
    var hasError = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewResources()
    }

    fileprivate func loadViewResources() {
        self.tabBarController?.navigationItem.title = selectedFilm.title
        self.tableView.register(UINib(nibName: "FilmTableViewCell", bundle: nil), forCellReuseIdentifier: "filmCell")
        self.tableView.register(UINib(nibName: "ErrorTableViewCell", bundle: nil), forCellReuseIdentifier: "errorCell")
        self.tableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "characterCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        charactersArray = FilmsController().getCharactersOn(film: selectedFilm)
        hasError = charactersArray.count <= 0
        
        tableView.reloadData()
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
            case 2:
                return charactersArray.count + 1
            default:
                return 1
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
                let cellIdentifier = ""
                let cell = <#value#>
                
                return cell
                
            default:
                <#code#>
            }
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
