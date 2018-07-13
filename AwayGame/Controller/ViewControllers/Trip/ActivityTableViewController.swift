//
//  ActivityTableViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/30/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import MapKit
import UIKit

class ActivityTableViewController: UITableViewController {

    var currentItinerary: Itinerary?
    var tripRequest: TripRequest?
    var tripTitle: String?
    var activity: Activity? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AGAnalytics.logEvent(.activitySelected, parameters: nil)
        tableView.separatorStyle = .none
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NavigationHelper.setupNavigationController(self, withTitle: tripTitle ?? "")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : (activity?.isYelp ?? false) ? 5 : 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let pageCell = tableView.dequeueReusableCell(withIdentifier: TripHeaderCell.identifier, for: indexPath) as? TripHeaderCell {
                // TODO: Cleanup
                pageCell.nextButton.isHidden = self.activity?.placeId == currentItinerary?.activities?.last?.placeId
                pageCell.previousButton.isHidden = self.activity?.placeId == currentItinerary?.activities?.first?.placeId
                pageCell.saveButton.isHidden = true
                pageCell.dateLabel.text = self.activity?.name ?? ""
                return pageCell
            }
        } else {
            
            switch indexPath.row {
            case 0:
                if let activityImageCell = tableView.dequeueReusableCell(withIdentifier: ActivityImageTableViewCell.identifier, for: indexPath) as? ActivityImageTableViewCell {
                    activityImageCell.configureCell(withActivity: activity)
                    return activityImageCell
                }
                break
            case 1:
                if let activityDescriptionCell = tableView.dequeueReusableCell(withIdentifier: ActivityDescriptionTableViewCell.identifier, for: indexPath) as? ActivityDescriptionTableViewCell {
                    ActivityDescriptionTableViewCell.height = activityDescriptionCell.sizeThatFits(CGSize(width: tableView.bounds.width - 80.0, height: .greatestFiniteMagnitude)).height
                    activityDescriptionCell.configureCell(withActivity: activity)
                    return activityDescriptionCell
                }
                break
            case 2:
                if let activityDateTimeCell = tableView.dequeueReusableCell(withIdentifier: ActivityDateTimeTableViewCell.identifier, for: indexPath) as? ActivityDateTimeTableViewCell {
                    activityDateTimeCell.configureCell(withActivity: activity)
                    return activityDateTimeCell
                }
                break
            case 3:
                if activity?.isYelp ?? false {
                    if let activityRatingCell = tableView.dequeueReusableCell(withIdentifier: ActivityRatingTableViewCell.identifier, for: indexPath) as? ActivityRatingTableViewCell {
                        activityRatingCell.configureCell(withActivity: activity)
                        return activityRatingCell
                    }
                } else {
                    if let activityMapsCell = tableView.dequeueReusableCell(withIdentifier: ActivityMapsTableViewCell.identifier, for: indexPath) as? ActivityMapsTableViewCell {
                        activityMapsCell.configureCell(withActivity: activity)
                        return activityMapsCell
                    }
                }
                break
            case 4:
                if let activityMapsCell = tableView.dequeueReusableCell(withIdentifier: ActivityMapsTableViewCell.identifier, for: indexPath) as? ActivityMapsTableViewCell {
                    activityMapsCell.configureCell(withActivity: activity)
                    return activityMapsCell
                }
                break
            default:
                return UITableViewCell()
            }

        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (activity?.isYelp ?? false) && indexPath.row == 4 {
            openMapForPlace()
        } else if !(activity?.isYelp ?? true) && indexPath.row == 3 {
            openMapForPlace()
        }
    }
    
    func openMapForPlace() {
        AGAnalytics.logEvent(.mapTapped, parameters: nil)
        guard let activity = activity else { return }
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(activity.location?.latitude ?? 0.0, activity.location?.longitude ?? 0.0)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = activity.name ?? ""
        mapItem.openInMaps(launchOptions: options)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 { return TripHeaderCell.height}
        
        switch indexPath.row {
        case 0 :
            return ActivityImageTableViewCell.height
        case 1:
            return ActivityDescriptionTableViewCell.height
        case 2:
            return ActivityDateTimeTableViewCell.height
        case 3:
            if !(activity?.isYelp ?? true) {
                return ActivityMapsTableViewCell.height
            }
            return ActivityRatingTableViewCell.height
        case 4:
            return ActivityMapsTableViewCell.height
        default:
            return 0.0
        }
    }

}
