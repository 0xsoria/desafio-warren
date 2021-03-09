//
//  File.swift
//  
//
//  Created by Gabriel Soria Souza on 03/03/21.
//

import Foundation

protocol UserLogin {
    var email: String { get set }
    var password: String { get set }
}

struct User: UserLogin, Codable {
    var email: String
    var password: String
}
