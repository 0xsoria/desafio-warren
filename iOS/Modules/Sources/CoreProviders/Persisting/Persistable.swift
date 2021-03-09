//
//  File.swift
//  
//
//  Created by Gabriel Soria Souza on 05/03/21.
//

import Foundation

public protocol Persistable {
    func save(account: String, password: String, service: String) throws
    func getPassword(for account: String, with service: String) throws -> String
    func save(accessToken: String, refreshToken: String) throws
    func getToken() throws -> [String: String]
}
