//
//  File.swift
//  
//
//  Created by Gabriel Soria Souza on 03/03/21.
//

import Foundation

public protocol NetworkDataModel {
    var urlString: String { get set }
    var headers: [String: String]? { get set }
    var httpMethod: HTTPMethod { get set }
    var body: Data? { get set }
}
