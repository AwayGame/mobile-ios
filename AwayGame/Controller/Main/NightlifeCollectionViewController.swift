//
//  NightlifeCollectionViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/14/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class NightlifeCollectionViewController: UICollectionViewController {
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let collectionView = self.collectionView else { return }
        collectionView.delegate = self
        collectionView.allowsSelection = true
        collectionView.contentInset = .init(top: 8.0, left: 0.0, bottom: 8.0, right: 0.0)
        collectionView.alwaysBounceVertical = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupNavigation(controller: navigationController, hidesBar: false)
        self.title = "lorem ipsum"
        guard let collectionView = self.collectionView else { return }
        collectionView.reloadData()
        
    }
    
    // MARK: - Storyboard
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItinerarySegue" {
            if let destination = segue.destination as? ItineraryTableViewController {
            }
        }
    }
    
    // MARK: UICollectionView Data Source
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 10
        } else {
            return 0 //1 - next button cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            if let preferenceCell = collectionView.dequeueReusableCell(withReuseIdentifier: PreferenceCollectionCell.identifier, for: indexPath) as? PreferenceCollectionCell {
                preferenceCell.configureCell(title: Constants.Preferences.Nightlife.text[indexPath.row], image: nil)
                return preferenceCell
            }
        }
        return UICollectionViewCell()
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension NightlifeCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: self.view.bounds.width / 2 - 30, height: 216.0)
        } else {
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return .zero
        } else {
            return UIEdgeInsets(top: 8, left: 20, bottom: 20, right: 20)
        }
    }
    
}


