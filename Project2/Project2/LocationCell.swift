//
//  LocationCell.swift
//  Project2
//
//  Created by user180084 on 12/6/20.
//

import UIKit

class LocationCell: UITableViewCell {

    @IBOutlet weak var Latitude: UILabel!
    @IBOutlet weak var Longitutde: UILabel!
    
    func setLocation(Location: LocationHolder){
        self.Longitutde.text = "Long: " + Location.Longitude;
        self.Latitude.text = "Lat: " + Location.Latitude	;
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
