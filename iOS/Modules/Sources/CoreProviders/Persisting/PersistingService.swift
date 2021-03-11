//
//  File.swift
//  
//
//  Created by Gabriel Soria Souza on 06/03/21.
//

import Foundation

public class PersistingService: Persistable {
    public init() {}
    
    public func save(account: String, password: String, service: String) throws {

        guard !account.isEmpty, !password.isEmpty, !service.isEmpty else {
            throw KeychainWrapperError(type: KeychainWrapperError.KeychainErrorType.badData)
        }
        guard let passwordData = password.data(using: .utf8) else {
            throw KeychainWrapperError(type: KeychainWrapperError.KeychainErrorType.badData)
        }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service,
            kSecValueData as String: passwordData
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        switch status {
        case errSecSuccess:
            break
        case errSecDuplicateItem:
            try self.update(account: account, password: password, service: service)
        default:
            throw KeychainWrapperError(status: status, type: KeychainWrapperError.KeychainErrorType.servicesError)
        }
    }
    
    public func getPassword(for account: String, with service: String) throws -> String {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status != errSecItemNotFound else {
            throw KeychainWrapperError(type: .itemNotFound)
        }
        guard status == errSecSuccess else {
            throw KeychainWrapperError(status: status, type: .servicesError)
        }
        
        guard let existingItem = item as? [String: Any],
              let valueData = existingItem[kSecValueData as String] as? Data,
              let value = String(data: valueData, encoding: .utf8) else {
            throw KeychainWrapperError(type: .unableToConvertToString)
        }
        return value
    }
    
    private func update(account: String, password: String, service: String) throws {
        
        guard !account.isEmpty, !password.isEmpty, !service.isEmpty else {
            throw KeychainWrapperError(type: KeychainWrapperError.KeychainErrorType.badData)
        }
        guard let passwordData = password.data(using: .utf8) else {
            throw KeychainWrapperError(type: KeychainWrapperError.KeychainErrorType.badData)
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service
        ]
        
        let attributes: [String: Any] = [
            kSecValueData as String: passwordData
        ]
        
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        guard status != errSecItemNotFound else {
            throw KeychainWrapperError(message: "Matching Item Not Found", type: .itemNotFound)
        }
        
        guard status == errSecSuccess else {
            throw KeychainWrapperError(status: status, type: .servicesError)
        }
    }
    
    public func save(accessToken: String, refreshToken: String) throws {
        guard !accessToken.isEmpty, !refreshToken.isEmpty else {
            throw KeychainWrapperError(type: KeychainWrapperError.KeychainErrorType.badData)
        }
        
        let tokenDictionary = [TokenKeys.accessToken.rawValue: accessToken,
                               TokenKeys.refreshToken.rawValue: refreshToken]
        
        let serialized = try JSONSerialization.data(withJSONObject: tokenDictionary,
                                                options: .prettyPrinted)
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: TokenKeys.token.rawValue,
            kSecValueData as String: serialized
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        switch status {
        case errSecSuccess:
            break
        case errSecDuplicateItem:
            try self.update(accessToken: accessToken, refreshToken: refreshToken)
        default:
            throw KeychainWrapperError(status: status, type: KeychainWrapperError.KeychainErrorType.servicesError)
        }
    }
    
    private func update(accessToken: String, refreshToken: String) throws {
        guard !accessToken.isEmpty, !refreshToken.isEmpty else {
            throw KeychainWrapperError(type: KeychainWrapperError.KeychainErrorType.badData)
        }
        
        let tokenDictionary = [TokenKeys.accessToken.rawValue: accessToken,
                               TokenKeys.refreshToken.rawValue: refreshToken]
        
        let serialized = try JSONSerialization.data(withJSONObject: tokenDictionary,
                                                options: .prettyPrinted)
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: TokenKeys.token.rawValue
        ]
        
        let attributes: [String: Any] = [
            kSecValueData as String: serialized
        ]
        
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        
        guard status != errSecItemNotFound else {
            throw KeychainWrapperError(message: "Matching Item Not Found",
                                       type: .itemNotFound)
        }
        
        guard status == errSecSuccess else {
            throw KeychainWrapperError(status: status, type: .servicesError)
        }
    }
    
    public func getToken() throws -> [String: String] {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: TokenKeys.token.rawValue,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary,
                                         &item)
        
        guard status != errSecItemNotFound else {
            throw KeychainWrapperError(type: .itemNotFound)
        }
        guard status == errSecSuccess else {
            throw KeychainWrapperError(status: status, type: .servicesError)
        }
        
        guard let existingItem = item as? [String: Any],
              let valueData = existingItem[kSecValueData as String] as? Data,
              let value = try? JSONDecoder().decode([String: String].self, from: valueData) else {
            throw KeychainWrapperError(type: .unableToConvertToString)
        }
        
        return value
    }
}
