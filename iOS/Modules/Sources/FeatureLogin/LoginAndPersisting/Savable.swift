//
//  File.swift
//  
//
//  Created by Gabriel Soria Souza on 03/03/21.
//

import CoreProviders
import Foundation

protocol Savable {
    func saveUserToken(token: UserToken) throws
}

final class PersistingSystem: Savable {

    private let service: Persistable

    init(service: Persistable) {
        #if DEBUG
        self.service = PersistingService()
        #else
        self.service = PersistingServiceMock()
        #endif
    }

    func saveUserToken(token: UserToken) throws {
        try self.service.save(accessToken: token.accessToken,
                              refreshToken: token.refreshToken)
    }
}
