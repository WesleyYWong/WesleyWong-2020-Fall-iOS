//
//  ThirdViewController.swift
//  Project2
//
//  Created by user180084 on 12/5/20.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var LocationTable: UITableView!
    
    var locations: [Location] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locations = createArray()
        
        LocationTable.delegate=self;
        LocationTable.dataSource=self;
    

}
    
    func createArray() -> [Location] {
        var exampleLocation: [Location] = []
        
        let location1 = Location(Latitude:"32.4", Longitude:"40.4")
        let location2 = Location(Latitude:"35.0", Longitude:"47.1")
        let location3 = Location(Latitude:"39.47", Longitude:"43.1")
        
        exampleLocation.append(location1);
        exampleLocation.append(location2);
        exampleLocation.append(location3);
        
        return exampleLocation;
    }

}

extension ThirdViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locations.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let location = locations[indexPath.row];
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell") as! LocationCell;
        
        cell.setLocation(Location: location);
        
        return cell;
    }
}

