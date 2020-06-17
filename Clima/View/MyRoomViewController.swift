//
//  MyRoomViewController.swift
//  Clima
//
//  Created by Rajat Jain on 21/03/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import FirebaseDatabase

class MyRoomViewController: UIViewController {
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var nh3Label: UILabel!
    @IBOutlet weak var coLabel: UILabel!
    @IBOutlet weak var lpgLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()

        // Do any additional setup after loading the view.
    }
    
  func getData(){
    let dataDB = Database.database().reference().child("Data")
         print(dataDB)
    dataDB.observeSingleEvent(of: .value) { (snapshot) in
        let snapshotValue = snapshot.value as? NSDictionary
        print(snapshotValue)
        let temp = snapshotValue?["temp"]
        let nh3 = snapshotValue?["nh3"]
        let co = snapshotValue?["co"]
        let lpg = snapshotValue?["lpg"]
        let humidity = snapshotValue?["humidity"]
        
        DispatchQueue.main.async {
            
            self.tempLabel.text = "Temperature : \(temp!)"
            self.nh3Label.text = "NH3 Level : \(nh3!)"
            self.lpgLabel.text = "LPG Level : \(lpg!)"
            self.coLabel.text = "CO Level : \(co!)"
            self.humidityLabel.text = "Humidity : \(humidity!)"
        }
     
       
    }
    }
    
    
     }




