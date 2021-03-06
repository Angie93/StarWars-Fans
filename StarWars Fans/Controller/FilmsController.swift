//
//  FilmsController.swift
//  StarWars Fans
//
//  Created by Angela Velilla Aguirre on 25/8/18.
//  Copyright © 2018 Angela Velilla. All rights reserved.
//

import Foundation
import Alamofire

protocol FilmsControllerDelegate: class {
    func finishFetchingCharactersForFilm(charactersArray: [Character])
}

class FilmsController {
    
    weak var delegate: FilmsControllerDelegate?
    var numOfCharacters:Int = 0
    
    
    func fetchStarWarsFilms( onSuccess: @escaping (([Film]) -> Void),
                             onError: @escaping ((_ error: NSError?) -> Void)) {
        
        let url = URL(string: "https://swapi.co/api/films/")
        var filmsResult: [Film] = []
        
        Alamofire.request(url!,
                          method: .get,
                          parameters: ["include_docs": "true"],
                          encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                //get JSON return value
                if let result = response.result.value {
                    let JSON = result as! NSDictionary
                    print(JSON)
                    
                    if let filmsArray = JSON["results"] as? Array<Any> {
                        
                        for currentFilm in filmsArray {
                            if let filmDict = currentFilm as? [String:Any] {
                                let film = self.mappFilm(filmDict: filmDict)
                                
                                if let filmOK = film {
                                    filmsResult.append(filmOK)
                                }
                            }
                        }
                    }
                    
                    if filmsResult.count > 0 {
                        onSuccess(filmsResult)
                    } else {
                        onError(self.createFilmError())
                    }
                } else {
                    onError(self.createFilmError())
                }
                
        }
        
    }
    
    func getCharactersOn(film: Film) {
        
        var charactersArray:[Character] = []
        numOfCharacters = film.charactersArray.count
        
        for currentChar in film.charactersArray {
            CharactersController().fetchStarWarsSpecificCharacter(urlString: currentChar,
                                                                  onSuccess: { (character) in
                                                                    charactersArray.append(character)
                                                                    if charactersArray.count == self.numOfCharacters {
                                                                    self.delegate?.finishFetchingCharactersForFilm(charactersArray: charactersArray)
                                                                        return
                                                                    }
            }) { (error) in
                self.numOfCharacters = self.numOfCharacters - 1
                print("Error getting character")
            }
        }
    }
    
    fileprivate func mappFilm(filmDict: [String: Any]) -> Film? {
        if let title = filmDict["title"] as? String,
            let episodeId = filmDict["episode_id"] as? Int,
            let openingCrawl = filmDict["opening_crawl"] as? String,
            let director = filmDict["director"] as? String,
            let producer = filmDict["producer"] as? String,
            let releaseDate = filmDict["release_date"] as? String,
            let charactersArray = filmDict["characters"] as? [String] {
            return Film(title: title,
                        episodeId: episodeId,
                        openingCrawl: openingCrawl,
                        director: director,
                        producer: producer,
                        releaseDate: releaseDate,
                        charactersArray: charactersArray)
        }
        return nil
    }
    
    fileprivate func createFilmError() -> NSError {
        return NSError(domain:"Error creating films", code:0, userInfo:nil)
    }
}
