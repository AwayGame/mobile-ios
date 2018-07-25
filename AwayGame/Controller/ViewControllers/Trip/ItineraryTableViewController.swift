//
//  ItineraryTableViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/30/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import CoreLocation
import UberRides
import UIKit

class ItineraryTableViewController: UITableViewController {

    var tripRequest: TripRequest?
    var tripTitle: String?
    
    private var currentLocation: CLLocationCoordinate2D?
    
    public var trip: Trip? {
        didSet {
            currentItinerary = trip?.itineraries?[currentItineraryIndex]
        }
    }
    
    private var cellHeights: [CGFloat] = []
    
    private var currentItineraryIndex: Int = 0
    private var currentItinerary: Itinerary? {
        didSet {
            cellHeights = [CGFloat].init(repeating: 0.0, count: currentItinerary?.activities?.count ?? 0)
            tableView.reloadData()
        }
    }
    
    weak var delegate: UserDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let itinerary = currentItinerary else { return 0 }
        return section == 1 ? (itinerary.activities?.count ?? 0) : 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let headerCell = tableView.dequeueReusableCell(withIdentifier: TripHeaderCell.identifier, for: indexPath) as? TripHeaderCell {
                headerCell.nextButton.isHidden = currentItineraryIndex >= (trip?.itineraries?.count ?? 0) - 1
                headerCell.previousButton.isHidden = currentItineraryIndex == 0
                headerCell.configureCell(withTitle: currentItinerary?.date ?? "" )
                headerCell.delegate = self
                return headerCell
            }
        } else {
            if let activityCell = tableView.dequeueReusableCell(withIdentifier: ActivityCell.identifier, for: indexPath) as? ActivityCell {
                activityCell.configureCell(with: currentItinerary?.activities?[indexPath.row])
                cellHeights[indexPath.row] = activityCell.cellHeight
                activityCell.delegate = self
                return activityCell
            }
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return TripHeaderCell.height
        } else {
            return cellHeights[indexPath.row]
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            performSegue(withIdentifier: "ActivitySegue", sender: indexPath)
        }
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ActivitySegue" {
            if let activityVC = segue.destination as? ActivityTableViewController {
                guard let indexPath = sender as? IndexPath else { return }
                activityVC.activity = currentItinerary?.activities?[indexPath.row]
                activityVC.activityIndex = indexPath.row
                activityVC.tripRequest = self.tripRequest
                activityVC.tripTitle = self.tripTitle
                activityVC.currentItinerary = self.currentItinerary
            }
        }
    }
    
}

// MARK: - TripDelegate

extension ItineraryTableViewController: TripDelegate {
    
    func previousDayTapped() {
        if currentItineraryIndex != 0 {
            currentItineraryIndex -= 1
            currentItinerary = trip?.itineraries?[currentItineraryIndex]
        }
    }
    
    func nextDayTapped() {
        if currentItineraryIndex < (trip?.itineraries?.count ?? 0) - 1 {
            currentItineraryIndex += 1
            currentItinerary = trip?.itineraries?[currentItineraryIndex]
        }
    }
    
    func saveTapped() {
        guard let trip = trip else { return }
        delegate?.user(User.currentUser, didSaveTrip: trip, tripRequest: self.tripRequest)
    }
    
}

// MARK: - ActivityDelegate

extension ItineraryTableViewController: ActivityDelegate {
    func didTapUber(withActivity activity: Activity?) {
        AGAnalytics.logEvent(.uberTapped, parameters: nil)
        let locationManager = CLLocationManager()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        let builder = RideParametersBuilder()
        let pickupLocation = currentLocation
        let dropoffLocation = CLLocation(latitude: activity?.location?.latitude ?? 0.0, longitude: activity?.location?.longitude ?? 0.0)
        builder.dropoffLocation = dropoffLocation
        builder.dropoffNickname = activity?.name ?? ""
        builder.dropoffAddress = activity?.address ?? ""
        let rideParameters = builder.build()
        let deeplink = RequestDeeplink(rideParameters: rideParameters, fallbackType: .mobileWeb)
        deeplink.execute()
    }
}

extension ItineraryTableViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        currentLocation = locValue
    }
    
}
