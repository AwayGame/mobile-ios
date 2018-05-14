//
//  Theme.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/8/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import Foundation
import UIKit

struct Theme {
    
    // MARK: - Font
    
    struct Font {
        
        // TODO: Filler fonts
        
        static let title: UIFont = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.heavy)
        static let h1: UIFont = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy)
        static let h2: UIFont = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        static let body: UIFont = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)
        
    }
    
    // MARK: - Color
    
    struct Color {
        
        // TODO: Filler colors
        
        static let white: UIColor = .white
        static let black: UIColor = .black
        static let clear: UIColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        
        struct Green {
            static let primary: UIColor = UIColor(displayP3Red: 50.0/255.0, green: 235.0/255.0, blue: 189/255.0, alpha: 1.0)
            static let secondary: UIColor = UIColor(displayP3Red: 70.0/255.0, green: 235.0/255.0, blue: 189/255.0, alpha: 1.0)
        }
        
        // etc...
    }
    
}
