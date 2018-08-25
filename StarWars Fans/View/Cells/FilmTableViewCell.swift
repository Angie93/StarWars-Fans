//
//  FilmTableViewCell.swift
//  StarWars Fans
//
//  Created by Angela Velilla Aguirre on 25/8/18.
//  Copyright © 2018 Angela Velilla. All rights reserved.
//

import UIKit

class FilmTableViewCell: UITableViewCell {

    @IBOutlet weak var filmImage: UIImageView!
    @IBOutlet weak var filmName: UILabel!
    @IBOutlet weak var filmCrawl: UILabel!
    @IBOutlet weak var filmYear: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadLocalizedResources()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //MARK: - Public Methods
    
    func updateCellWithFilm(_ film: Film) {
        resetCell()
        self.filmName.text = film.title
        self.filmCrawl.text = film.openingCrawl
        let year = String(film.releaseDate.prefix(4))
        self.filmYear.text = year
        
        let url = URL(string: film.image)
        let data = try? Data(contentsOf: url!)
        
        if let imageData = data {
            let image = UIImage(data: imageData)
            self.filmImage.image = image
        }
    }
    
    //MARK: - Private Methods

    fileprivate func loadLocalizedResources() {
        filmName.font = StyleController.fontArialBoldWIthSize(size:17)
        filmName.textColor = StyleController.mainYellowColor()
        filmCrawl.font = StyleController.fontArialRegularWIthSize(size:15)
        filmCrawl.textColor = UIColor.white
        filmYear.font = StyleController.fontArialRegularWIthSize(size:13)
        filmYear.textColor = UIColor.white
    }
    
    fileprivate func resetCell() {
        self.filmImage.image = nil
        self.filmName.text = ""
        self.filmCrawl.text = ""
        self.filmYear.text = ""
    }
}
