//
//  Constants.swift
//  FriendsInFaceBook
//
//  Created by Viktoria on 12/3/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import Foundation
import UIKit

class Constants{
    static let urlHost = "https://graph.facebook.com/"
    static let urlPath = "v2.11/me/accounts?access_token="
    static let parameters = ["fields": "name, picture.type(normal), gendar"]
    
}
@objc public enum UrlType: Int {
    case urlHost
    case urlPath
    case parametersKey
    case parametersValue
    
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
        default:
            self = .urlHost
        }
    }
}
