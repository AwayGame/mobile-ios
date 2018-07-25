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
        static let requestStrings: [String] = ["coffeeShops", "localCuisine", "fastFood", "upscale", "famousSpots", "fastCasual", "tapas", "barFood", "streetFood", "intimate"]
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
    static let privacyUrl: URL! = URL(string: "https://bit.ly/AwayGamePrivacy1")!
    static let termsUrl: URL! = URL(string: "https://bit.ly/AwayGameTerms1")!
    static let copyrightText = "Copyright 2018 AwayGame, LLC. All Rights Reserved."
    
    enum Support {
        static let email = "contact@awaygame.co"
        static let subject = "AwayGame Support"
        static let message = "<p>AwayGame Support,<br><p>" // TODO
    }
    
    enum About {
        static let p1 = "The AwayGame app is developed, created, and maintained by AwayGame, LLC in Lexington, KY. The AwayGame app is copyright 2018 AwayGame, LLC, all rights reserved. \n\nVisit AwayGame on the web at awaygame.co. Contact the team at contact@awaygame.co."
        
        static let p2 = "The creation of an itinerary, schedule, or trip consisting of events and locations does not constitute an endorsement of those events or locations by AwayGame, LLC nor hold AwayGame, LLC responsible for occurrences or experiences that happen prior, during, or after the scheduled time of the event or location. Location and event data including names, physical locations, ratings, descriptions, and more is owned by data partners of AwayGame, LLC. \n\nPlease review the full Privacy Policy and Terms of Use below."
        
        static let p3 = "Icon artwork provided by the Noun Project from artists Chameleon Design, sanjivini, sofi, praveen patchu, and Anastasia Latysheva.\n\nLoader animation copyright 2016 Vinh Nguyen.\n\nApple, the Apple logo, iPhone, and iPad are trademarks of Apple Inc., registered in the U.S. and other countries and regions. App Store is a service mark of Apple Inc.\n\n"
    }
    
}
