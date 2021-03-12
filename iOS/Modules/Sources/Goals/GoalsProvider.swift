//
//  File.swift
//  
//
//  Created by Gabriel Soria Souza on 09/03/21.
//

import CoreProviders
import Foundation

final class GoalsProvider: ObservableObject {
    
    private var tokenService: TokenGetter?
    private var goalsService: GoalsProvidable?
    @Published private(set) var goals: GoalsModel?
    @Published private(set) var errorLoading = false
    @Published private(set) var isLoading = true
    
    init() {
        self.tokenService = TokenService(service: PersistingService())
        self.goalsService = GoalsProviderSystem(network: NetworkService())
    }
    
    func requestGoals() {
        self.isLoading = true
        guard let token = self.getAccessToken() else {
            
            return
        }
        self.goalsService?.requestGoals(token: token, completion: { (result: Result<GoalsModel, NetworkError>) in
            switch result {
            case .success(let data):
                self.goals = data
                self.isLoading = false
                self.errorLoading = false
            case .failure:
                self.errorLoading = true
                self.isLoading = false
            }
        })
    }
    
    private func getAccessToken() -> String? {
        do {
            let tokens = try self.tokenService?.getUserToken()
            return tokens?.accessToken
        } catch {
            return nil
        }
    }
}
