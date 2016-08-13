//
//  MovesCell.swift
//  pokedex
//
//  Created by Admin on 11.08.16.
//  Copyright © 2016 EvilData. All rights reserved.
//

import UIKit

class MovesCell: UITableViewCell {
    
    
    @IBOutlet weak var moveName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configureCell(move: PokemonMoves) {
        moveName.text = move.name
    }

}
