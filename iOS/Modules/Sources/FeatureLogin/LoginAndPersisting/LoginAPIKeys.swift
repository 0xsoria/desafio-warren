//
//  File.swift
//  
//
//  Created by Gabriel Soria Souza on 04/03/21.
//

import Foundation

enum LoginAPIKeys {
    struct Login {
        static let contentType = "Content-Type"
        static let applicationJSON = "application/json"
        static let accessToken = "access-token"
        static let tokenDefaults = "Tokens"
        static let passDefaults = "Login"
    }
    
    struct LoginMockFile {
        static let login = "login"
        static let json = "json"
    }
}
