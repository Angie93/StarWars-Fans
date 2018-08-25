//
//  FilmsTableViewController.swift
//  StarWars Fans
//
//  Created by Angela Velilla Aguirre on 25/8/18.
//  Copyright © 2018 Angela Velilla. All rights reserved.
//

import UIKit

class FilmsTableViewController: UITableViewController {

    var filmsArray:[Film] = []
    var hasError = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationItem.title = "Films"
        self.tableView.register(UINib(nibName: "FilmTableViewCell", bundle: nil), forCellReuseIdentifier: "filmCell")
        self.tableView.register(UINib(nibName: "ErrorTableViewCell", bundle: nil), forCellReuseIdentifier: "errorCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        startFetchingFilms()
    }
    
    fileprivate func startFetchingFilms() {
        
        FilmsController().fetchStarWarsFilms(onSuccess: { (filmsArray) in
            self.hasError = false
            self.filmsArray = filmsArray
            self.tableView.rowHeight = 220
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
        return hasError ? 1 : filmsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if hasError {
            let cellIdentifier = "errorCell"
            let cell: ErrorTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ErrorTableViewCell
            return cell
        } else {
            let cellIdentifier = "filmCell"
            let cell: FilmTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FilmTableViewCell
            
            cell.updateCellWithFilm(filmsArray[indexPath.row])
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if hasError {
            startFetchingFilms()
            
        } else {
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
//        productSelected = productsArray[indexPath.row]
//        performSegue(withIdentifier: "segueToDetail", sender: self)

    }
    
}

