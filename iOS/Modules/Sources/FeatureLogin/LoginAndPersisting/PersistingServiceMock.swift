//
//  File.swift
//  
//
//  Created by Gabriel Soria Souza on 07/03/21.
//

import CoreProviders
import Foundation

final class PersistingServiceMock: Persistable {

    private let userDefaults = UserDefaults.standard
    
    func save(account: String, password: String, service: String) throws {
        self.userDefaults.set([account: password],
                              forKey: LoginAPIKeys.Login.passDefaults)
        guard self.userDefaults.dictionary(forKey: account) != nil else {
            throw NSError(domain: "Could not save on User Defaults", code: 0, userInfo: nil)
        }
    }
    
    func getPassword(for account: String, with service: String) throws -> String {
        guard let dictionary = self.userDefaults.dictionary(forKey: LoginAPIKeys.Login.passDefaults) as? [String: String],
              let password = dictionary[account]  else {
            throw NSError(domain: "Could not save on User Defaults",
                          code: 0,
                          userInfo: nil)
        }
        return password
    }
    
    func save(accessToken: String, refreshToken: String) throws {
        self.userDefaults.set([TokenKeys.accessToken.rawValue: accessToken,
                               TokenKeys.refreshToken.rawValue: refreshToken], forKey: LoginAPIKeys.Login.tokenDefaults)
        
        guard self.userDefaults.dictionary(forKey: LoginAPIKeys.Login.tokenDefaults) != nil else {
            throw NSError(domain: "Could not save on User Defaults", code: 0, userInfo: nil)
        }
    }
    
    func getToken() throws -> [String: String] {
        guard let dictionary = self.userDefaults.dictionary(forKey: LoginAPIKeys.Login.tokenDefaults) as? [String: String] else {
            throw NSError(domain: "Could not save on User Defaults",
                          code: 0,
                          userInfo: nil)
        }
        return dictionary
    }
    
    func saveUserToken(token: UserToken) throws {
        self.userDefaults.set([TokenKeys.accessToken.rawValue: token.accessToken,
                               TokenKeys.refreshToken.rawValue: token.refreshToken], forKey: LoginAPIKeys.Login.tokenDefaults)
        
        guard self.userDefaults.dictionary(forKey: LoginAPIKeys.Login.tokenDefaults) != nil else {
            throw NSError(domain: "Could not save on User Defaults", code: 0, userInfo: nil)
        }
    }
}
