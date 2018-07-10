//
//  NavigationHelper.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/10/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class NavigationHelper {
    class func setupNavigationController(_ controller: UIViewController?, withTitle title: String?) {
        guard let navigationController = controller?.navigationController else { return }
        controller?.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: NavigationBarTitleView(withTitle: title ?? ""))
        navigationController.navigationBar.tintColor = Theme.Color.white
        navigationController.navigationBar.barTintColor = Theme.Color.Green.primary
    }
}



