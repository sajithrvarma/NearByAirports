//
//  AirportTableViewCell.swift
//  NearbyAirports
//
//  Created by Sajith Ramavarma on 14/06/19.
//  Copyright © 2019 Sajith Ramavarma. All rights reserved.
//

import UIKit

class AirportTableViewCell: UITableViewCell {

    @IBOutlet weak var runwayLength: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(airport: Airport){
        if  airport.name?.count ?? 0 < 1{
            name.text = airport.city
        }else{
            name.text = airport.name
        }
        country.text = airport.country 
        runwayLength.text = airport.runwayLength ?? "-"
        
    }
 
}
