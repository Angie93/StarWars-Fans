//
//  TitleTableViewCell.swift
//  StarWars Fans
//
//  Created by Angela Velilla Aguirre on 25/8/18.
//  Copyright © 2018 Angela Velilla. All rights reserved.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        loadLocalizedResources()
    }
    
    //MARK: - Public Methods
    
    func setTitleForCell(_ title: String) {
        self.title.text = title
    }
    
    
    fileprivate func loadLocalizedResources() {
        resetCell()
        title.font = StyleController.fontArialBoldWIthSize(size:20)
        title.textColor = StyleController.mainYellowColor()
        title.text = "Something goes wrong, try it again!"
    }
    
    fileprivate func resetCell() {
        self.title.text = ""
    }
    
}
