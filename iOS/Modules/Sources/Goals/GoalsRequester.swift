//
//  File.swift
//  
//
//  Created by Gabriel Soria Souza on 09/03/21.
//

import CoreProviders
import Foundation
import RootElements

protocol GoalsProvidable {
    func requestGoals(token: String, completion: @escaping ((Result<GoalsModel, NetworkError>) -> Void))
}

final class GoalsProviderSystem: GoalsProvidable {

    private var network: NetworkServiceable

    init(network: NetworkServiceable) {
        #if DEBUG
        self.network = NetworkMock()
        #else
        self.network = network
        #endif
    }
    
    func requestGoals(token: String, completion: @escaping ((Result<GoalsModel, NetworkError>) -> Void)) {
        let model = self.defineModel(token: token)
        self.network.request(model: model) { (result: Result<Data, NetworkError>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    guard let returnModel = self.decodeModel(data) else {
                        completion(.failure(.invalidJSON))
                        return
                    }
                    completion(.success(returnModel))
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    completion(.failure(failure))
                }
            }
        }
    }
    
    private func decodeModel(_ data: Data) -> GoalsModel? {
        do {
            let decoded = try JSONDecoder().decode(GoalsModel.self, from: data)
            return decoded
        } catch {
            return nil
        }
    }
    
    private func defineModel(token: String) -> NetworkDataModel {
        let model = NetworkModel(urlString: "https://\(PlistKey.contentURL.getData())",
                                 headers: [APIKeys.Keys.contentType: APIKeys.Keys.applicationJSON,
                                           APIKeys.Keys.accessToken: token],
                                 httpMethod: .get,
                                 body: nil)
        return model
    }
    
}
