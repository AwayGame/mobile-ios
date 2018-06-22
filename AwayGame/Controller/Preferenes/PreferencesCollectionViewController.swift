//
//  PreferencesCollectionViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/14/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class PreferencesCollectionViewController: UICollectionViewController {

    public var preferenceType: PreferenceType?
    public var tripRequest: TripRequest?
    public var textData: [String]?
    public var imageData: [UIImage]?
    
    weak var delegate: UserDelegate?
    
    let titleView = NavigationBarTitleView(frame: CGRect(origin: .zero, size: CGSize(width: 240.0, height: 36.0)))
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let collectionView = self.collectionView else { return }
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
        //collectionView.contentInset = .init(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        collectionView.alwaysBounceVertical = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupNavigation(controller: navigationController, hidesBar: false)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: titleView)
        titleView.setTitle(tripRequest?.eventName ?? "")
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
        if section == 0 {
            return 1
        } else if section == 1 {
            return 10
        } else {
            return 1
        }
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
                nextCell.configureCell()
                nextCell.delegate = self
                return nextCell
            }
        }
        return UICollectionViewCell()
    
    }
    
    // MARK: - Storyboard
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InterestsSegue" {
            if let preferencesVC = segue.destination as? PreferencesCollectionViewController {
                if let paths = collectionView?.indexPathsForSelectedItems {
                    for indexPath in paths {
                        if let cell = collectionView?.cellForItem(at: indexPath) as? PreferenceCollectionCell {
                            tripRequest?.preferences?.food?.append(Preferences.Food.requestStrings[indexPath.row])
                        }
                    }
                }
                preferencesVC.tripRequest = self.tripRequest
                preferencesVC.preferenceType = .Interest
                preferencesVC.delegate = self
                preferencesVC.setup(with: tripRequest?.eventName ?? "", textData: Preferences.Interest.text, imageData: Preferences.Interest.images)
            }
        } else if segue.identifier == "NightlifeSegue" {
            if let preferencesVC = segue.destination as? PreferencesCollectionViewController {
                if let paths = collectionView?.indexPathsForSelectedItems {
                    for indexPath in paths {
                        if let cell = collectionView?.cellForItem(at: indexPath) as? PreferenceCollectionCell {
                            tripRequest?.preferences?.interests?.append(Preferences.Interest.requestStrings[indexPath.row])
                        }
                    }
                }
                preferencesVC.tripRequest = self.tripRequest
                preferencesVC.preferenceType = .Nightlife
                preferencesVC.delegate = self
                preferencesVC.setup(with: tripRequest?.eventName ?? "", textData: Preferences.Nightlife.text, imageData: Preferences.Nightlife.images)
            }
        } else if segue.identifier == "TripSegue" {
            if let tripVC = segue.destination as? TripViewController {
                if let paths = collectionView?.indexPathsForSelectedItems {
                    for indexPath in paths {
                        if let cell = collectionView?.cellForItem(at: indexPath) as? PreferenceCollectionCell {
                            tripRequest?.preferences?.nightlife?.append(Preferences.Nightlife.requestStrings[indexPath.row])
                        }
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
            return CGSize(width: self.view.bounds.width - 40, height: 56.0)
        } else if indexPath.section == 1 {
            return CGSize(width: self.view.bounds.width / 2 - 30, height: 120.0)
        } else {
            return CGSize(width: self.view.bounds.width - 40, height: 60.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 8, left: 20, bottom: 20, right: 20)
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
    func user(_ user: User, didSaveTrip trip: Trip) {
        navigationController?.popViewController(animated: false)
        print("popping Preferences...")
        delegate?.user(user, didSaveTrip: trip)
    }
}
