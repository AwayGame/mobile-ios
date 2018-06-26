//
//  Constants.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/24/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

// MARK: - Preferences

enum Preferences {
        
    enum Group {
        static let title: String = "Who are you going with?"
        static let text: [String] = ["Family", "Friends", "Colleagues", "Significant Other", "Just me"]
        static let requestStrings: [String] = []
        static let images: [UIImage] = [#imageLiteral(resourceName: "Family"), #imageLiteral(resourceName: "Friends"), #imageLiteral(resourceName: "Colleagues"), #imageLiteral(resourceName: "Couple_1"), #imageLiteral(resourceName: "Just Me")]
    }
    
    enum Food {
        static let title: String = "What's to eat?"
        static let text: [String] = ["Local Cuisine", "Fast Food", "Upscale", "Famous Spots", "Fast Casual", "Tapas", "Bar Food", "Street Food", "Coffee Shops", "Intimate"]
        static let requestStrings: [String] = ["coffeeShops", "localCusine", "fastFood", "upscale", "famousSpots", "fastCasual", "tapas", "barFood", "streetFood", "intimate"]
        static let images: [UIImage] = [#imageLiteral(resourceName: "local"), #imageLiteral(resourceName: "fastfood-1"), #imageLiteral(resourceName: "upscale-1"), #imageLiteral(resourceName: "famous-1"), #imageLiteral(resourceName: "fastcasual-1"), #imageLiteral(resourceName: "tapas-1"), #imageLiteral(resourceName: "barfood-1"), #imageLiteral(resourceName: "street-food-1"), #imageLiteral(resourceName: "coffeeshop-1"), #imageLiteral(resourceName: "intimate-1")]
    }
    
    enum Interest {
        static let title: String = "What do you want to do?"
        static let text: [String] = ["Shopping", "Museums", "Famous Sights", "Guided Tours", "Active Tourism", "Health/Wellness", "Historic Places", "Parks"]
        static let requestStrings: [String] = ["shopping", "museums", "famousSights", "shows", "guidedTours", "activeTourism", "specialEvents", "healthAndWellness", "historicalPlaces", "parks"]
        static let images: [UIImage] = [#imageLiteral(resourceName: "shopping-1"), #imageLiteral(resourceName: "museum-1"), #imageLiteral(resourceName: "famoussight-1"), #imageLiteral(resourceName: "tour-1"), #imageLiteral(resourceName: "active-1"), #imageLiteral(resourceName: "wellness-1"), #imageLiteral(resourceName: "historical-2"), #imageLiteral(resourceName: "parks")]
    }
    
    enum Nightlife {
        static let title: String = "What's the nighttime move?"
        static let text: [String]? = ["Sports Bars", "Party Bars", "Breweries", "Nightclubs", "Dance Halls", "Cocktail Lounges", "Wine Bars", "Speakeasies", "Themed Bars", "Pubs"]
        static let requestStrings: [String] = ["sportsbars", "partybars", "breweries", "nightclubs", "danceHalls", "cocktailLounges", "winebars", "speakeasies", "themedBars", "pubs"]
        static let images: [UIImage]? = [#imageLiteral(resourceName: "sportsbar-1"), #imageLiteral(resourceName: "partybar-1"), #imageLiteral(resourceName: "brewery-1"), #imageLiteral(resourceName: "nightclub-1"), #imageLiteral(resourceName: "dancehall-1"), #imageLiteral(resourceName: "cocktail-1"), #imageLiteral(resourceName: "winebar-1"), #imageLiteral(resourceName: "speakeasy-1"), #imageLiteral(resourceName: "themed-1"), #imageLiteral(resourceName: "pub-1")]
    }
}

// MARK: - Support

enum Settings {
    
    static let websiteUrl: URL! = URL(string: "https://awaygame.co")!
    static let copyrightText = "Copyright 2018 AwayGame, LLC. All Right Reserved."
    
    enum Support {
        static let email = "support@awaygame.co"
        static let subject = "AwayGame Support"
        static let message = "<p>Hello<p>" // TODO
    }
    
    enum About {
        static let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent facilisis quam enim, vel posuere ligula blandit sed. Mauris a rutrum neque. Phasellus sit amet nulla eget lorem elementum tempus eu sodales nulla. Nam vehicula elit massa, cursus elementum erat rhoncus vel. Pellentesque sit amet enim tortor. Mauris accumsan, nisi sed vestibulum euismod, ligula ipsum pretium sapien, et tempus ipsum neque at odio. Mauris at velit at arcu posuere egestas vitae non arcu. Mauris varius tellus eros, quis vehicula diam commodo et."
    }
    
}
