//
//  AGAnalytics.swift
//  AwayGame
//
//  Created by Blake Swaidner on 7/2/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import Foundation
import FirebaseAnalytics

enum AGAnalytics {
    
    case loginWithFacebookTapped
    case loginWithTwitterTapped
    case loginWithEmailTapped
    
    case emailSignupFirstPageDidDisplay
    case emailSignupSecondPageDidDisplay
    case emailSignupThirdPageDidDisplay
    
    case createTripTapped
    case savedTripTapped
    case pastTripTapped
    case supportTapped
    case settingsTapped
    
    case savedTripDeleted
    case pastTripDeleted

    case aboutTapped
    case logoutTapped
    case websiteTapped
    
    case arriveTimeSelected
    case departTimeSelected
    
    case groupSelectionDidDisplay
    case groupTypeSelected(type: String)
    
    case preferencesPageDidDisplay(type: String)
    case preferenceSelected(title: String, type: String)
    
    case tripSaved
    case activitySelected
    case uberTapped
    case mapTapped
    case appExited
    
    static func logEvent(_ type: AGAnalytics, parameters: [String: Any]?) {
        Analytics.logEvent(type.description, parameters: parameters)
    }
    
    var description: String {
        
        switch self {
        case .loginWithFacebookTapped:
            return "LOGIN_WITH_FACEBOOK_TAPPED"
        case .loginWithTwitterTapped:
            return "LOGIN_WITH_TWITTER_TAPPED"
        case .loginWithEmailTapped:
            return "LOGIN_WITH_EMAIL_TAPPED"
            
        case .emailSignupFirstPageDidDisplay:
            return "EMAIL_SIGNUP_FIRST_PAGE_DID_DISPLAY"
        case .emailSignupSecondPageDidDisplay:
            return "EMAIL_SIGNUP_SECOND_PAGE_DID_DISPLAY"
        case .emailSignupThirdPageDidDisplay:
            return "EMAIL_SIGNUP_THIRD_PAGE_DID_DISPLAY"
        case .createTripTapped:
            return "CREATE_TRIP_TAPPED"
        case .savedTripTapped:
            return "SAVED_TRIP_TAPPED"
        case .pastTripTapped:
            return "PAST_TRIP_TAPPED"
        case .supportTapped:
            return "SUPPORT_TAPPED"
        case .settingsTapped:
            return "SETTINGS_TAPPED"
            
        case .savedTripDeleted:
            return "SAVED_TRIP_DELETED"
        case .pastTripDeleted:
            return "PAST_TRIP_DELETED"
            
        case .aboutTapped:
            return "ABOUT_TAPPED"
        case .logoutTapped:
            return "LOGOUT_TAPPED"
        case .websiteTapped:
            return "WEBSITE_TAPPED"
        case .arriveTimeSelected:
            return "ARRIVE_TIME_SELECTED"
        case .departTimeSelected:
            return "DEPART_TIME_SELECTED"
            
        case .groupSelectionDidDisplay:
            return "GROUP_SELECTION_DISPLAYED"
        case .groupTypeSelected(let type):
            return "\(type.capitalized)_SELECTED"
            
        case .preferencesPageDidDisplay(let type):
            return "\(type.capitalized)_PREFERENCES_PAGE_DID_DISPLAY"
        case .preferenceSelected(let title, let type):
            return "\(type.capitalized)_PREFERENCES_ITEM_SELECTED\(title.capitalized)"
            
        case .tripSaved:
            return "TRIP_SAVED"
        case .activitySelected:
            return "ACTIVITY_SELECTED"
        case .uberTapped:
            return "UBER_TAPPED"
        case .mapTapped:
            return "MAP_TAPPED"
        case .appExited:
            return "APP_EXITED"
        }
    }
    
}
