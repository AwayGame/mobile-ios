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
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
//    
//    // MARK: - Initialization
//    
//    func configureCell() {
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.backgroundColor = Theme.Color.clear
//    }

}

// MARK: - UICollectionViewDelegate

extension ActivityCell: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource

//extension ActivityCell: UICollectionViewDataSource {
//
//    // TODO
//
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if let activityCell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityCollectionViewCell.identifier, for: indexPath) as? ActivityCollectionViewCell {
//            return activityCell
//        }
//        return UITableViewCell()
//    }
//
//}

//// MARK: - UICollectionViewDelegateFlowLayout
//
//extension ActivityCell: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath.section == 0 {
//            return CGSize(width: self.view.bounds.width / 2 - 30, height: 120.0)
//        } else {
//            return CGSize(width: self.view.bounds.width - 40, height: 60.0)
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 8, left: 20, bottom: 20, right: 20)
//    }
//}

