//
//  PreferencesCollectionViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/14/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class PreferencesCollectionViewController: UICollectionViewController {

    public var type: PreferenceType?
    public var tripRequest: TripRequest?
    public var textData: [String]?
    public var imageData: [UIImage]?
    
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\n\n\n-----------------------")
        print(self.type)
        print(tripRequest?.preferences?.group)
        print(tripRequest?.preferences?.food)
        print(tripRequest?.preferences?.interests)
        print("\n\n\n-----------------------")
        
        guard let collectionView = self.collectionView else { return }
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
        collectionView.contentInset = .init(top: 8.0, left: 0.0, bottom: 8.0, right: 0.0)
        collectionView.alwaysBounceVertical = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupNavigation(controller: navigationController, hidesBar: false)
        guard let collectionView = self.collectionView else { return }
        collectionView.reloadData()
        
    }
    
    func setup(with title: String?, textData: [String]?, imageData: [UIImage]?) {
        self.title = title ?? ""
        self.textData = textData
        self.imageData = imageData
        
    }
    
    // MARK: UICollectionView Data Source
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 10
        } else {
            return 1
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
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
                            tripRequest?.preferences?.food?.append(cell.preferenceLabel.text ?? "")
                        }
                    }
                }
                preferencesVC.tripRequest = self.tripRequest
                preferencesVC.type = .Interest
                preferencesVC.setup(with: tripRequest?.eventName ?? "", textData: Preferences.Interest.text, imageData: Preferences.Interest.images)
            }
        } else if segue.identifier == "NightlifeSegue" {
            if let preferencesVC = segue.destination as? PreferencesCollectionViewController {
                if let paths = collectionView?.indexPathsForSelectedItems {
                    for indexPath in paths {
                        if let cell = collectionView?.cellForItem(at: indexPath) as? PreferenceCollectionCell {
                            tripRequest?.preferences?.interests?.append(cell.preferenceLabel.text ?? "")
                        }
                    }
                }
                preferencesVC.tripRequest = self.tripRequest
                preferencesVC.type = .Nightlife
                preferencesVC.setup(with: tripRequest?.eventName ?? "", textData: Preferences.Nightlife.text, imageData: Preferences.Nightlife.images)
            }
        }
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PreferencesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
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
        
        if type == .Food {
            performSegue(withIdentifier: "InterestsSegue", sender: self)
        } else if type == .Interest {
            performSegue(withIdentifier: "NightlifeSegue", sender: self)
        }
        
    }
    
}
