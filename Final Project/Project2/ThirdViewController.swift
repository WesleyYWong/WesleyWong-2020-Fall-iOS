//
//  ThirdViewController.swift
//  Project2
//
//  Created by user180084 on 12/5/20.
//

import UIKit
import CoreData
class ThirdViewController: UIViewController {

    @IBOutlet weak var LocationTable: UITableView!
    
    var locations: [LocationHolder] = []
    var testCore: [NSManagedObject] = []
    var NLat: String = ""
    var NLong: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //locations = createArray()
        
        LocationTable.delegate=self;
        LocationTable.dataSource=self;
    

}
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
              return
          }
          
          let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Locations")
        
        do {
            testCore = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("could not fetch. \(error), \(error.userInfo)")
        }
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
        let newLocation = LocationHolder(Latitude: Latitude, Longitude: Longitude);
        locations.append(newLocation);
        save(newLoc: newLocation);
        LocationTable.reloadData();
        
    }
    func createArray() -> [LocationHolder] {
        var exampleLocation: [LocationHolder] = []
        
        let location1 = LocationHolder(Latitude:"32.4", Longitude:"40.4")
        let location2 = LocationHolder(Latitude:"35.0", Longitude:"47.1")
        let location3 = LocationHolder(Latitude:"39.47", Longitude:"43.1")
        
        exampleLocation.append(location1);
        exampleLocation.append(location2);
        exampleLocation.append(location3);
        save(newLoc: location1)
        save(newLoc: location2)
        save(newLoc: location3)
        
        return exampleLocation;
    }
    
    func save(newLoc: LocationHolder) {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Locations", in: managedContext)!
        
        let location = NSManagedObject(entity: entity, insertInto: managedContext)
        
        location.setValue(newLoc.Latitude, forKey: "latitude")
        location.setValue(newLoc.Longitude, forKey: "longitude")
        
        do {
            try managedContext.save()
            testCore.append(location)
        } catch let error as NSError {
            print("could not save. \(error), \(error.userInfo)")
        }
    }

}

extension ThirdViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        testCore.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let location = testCore[indexPath.row];
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell") as! LocationCell;
        
        let latitude = location.value(forKeyPath: "latitude") as! String
        let longitude = location.value(forKeyPath: "longitude") as! String
        cell.setLocation(Location: LocationHolder(Latitude: latitude, Longitude: longitude));
        
        return cell;
    }
}

