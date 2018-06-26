//
//  UIImageView+Kingfisher.swift
//  AwayGame
//
//  Created by Blake Swaidner on 6/25/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import Kingfisher
import UIKit

extension UIImageView {
    
    func setImage(withUrlString urlString: String?) {
        print("\n\nSETTING IMAGE: \(urlString ?? "")\n\n")
        guard let urlString = urlString else { return }
        
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
            print("Unable to convert urlString to URL")
            return
        }

        self.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: { (current, total) in
            print("IMAGE LOADING: \(current) of \(total)")
        }) { (image, error, cacheType, url) in
            if error != nil {
                print("IMAGE: \(image)\nERROR: \(error)\ncacheType: \(cacheType)\nURL: \(url)")
            }
        }
        
    }
    
}
