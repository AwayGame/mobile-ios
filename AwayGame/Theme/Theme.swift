//
//  Theme.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/8/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import Foundation
import UIKit

enum Theme {
    
    // MARK: - Font
    
    enum Font {
        
        // TODO: Filler fonts
        
        static let title: UIFont = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)
        static let h1: UIFont = UIFont(name: "DINAlternate-Bold", size: 24)!
        static let h2: UIFont = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        static let p1: UIFont = UIFont(name: "DINAlternate-Bold", size: 19)!
        static let p2: UIFont = UIFont(name: "DINAlternate-Bold", size: 16)!
        static let p3: UIFont = UIFont(name: "DINAlternate-Bold", size: 14)!
        static let body: UIFont = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)
        
    }
    
    // MARK: - Color
    
    enum Color {
        
        // TODO: Filler colors
        
        static let white: UIColor = .white
        static let black: UIColor = .black
        static let darkText: UIColor = UIColor(displayP3Red: 92.0/255.0, green: 92.0/255.0, blue: 92.0/255.0, alpha: 1.0)
        static let clear: UIColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        
        struct Login {
            static let facebook: UIColor = UIColor(displayP3Red: 59.0/255.0, green: 89.0/255.0, blue: 152.0/255.0, alpha: 1.0)
            static let twitter: UIColor = UIColor(displayP3Red: 0.0/255.0, green: 172.0/255.0, blue: 237.0/255.0, alpha: 1.0)
            static let email: UIColor = UIColor(displayP3Red: 112.0/255.0, green: 112.0/255.0, blue: 112.0/255.0, alpha: 1.0)
        }
        
        enum Green {
            static let primary: UIColor = UIColor(displayP3Red: 83.0/255.0, green: 185.0/255.0, blue: 114.0/255.0, alpha: 1.0)
            static let secondary: UIColor = UIColor(displayP3Red: 115.0/255.0, green: 183.0/255.0, blue: 87.0/255.0, alpha: 1.0)
            static let selected: UIColor = UIColor(displayP3Red: 83.0/255.0, green: 185.0/255.0, blue: 114.0/255.0, alpha: 0.15)
            static let border: UIColor = UIColor(displayP3Red: 83.0/255.0, green: 185.0/255.0, blue: 114.0/255.0, alpha: 0.80)
        }
        
        enum Gradient {
            static let green: UIColor = UIColor(displayP3Red: 115.0/255.0, green: 183.0/255.0, blue: 87.0/255.0, alpha: 1.0)
            static let blue: UIColor = UIColor(displayP3Red: 0.0/255.0, green: 73.0/255.0, blue: 114.0/255.0, alpha: 0.9)
        }
        
        enum Background {
            static let primary: UIColor = UIColor(displayP3Red: 252.0/255.0, green: 249.0/255.0, blue: 249.0/255.0, alpha: 1.0)
            static let highlighted: UIColor = UIColor(displayP3Red: 242.0/255.0, green: 239.0/255.0, blue: 239.0/255.0, alpha: 1.0)
            static let darkGray: UIColor = UIColor(displayP3Red: 142.0/255.0, green: 142.0/255.0, blue: 142.0/255.0, alpha: 1.0)
        }
        
        
        
        
        // etc...
    }
    
}





