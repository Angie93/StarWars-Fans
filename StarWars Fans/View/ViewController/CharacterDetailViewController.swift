//
//  CharacterDetailViewController.swift
//  StarWars Fans
//
//  Created by Angela Velilla Aguirre on 25/8/18.
//  Copyright © 2018 Angela Velilla. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    var selectedCharacter:Character!
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var mass: UILabel!
    @IBOutlet weak var skinColor: UILabel!
    @IBOutlet weak var eyeColor: UILabel!
    @IBOutlet weak var hairColor: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadCharacterResources()
        loadCharacterData()
    }

    //MARK: - Private Methods
    
    fileprivate func loadCharacterResources() {
        name.font = StyleController.fontArialBoldWIthSize(size:25)
        name.textColor = StyleController.mainYellowColor()
        gender.font = StyleController.fontArialRegularWIthSize(size: 16)
        gender.textColor = UIColor.white
        year.font = StyleController.fontArialRegularWIthSize(size: 16)
        year.textColor = UIColor.white
        height.font = StyleController.fontArialRegularWIthSize(size: 16)
        height.textColor = UIColor.white
        mass.font = StyleController.fontArialRegularWIthSize(size: 16)
        mass.textColor = UIColor.white
        skinColor.font = StyleController.fontArialRegularWIthSize(size: 16)
        skinColor.textColor = UIColor.white
        eyeColor.font = StyleController.fontArialRegularWIthSize(size: 16)
        eyeColor.textColor = UIColor.white
        hairColor.font = StyleController.fontArialRegularWIthSize(size: 16)
        hairColor.textColor = UIColor.white
    }
    
    fileprivate func loadCharacterData() {
        self.title = selectedCharacter.name
        name.text = selectedCharacter.name
        gender.text = "Gender: " + selectedCharacter.gender
        year.text = "Birth year: " + selectedCharacter.birthYear
        height.text = "Height: " + selectedCharacter.height
        mass.text = "Mass: " + selectedCharacter.mass
        skinColor.text = "Skin color: " + selectedCharacter.skinColor
        eyeColor.text = "Eye color: " + selectedCharacter.eyeColor
        hairColor.text = "Hair color: " + selectedCharacter.hairColor
        
        let url = URL(string: selectedCharacter.image)
        let data = try? Data(contentsOf: url!)
        
        if let imageData = data {
            let image = UIImage(data: imageData)
            self.image.image = image
        }
    }

}
