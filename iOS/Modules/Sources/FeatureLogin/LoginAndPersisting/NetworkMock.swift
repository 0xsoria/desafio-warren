//
//  File.swift
//  
//
//  Created by Gabriel Soria Souza on 04/03/21.
//

import CoreProviders
import Foundation

final class NetworkMock: NetworkServiceable {
    func request(model: NetworkDataModel, completion: @escaping ((Result<Data, NetworkError>) -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            let jsonData =
                """
            {"accessToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjdXN0b21lcklkIjoiNTgzNGFkM2MyMjdlYTVhYzdmYzBmZjAyIiwiYWNjZXNzVG9rZW5JZCI6IjVkOWU0YzQ4NTE5NzIwMDAxMWJkN2YxOSIsImFjY2Vzc1Rva2VuSGFzaCI6ImQzOWM3NTY3MGQ5MzU4NmU0NDNhZDJiMjNjMGVlMWQzZDViOTdhMDcyYzU3NmYzNjY5NTA3Mjk4ZDUzYzlmN2UiLCJpYXQiOjE1NzA2NTUzMDQsImV4cCI6MTU3MTI2MDEwNH0.k4GtMCxIX8xP-K0yNW3SGKVbL0qT40EF8h-y9gWUE04",
            "refreshToken":"fe782caea746c24e78b16bc0213ad94e411065d53b43a1d057bddfcb70bdf098"
            }
            """
            let dataFromJSONString = jsonData.data(using: .utf8)
            guard let returnData = dataFromJSONString else {
                completion(.failure(.invalidJSON))
                return
            }
            completion(.success(returnData))
        }
    }
}
