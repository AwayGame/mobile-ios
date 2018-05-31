//
//  TripViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/30/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class TripViewController: UIViewController {

    public var tripRequest: TripRequest?
    
    @IBOutlet weak var tempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AwayGameAPI.createTrip(request: tripRequest) { response in
            self.tempLabel.text = response
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
