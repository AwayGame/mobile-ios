//
//  Constants.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/24/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

// MARK: - Preferences

struct Preferences {
        
    struct Group {
        static let title: String = "Who are you going with?"
        static let text: [String] = ["Friends", "Significant Other", "Family", "Colleagues", "Just me"]
        static let requestStrings: [String] = []
        static let images: [UIImage] = [#imageLiteral(resourceName: "Friends"), #imageLiteral(resourceName: "Couple_1"), #imageLiteral(resourceName: "Family"), #imageLiteral(resourceName: "Colleagues"), #imageLiteral(resourceName: "Just Me")]
    }
    
    struct Food {
        static let title: String = "What's to eat?"
        static let text: [String] = ["Local Cuisine", "Fast Food", "Upscale", "Famous Spots", "Fast Casual", "Tapas", "Bar Food", "Street Food", "Coffee Shops", "Intimate"]
        static let requestStrings: [String] = ["coffeeShops", "localCusine", "fastFood", "upscale", "famousSpots", "fastCasual", "tapas", "barFood", "streetFood", "intimate"]
        static let images: [UIImage] = [#imageLiteral(resourceName: "local"), #imageLiteral(resourceName: "fastfood-1"), #imageLiteral(resourceName: "upscale-1"), #imageLiteral(resourceName: "famous-1"), #imageLiteral(resourceName: "fastcasual-1"), #imageLiteral(resourceName: "tapas-1"), #imageLiteral(resourceName: "barfood-1"), #imageLiteral(resourceName: "street-food-1"), #imageLiteral(resourceName: "coffeeshop-1"), #imageLiteral(resourceName: "intimate-1")]
    }
    
    struct Interest {
        static let title: String = "What do you want to do?"
        static let text: [String] = ["Shopping", "Museums", "Famous Sights", "Shows", "Guided Tours", "Active Tourism", "Special Events", "Health/Wellness", "Historic Places", "Parks"]
        static let requestStrings: [String] = ["shopping", "museums", "famousSights", "shows", "guidedTours", "activeTourism", "specialEvents", "healthAndWellness", "historicalPlaces", "parks"]
        static let images: [UIImage] = [#imageLiteral(resourceName: "shopping-1"), #imageLiteral(resourceName: "museum-1"), #imageLiteral(resourceName: "famoussight-1"), #imageLiteral(resourceName: "show-1"), #imageLiteral(resourceName: "tour-1"), #imageLiteral(resourceName: "active-1"), #imageLiteral(resourceName: "specialevent-1"), #imageLiteral(resourceName: "wellness-1"), #imageLiteral(resourceName: "historical-2"), #imageLiteral(resourceName: "parks")]
    }
    
    struct Nightlife {
        static let title: String = "What's the nighttime move?"
        static let text: [String]? = ["Sports Bars", "Party Bars", "Breweries", "Nightclubs", "Dance Halls", "Cocktail Lounges", "Wine Bars", "Speakeasies", "Themed Bars", "Pubs"]
        static let requestStrings: [String] = ["sportsbars", "partybars", "breweries", "nightclubs", "danceHalls", "cocktailLounges", "winebars", "speakeasies", "themedBars", "pubs"]
        static let images: [UIImage]? = [#imageLiteral(resourceName: "sportsbar-1"), #imageLiteral(resourceName: "partybar-1"), #imageLiteral(resourceName: "brewery-1"), #imageLiteral(resourceName: "nightclub-1"), #imageLiteral(resourceName: "dancehall-1"), #imageLiteral(resourceName: "cocktail-1"), #imageLiteral(resourceName: "winebar-1"), #imageLiteral(resourceName: "speakeasy-1"), #imageLiteral(resourceName: "themed-1"), #imageLiteral(resourceName: "pub-1")]
    }
}

// MARK: - Support

struct Support {
    
    static let email = "support@awaygame.co"
    static let subject = "AwayGame Support"
    static let message = "<p>Hello<p>" // TODO

}
