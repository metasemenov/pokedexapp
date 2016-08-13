//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Admin on 02.08.16.
//  Copyright © 2016 EvilData. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var pokemon: Pokemon!
   
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var MovesView: UIView!
    @IBOutlet weak var BioView: UIView!
    @IBOutlet weak var tableView: UITableView!			
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MovesView.hidden = true
        BioView.hidden = false
        nameLbl.text = pokemon.name.capitalizedString
        tableView.delegate = self
        tableView.dataSource = self
        
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImg.image = img
        currentEvoImg.image = img
        
        
        pokemon.downloadPokemonDetails { () -> () in
            self.updateUI()
            self.tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("MovesCell", forIndexPath: indexPath) as? MovesCell {
        var move = PokemonMoves(name: "Hit")
        
        if pokemon.moves.count > 0 {
            move = pokemon.moves[indexPath.row]
        }
        cell.configureCell(move)
        return cell
    } else {
    return UITableViewCell()
    }
}


    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if pokemon.moves.count > 0 {
            return pokemon.moves.count
        }
        return 1
    }
    
    
    
    func updateUI() {
        descriptionLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        baseAttackLbl.text = pokemon.attack
        pokedexLbl.text = "\(pokemon.pokedexId)"
        
        if pokemon.nextEvoId == "" {
            evoLbl.text = "No evolutions"
            nextEvoImg.hidden = true
        } else {
            nextEvoImg.hidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvoId)
            var str = "Next Evolution: \(pokemon.nextEvoTxt)"
            
            if pokemon.nextEvoLvl != "" {
                str += " - LVL \(pokemon.nextEvoLvl)"
                evoLbl.text = str
            }
         }
        
        
    }

   
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func SegmentedControl(sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            MovesView.hidden = true
            BioView.hidden = false
            
        case 1:
            MovesView.hidden = false
            BioView.hidden = true
            
        default:
            break;
        }
        
    }

}
