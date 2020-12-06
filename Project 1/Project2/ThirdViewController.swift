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
    var NLat: String = ""
    var NLong: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locations = createArray()
        
        LocationTable.delegate=self;
        LocationTable.dataSource=self;
    

}
    @IBAction func addLocation(_ sender: Any) {
        let alert = UIAlertController(title: "New Location",
                                      message: "Add a new location",
                                      preferredStyle: .alert)
      
        alert.addTextField { (Latitude) in
            Latitude.text = ""
            Latitude.placeholder = "Latitude:"
        }
        
        alert.addTextField{ (Longitude) in
            Longitude.text = ""
            Longitude.placeholder = "Longitude:"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) {[unowned self] _ in
            let newlat = alert.textFields![0].text
            let newlong = alert.textFields![1].text
            appendArray(Latitude: newlat ?? "0.00", Longitude: newlong ?? "0.00")
            
        }
        
        let cancelAction = UIAlertAction(title:"Cancel", style: .cancel)
        
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true);
        
    }
    
    func appendArray(Latitude:String, Longitude:String)
    {
        let newLocation = Location(Latitude: Latitude, Longitude: Longitude);
        locations.append(newLocation);
        LocationTable.reloadData();
        
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

