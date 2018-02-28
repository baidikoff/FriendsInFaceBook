//
//  Constants.swift
//  FriendsInFaceBook
//
//  Created by Viktoria on 12/3/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import Foundation
import UIKit

// MARK: -
// MARK: Public

public class Constants{
    static let urlHost = "https://graph.facebook.com/"
    static let urlPath = "v2.11/me/accounts?access_token="
    static let parameters = ["fields": "name, picture.type(normal), gendar"]
    static let publicProfile = "public_profile"
    static let email = "email"
    static let userFriends = "user_friends"
    static let testMode = "testMode"
    static let successLogin = "Log in successfully"
    static let cancel = "Cancel"
    static let success = "Success"
    static let RealmUserCellIdentifier = "FriendCell"
    static let ListOfFriendsTVCIdentifier = "TableView"
    static let LoginVCIdentifier = "LoginVC"
    static let LogOut = "Log Out"
    static let Yes = "Yes"
    static let LogOutMessage = "Are you sure you want to log out?"
    static let storyBoardIdentifier = "GoToSeeFriends"
    static let Main = "Main"
    static let users = [RealmUser(name: "Ivan Ivanov", image: RealmUserImageData(urlData: RealmUserImage(url: "https://cdn.pixabay.com/photo/2016/12/09/12/24/giraffe-1894778_960_720.jpg"))), RealmUser(name: "Vasiliy Vasichkin", image: RealmUserImageData(urlData: RealmUserImage(url: "https://cdn.pixabay.com/photo/2016/12/09/12/24/giraffe-1894778_960_720.jpg")))]
}

@objc public enum UrlType: Int {
    case urlHost
    case urlPath
    case parametersKey
    case parametersValue
    case graphPath
    
    public var rawValue: String {
        switch self{
        case .urlHost:
            return "https://graph.facebook.com/"
        case .urlPath:
            return "v2.11/me/accounts?access_token="
        case .parametersKey:
            return "fields"
        case .parametersValue:
            return "name, picture.type(normal), gendar"
        case .graphPath:
            return "me/taggable_friends"
        }
    }
    public init(rawValue: String) {
        switch "rawValue" {
        case "https://graph.facebook.com/":
            self = .urlHost
        case "v2.11/me/accounts?access_token=":
            self = .urlPath
        case "fields":
            self = .parametersKey
        case "name, picture.type(normal), gendar":
            self = .parametersValue
        case "me/taggable_friends":
            self = .graphPath
        default:
            self = .urlHost
        }
    }
}

