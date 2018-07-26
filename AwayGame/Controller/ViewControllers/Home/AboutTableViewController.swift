//
//  AboutTableViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 6/20/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit
import MessageUI
import SafariServices

class AboutTableViewController: UITableViewController {

    private var cellHeights: [CGFloat] = [CGFloat].init(repeating: 0.0, count: 7)
    
    override func viewWillAppear(_ animated: Bool) {
        NavigationHelper.setupNavigationController(self, withTitle: "About")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = .init(top: 0.0, left: 0.0, bottom: 40.0, right: 0.0)
        tableView.allowsSelection = false
        tableView.isUserInteractionEnabled = true
        tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // TODO: Cleanup into 2 dequeues
        
        if indexPath.row == 0 {
            if let textCell = tableView.dequeueReusableCell(withIdentifier: AboutTextTableViewCell.identifier, for: indexPath) as? AboutTextTableViewCell {
                textCell.configureCell(withText: Settings.About.p1, font: Theme.Font.p1)
                if cellHeights[indexPath.row] == 0 {
                    cellHeights[indexPath.row] = textCell.sizeThatFits(CGSize(width: tableView.frame.width - 40.0, height: .greatestFiniteMagnitude)).height
                }
                return textCell
            }
        } else if indexPath.row == 1 {
            if let textCell = tableView.dequeueReusableCell(withIdentifier: AboutTextTableViewCell.identifier, for: indexPath) as? AboutTextTableViewCell {
                textCell.configureCell(withText: Settings.About.p2, font: Theme.Font.p2)
                if cellHeights[indexPath.row] == 0 {
                    cellHeights[indexPath.row] = textCell.sizeThatFits(CGSize(width: tableView.frame.width - 40.0, height: .greatestFiniteMagnitude)).height
                }
                return textCell
            }
        } else if indexPath.row == 2 {
            if let textCell = tableView.dequeueReusableCell(withIdentifier: AboutTextTableViewCell.identifier, for: indexPath) as? AboutTextTableViewCell {
                textCell.configureCell(withText: Settings.About.p3, font: Theme.Font.p3)
                if cellHeights[indexPath.row] == 0 {
                    cellHeights[indexPath.row] = textCell.sizeThatFits(CGSize(width: tableView.frame.width - 40.0, height: .greatestFiniteMagnitude)).height
                }
                return textCell
            }
        } else if indexPath.row == 3 {
            if let buttonCell = tableView.dequeueReusableCell(withIdentifier: AboutButtonTableViewCell.identifier, for: indexPath) as? AboutButtonTableViewCell {
                buttonCell.configureCell(withText: "Website", link: Settings.websiteUrl)
                buttonCell.delegate = self
                if cellHeights[indexPath.row] == 0 {
                    cellHeights[indexPath.row] = AboutButtonTableViewCell.height
                }
                return buttonCell
            }
        } else if indexPath.row == 4 {
            if let buttonCell = tableView.dequeueReusableCell(withIdentifier: AboutButtonTableViewCell.identifier, for: indexPath) as? AboutButtonTableViewCell {
                buttonCell.configureCell(withText: "Privacy Policy", link: Settings.privacyUrl)
                buttonCell.delegate = self
                if cellHeights[indexPath.row] == 0 {
                    cellHeights[indexPath.row] = AboutButtonTableViewCell.height
                }
                return buttonCell
            }
        } else if indexPath.row == 5 {
            if let buttonCell = tableView.dequeueReusableCell(withIdentifier: AboutButtonTableViewCell.identifier, for: indexPath) as? AboutButtonTableViewCell {
                buttonCell.configureCell(withText: "Terms of Use", link: Settings.termsUrl)
                buttonCell.delegate = self
                if cellHeights[indexPath.row] == 0 {
                    cellHeights[indexPath.row] = AboutButtonTableViewCell.height
                }
                return buttonCell
            }
        }
        
        return UITableViewCell()
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }

}

extension AboutTableViewController: AboutButtonDelegate {
    func didTapButton(_ button: UIButton?, withLink link: URL?) {
        guard let url = link else { return }
        if button?.titleLabel?.text?.uppercased() == "Count".uppercased() {
            if MFMailComposeViewController.canSendMail() {
                let mailVC = MFMailComposeViewController()
                mailVC.mailComposeDelegate = self
                
                mailVC.setToRecipients([Settings.Support.email])
                mailVC.setSubject(Settings.Support.subject)
                mailVC.setMessageBody(Settings.Support.message, isHTML: true)
                
                present(mailVC, animated: true)
            } else {
                if let url = URL(string: "mailto:\(Settings.Support.email)") {
                    UIApplication.shared.open(url)
                }
            }
        } else {
            let svc = SFSafariViewController(url: url)
            svc.preferredBarTintColor = Theme.Color.white
            svc.preferredControlTintColor = Theme.Color.black
            self.present(svc, animated: true, completion: nil)
        }
        

    }
}

extension AboutTableViewController: MFMailComposeViewControllerDelegate {}
