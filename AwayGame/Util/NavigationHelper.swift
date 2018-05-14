//
//  NavigationHelper.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/10/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

func setupNavigation(controller: UINavigationController?, hidesBar: Bool) {
    guard let navigation = controller?.navigationBar else { return }
    controller?.hidesBarsOnTap = hidesBar
    controller?.hidesBarsOnSwipe = hidesBar
    navigation.tintColor = Theme.Color.black
    navigation.titleTextAttributes = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.heavy), NSAttributedStringKey.foregroundColor : Theme.Color.black]
    navigation.isTranslucent = true
    navigation.barTintColor = Theme.Color.white
}
