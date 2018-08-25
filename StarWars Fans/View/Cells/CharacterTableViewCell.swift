//
//  CharacterTableViewCell.swift
//  StarWars Fans
//
//  Created by Angela Velilla Aguirre on 25/8/18.
//  Copyright © 2018 Angela Velilla. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterGender: UILabel!
    @IBOutlet weak var characterBirthday: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Public methods
    
    func updateCellWithCharacter(_ character: Character) {
        resetCell()
        let url = URL(string: character.image)
        let data = try? Data(contentsOf: url!)
        
        if let imageData = data {
            let image = UIImage(data: imageData)
            self.characterImage.image = image
        }
        
        self.characterName.text = character.name
        self.characterGender.text = character.gender
        self.characterBirthday.text = character.birthYear
    }
    
    //MARK: - Private methods
    
    fileprivate func loadLocalizedResources() {
        characterName.font = StyleController.fontArialBoldWIthSize(size:18)
        characterName.textColor = StyleController.mainYellowColor()
        characterGender.font = StyleController.fontArialRegularWIthSize(size:16)
        characterGender.textColor = UIColor.white
        characterBirthday.font = StyleController.fontArialRegularWIthSize(size:16)
        characterBirthday.textColor = UIColor.white
    }
    
    fileprivate func resetCell() {
        self.characterImage.image = nil
        self.characterName.text = ""
        self.characterGender.text = ""
        self.characterBirthday.text = ""
    }
    
}
