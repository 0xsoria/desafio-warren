//
//  File.swift
//  
//
//  Created by Gabriel Soria Souza on 03/03/21.
//

import CoreProviders
import Foundation
import SwiftUI

final class LoginRequester: ObservableObject {
    
    @Published private(set)var loginStatus: Bool = false
    @Published private(set)var statusMessage = String()
    @Published private(set)var isLoading = false
    private var loginSystem: Loggable?
    private var savable: Savable?
    
    init() {
        self.defineDependencies(loggable: LoginSystem(network: NetworkService()),
                                savable: PersistingSystem(service: PersistingService()))
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    func login(with email: String, and password: String, completion: @escaping ((Bool) -> Void)) {
        guard self.isValidEmail(email) else {
            self.statusMessage = "E-mail inválido."
            return
        }

        self.statusMessage = "Carregando..."
        self.isLoading = true
        self.loginSystem?.login(user: User(email: email, password: password), completion: { (result: Result<UserToken, Error>) in
            switch result {
            case .success(let successData):
                self.saveToken(token: successData)
                self.isLoading = false
                self.statusMessage = String()
                completion(true)
            case .failure:
                self.loginStatus = false
                self.isLoading = false
                self.statusMessage = "Senha incorreta."
                completion(false)
            }
        })
    }
    
    func defineDependencies(loggable: Loggable, savable: Savable) {
        self.loginSystem = loggable
        self.savable = savable
    }
    
    private func saveToken(token: UserToken) {
        do {
            try self.savable?.saveUserToken(token: token)
        } catch {
            self.loginStatus = false
            return
        }
        self.loginStatus = true
    }
}
