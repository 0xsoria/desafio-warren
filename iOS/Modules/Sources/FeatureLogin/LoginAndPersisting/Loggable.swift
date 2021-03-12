//
//  File.swift
//  
//
//  Created by Gabriel Soria Souza on 03/03/21.
//

import CoreProviders
import Foundation
import RootElements

protocol Loggable {
    func login(user: UserLogin, completion: @escaping ((Result<UserToken, Error>) -> Void))
}

final class LoginSystem: Loggable {
    
    private var network: NetworkServiceable
    
    init(network: NetworkServiceable) {
        #if DEBUG
        self.network = NetworkMock()
        #else
        self.network = network
        #endif
    }
    
    func defineNewNetworkModel(model: NetworkServiceable) {
        self.network = model
    }
    
    func login(user: UserLogin, completion: @escaping ((Result<UserToken, Error>) -> Void)) {
        self.network.request(model: self.defineModel(from: user)) { (result: Result<Data, NetworkError>) in
            switch result {
            case .success(let successData):
                DispatchQueue.main.async {
                    guard let success = self.decodeTokenResponse(with: successData) else {
                        completion(.failure(NetworkError.noData))
                        return
                    }
                    completion(.success(success))
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    completion(.failure(failure))
                }
            }
        }
    }
    
    private func decodeTokenResponse(with data: Data) -> UserToken? {
        do {
            let decoded = try JSONDecoder().decode(UserToken.self, from: data)
            return decoded
        } catch {
            return nil
        }
    }
    
    private func defineModel(from user: UserLogin) -> NetworkDataModel {
        let userModel = User(email: user.email, password: user.password)
        let encodedModel = try? JSONEncoder().encode(userModel)
        let model = NetworkModel(urlString: "https://\(PlistKey.loginURL.getData())",
                                 headers: [APIKeys.Keys.contentType: APIKeys.Keys.applicationJSON],
                                 httpMethod: .post,
                                 body: encodedModel ?? Data())
        return model
    }
}
