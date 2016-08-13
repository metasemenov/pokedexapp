//
//  PokemonMoves.swift
//  pokedex
//
//  Created by Admin on 11.08.16.
//  Copyright © 2016 EvilData. All rights reserved.
//

import Foundation

class PokemonMoves {

    private var _name: String!

    var name: String {
        return _name
    }
    
    init(name: String) {
        self._name = name.capitalizedString
    }
    
}