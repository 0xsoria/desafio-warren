//
//  File.swift
//  
//
//  Created by Gabriel Soria Souza on 09/03/21.
//

import CoreProviders
import Foundation

protocol TokenGetter {
    func getUserToken() throws -> UserToken
}

final class TokenService: TokenGetter {

    private let service: Persistable

    init(service: Persistable) {
        self.service = service
    }

    func getUserToken() throws -> UserToken {
        let token = try self.service.getToken()
        guard let accessTK = token[TokenKeys.accessToken.rawValue], let refreshTK = token[TokenKeys.refreshToken.rawValue] else {
            throw TokenErrors.notFound
        }
        return UserToken(accessToken: accessTK, refreshToken: refreshTK)
    }
}
