//
//  File.swift
//  
//
//  Created by Gabriel Soria Souza on 06/03/21.
//

import Foundation

public struct KeychainWrapperError: Error {
    var message: String?
    var type: KeychainErrorType
    
    public enum KeychainErrorType {
        case badData
        case servicesError
        case itemNotFound
        case unableToConvertToString
    }
    
    public init(status: OSStatus, type: KeychainErrorType) {
        self.type = type
        if let errorMessage = SecCopyErrorMessageString(status, nil) {
            self.message = String(errorMessage)
        } else {
            self.message = "Status Code: \(status)"
        }
    }
    
    public init(type: KeychainErrorType) {
        self.type = type
    }
    
    public init(message: String, type: KeychainErrorType) {
        self.message = message
        self.type = type
    }
}
