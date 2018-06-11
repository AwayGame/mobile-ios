//
//  ActivityCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/7/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class ActivityCell: UITableViewCell {

    static let identifier = "ActivityCell"
    static let height: CGFloat = 120.0
    
    var activity: Activity?
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Initialization
    
    func configureCell(with activity: Activity?) {
        print("ActivityCell configured")
        self.activity = activity
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = Theme.Color.clear
        collectionView.register(ActivityCollectionViewCell.self, forCellWithReuseIdentifier: ActivityCollectionViewCell.identifier)
        collectionView.reloadData()
        print(activity?.name)
    }

}

// MARK: - UICollectionViewDataSource

extension ActivityCell: UICollectionViewDataSource {

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let activityCell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityCollectionViewCell.identifier, for: indexPath) as? ActivityCollectionViewCell {
            activityCell.configureCell(activity: activity)
            print("HEEEEERE")
            return activityCell
        }
        return UICollectionViewCell()
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension ActivityCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.bounds.width, height: self.bounds.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 20, bottom: 20, right: 20)
    }
}

