//
//  Pokemon.swift
//  pokedex
//
//  Created by Admin on 27.07.16.
//  Copyright © 2016 EvilData. All rights reserved.
//

import Foundation
import Alamofire


class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _height: String!
    private var _type: String!
    private var _defense: String!
    private var _attack: String!
    private var _weight: String!
    private var _nextEvoTxt: String!
    private var _pokemonUrl: String!
    private var _nextEvoId: String!
    private var _nextEvoLvl: String!
    
    var description: String {
        
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var height: String {
        
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var type: String {
        
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var attack: String {
        
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var weight: String {
        
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var nextEvoTxt: String {
        
        if _nextEvoTxt == nil {
            _nextEvoTxt = ""
        }
        return _nextEvoTxt
    }
    
    var nextEvoId: String {
        
        if _nextEvoId == nil {
            _nextEvoId = ""
        }
        return _nextEvoId
    }
    
    var nextEvoLvl: String {
        
        if _nextEvoLvl == nil {
            _nextEvoLvl = ""
        }
        return _nextEvoLvl
    }
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name: String, pokedexId:Int) {
        self._pokedexId = pokedexId
        self._name = name
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
        
    }
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        
        
        let url = NSURL(string: _pokemonUrl)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0  {
                    
                    if let type = types[0]["name"] {
                        self._type = type.capitalizedString
                    }
                    
                    if types.count > 1 {
                        
                        for x in 1 ..< types.count {
                            if let type = types[x]["name"] {
                                self._type! += "/\(type.capitalizedString)"
                            }
                        }
                        
                    }
                } else {
                    self._type = ""
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] where descArr.count > 0 {
                    
                    if let url = descArr[0]["resource_uri"] {
                        let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                        
                        Alamofire.request(.GET, nsurl).responseJSON { response in
                            
                            let desResult = response.result
                            if let descDict = desResult.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descDict["description"] as? String {
                                    self._description = description
                                   print(self._description)
                                }
                            }
                            
                            completed()
                            
                        }
                    }
                } else {
                    self._description = ""
                }
                
                if let evolution = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolution.count > 0 {
                    
                    if let to = evolution[0]["to"] as? String {
                        
                        if to.rangeOfString("mega") == nil {
                            
                           if let uri = evolution[0]["resource_uri"] as? String {
                                
                                let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                            
                                self._nextEvoId = num
                                self._nextEvoTxt = to
                            
                            if let lvl = evolution[0]["level"] as? Int {
                                self._nextEvoLvl = "\(lvl)"
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    
}