//
//  File.swift
//  
//
//  Created by Gabriel Soria Souza on 03/03/21.
//

import Foundation

public enum PlistKey: String {

    case loginURL = "LOGIN_API"
    case contentURL = "CONTENT_API"

    public func getData() -> String {
        switch self {
        case .loginURL:
            return Bundle.main.object(forInfoDictionaryKey: "LOGIN_API") as? String ?? ""
        case .contentURL:
            return Bundle.main.object(forInfoDictionaryKey: "CONTENT_API") as? String ?? ""
        }
    }
}
