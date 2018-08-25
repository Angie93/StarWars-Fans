//
//  ErrorTableViewCell.swift
//  StarWars Fans
//
//  Created by Angela Velilla Aguirre on 25/8/18.
//  Copyright © 2018 Angela Velilla. All rights reserved.
//

import UIKit

class ErrorTableViewCell: UITableViewCell {

    @IBOutlet weak var errorLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        loadLocalizedResources()
    }

    //MARK: - Private methods
    
    fileprivate func loadLocalizedResources() {
        resetCell()
        errorLabel.font = StyleController.fontArialBoldWIthSize(size:18)
        errorLabel.textColor = StyleController.mainYellowColor()
        errorLabel.text = "Something goes wrong, try it again!"
    }
    
    fileprivate func resetCell() {
        self.errorLabel.text = ""
    }

}
