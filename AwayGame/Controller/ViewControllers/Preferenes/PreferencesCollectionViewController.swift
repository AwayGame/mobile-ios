//
//  PreferencesCollectionViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/14/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class PreferencesCollectionViewController: UICollectionViewController {

    public var preferenceType: PreferenceType? = .Food
    public var tripRequest: TripRequest?
    public var textData: [String]?
    public var imageData: [UIImage]?
    
    weak var delegate: UserDelegate?
    
    private var nextIsEnabled = false
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let collectionView = self.collectionView else { return }
        self.clearsSelectionOnViewWillAppear = false
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
        collectionView.alwaysBounceVertical = true
        
        guard let type = preferenceType else { return }
        AGAnalytics.logEvent(.preferencesPageDidDisplay(type: type.description), parameters: nil)

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NavigationHelper.setupNavigationController(self, withTitle: tripRequest?.eventName ?? "")
        guard let collectionView = self.collectionView else { return }
        collectionView.reloadData()
    }
    
    func setup(with title: String?, textData: [String]?, imageData: [UIImage]?) {
        self.textData = textData
        self.imageData = imageData
    }
    
    // MARK: UICollectionView Data Source
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 1 ? (textData?.count ?? 0) : 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            if let preferenceHeaderCell = collectionView.dequeueReusableCell(withReuseIdentifier: PreferenceHeaderCell.identifier, for: indexPath) as? PreferenceHeaderCell {
                
                guard let type = preferenceType else { return UICollectionViewCell() }
                
                switch type {
                case .Food:
                    preferenceHeaderCell.configureCell(text: "What's to eat?")
                case .Interest:
                    preferenceHeaderCell.configureCell(text: "What do you want to do?")
                case .Nightlife:
                    preferenceHeaderCell.configureCell(text: "What's the nighttime move?")
                }
                return preferenceHeaderCell
            }
        } else if indexPath.section == 1 {
            if let preferenceCell = collectionView.dequeueReusableCell(withReuseIdentifier: PreferenceCollectionCell.identifier, for: indexPath) as? PreferenceCollectionCell {
                preferenceCell.configureCell(title: textData?[indexPath.row], image: imageData?[indexPath.row])
                return preferenceCell
            }
        } else {
            if let nextCell = collectionView.dequeueReusableCell(withReuseIdentifier: NextButtonCollectionCell.identifier, for: indexPath) as? NextButtonCollectionCell {
                nextCell.delegate = self
                nextCell.nextButton.isEnabled = nextIsEnabled
                return nextCell
            }
        }
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let preferenceCell = collectionView.dequeueReusableCell(withReuseIdentifier: PreferenceCollectionCell.identifier, for: indexPath) as? PreferenceCollectionCell {
            AGAnalytics.logEvent(.preferenceSelected(title: preferenceCell.preferenceLabel.text ?? "", type: preferenceType?.description ?? ""), parameters: nil)
        }
       
        if let paths = collectionView.indexPathsForSelectedItems {
            nextIsEnabled = paths.count > 2
            collectionView.reloadItems(at: [IndexPath(row: 0, section: 2)])
        }
    }
    
    // MARK: - Storyboard
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InterestsSegue" {
            if let preferencesVC = segue.destination as? PreferencesCollectionViewController {
                tripRequest?.preferences?.food = []
                if let paths = collectionView?.indexPathsForSelectedItems {
                    for indexPath in paths {
                        tripRequest?.preferences?.food?.append(Preferences.Food.requestStrings[indexPath.row])
                    }
                }
                preferencesVC.tripRequest = self.tripRequest
                preferencesVC.preferenceType = .Interest
                preferencesVC.delegate = self
                preferencesVC.setup(with: tripRequest?.eventName ?? "", textData: Preferences.Interest.text, imageData: Preferences.Interest.images)
            }
        } else if segue.identifier == "NightlifeSegue" {
            if let preferencesVC = segue.destination as? PreferencesCollectionViewController {
                tripRequest?.preferences?.interests = []
                if let paths = collectionView?.indexPathsForSelectedItems {
                    for indexPath in paths {
                        tripRequest?.preferences?.interests?.append(Preferences.Interest.requestStrings[indexPath.row])
                    }
                }
                preferencesVC.tripRequest = self.tripRequest
                preferencesVC.preferenceType = .Nightlife
                preferencesVC.delegate = self
                preferencesVC.setup(with: tripRequest?.eventName ?? "", textData: Preferences.Nightlife.text, imageData: Preferences.Nightlife.images)
            }
        } else if segue.identifier == "TripSegue" {
            if let tripVC = segue.destination as? TripViewController {
                tripRequest?.preferences?.nightlife = []
                if let paths = collectionView?.indexPathsForSelectedItems {
                    for indexPath in paths {
                        tripRequest?.preferences?.nightlife?.append(Preferences.Nightlife.requestStrings[indexPath.row])
                    }
                }
                tripVC.tripRequest = self.tripRequest
                tripVC.delegate = self
            }
        }
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PreferencesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: self.view.bounds.width - 40, height: PreferenceHeaderCell.height)
        } else if indexPath.section == 1 {
            return CGSize(width: self.view.bounds.width / 2 - 30, height: PreferenceCollectionCell.height)
        } else {
            return CGSize(width: self.view.bounds.width - 40, height: NextButtonCollectionCell.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return section == 0 ? UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) :
               section == 1 ? UIEdgeInsets(top: 8, left: 20, bottom: 0, right: 20) :
                              UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
    }
    
}

// MARK: - NextButtonDelegate

extension PreferencesCollectionViewController: NextDelegate {
    
    func didTapNext() {
        if let paths = collectionView?.indexPathsForSelectedItems {
            if paths.count < 3 {
                print("Need to select at least 3 items")
                return
            }
        }
        
        if preferenceType == .Food {
            performSegue(withIdentifier: "InterestsSegue", sender: self)
        } else if preferenceType == .Interest {
            performSegue(withIdentifier: "NightlifeSegue", sender: self)
        } else if preferenceType == .Nightlife {
            performSegue(withIdentifier: "TripSegue", sender: self)
        }
    }
    
}

extension PreferencesCollectionViewController: UserDelegate {
    func user(_ user: User, didSaveTrip trip: Trip, tripRequest: TripRequest?) {
        navigationController?.popViewController(animated: false)
        print("popping Preferences...")
        delegate?.user(user, didSaveTrip: trip, tripRequest: tripRequest)
    }
}
