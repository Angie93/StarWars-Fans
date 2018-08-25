//
//  CharactersController.swift
//  StarWars Fans
//
//  Created by Angela Velilla Aguirre on 25/8/18.
//  Copyright © 2018 Angela Velilla. All rights reserved.
//

import Foundation
import Alamofire

class CharactersController {
    
    func fetchStarWarsFilms( onSuccess: (([Character]) -> Void)?,
                             onError: ((_ error: Error?) -> Void)?) {
        
        let url = URL(string: "https://swapi.co/api/people/")
        var charactersResult: [Character] = []
        
        Alamofire.request(url!, method: .get, parameters: ["include_docs": "true"], encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                //to get status code
                if let status = response.response?.statusCode {
                    switch(status){
                    case 201:
                        print("example success")
                    default:
                        print("error with response status: \(status)")
                    }
                }
                //get JSON return value
                if let result = response.result.value {
                    let JSON = result as! NSDictionary
                    print(JSON)
                    
                    if let charactersArray = JSON["results"] as? Array<Any> {
                        
                        for currentChar in charactersArray {
                            if let characterDict = currentChar as? [String:Any] {
                                let character = self.mappCharacters(characterDict: characterDict)
                                //Hacer la comprobacion de si character no es nil
                                if let characterOK = character {
                                    charactersResult.append(characterOK)
                                } else {
                                    let error: Error = Error()
                                    onError(
                                }
                            }
                            
                        }
                    }
                    
                }
                
        }
        
    }
    
    fileprivate func mappCharacters(characterDict: [String: Any]) -> Character? {
        if let name = characterDict["name"] as? String,
            let height = characterDict["height"] as? String,
            let mass = characterDict["mass"] as? String,
            let hairColor = characterDict["hair_color"] as? String,
            let skinColor = characterDict["skin_color"] as? String,
            let eyeColor = characterDict["eye_color"] as? String,
            let birthYear = characterDict["birth_year"] as? String,
            let gender = characterDict["gender"] as? String {
            return Character(name: name,
                             height: height,
                             mass: mass,
                             hairColor: hairColor,
                             skinColor: skinColor,
                             eyeColor: eyeColor,
                             birthYear: birthYear,
                             gender: gender)
        }
        return nil
    }
}
