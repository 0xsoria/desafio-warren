//
//  File.swift
//  
//
//  Created by Gabriel Soria Souza on 09/03/21.
//

import Foundation

struct GoalsModel: Codable {
    var portfolios: [PortifolioModel]
}

struct PortifolioModel: Codable, Identifiable, Hashable {
    
    var _id: String
    var name: String
    var background: BackgroundModel
    var totalBalance: Double
    var goalAmount: Int?
    var goalDate: String
    var id: String {
        self._id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self._id)
    }
    
    static func == (lhs: PortifolioModel, rhs: PortifolioModel) -> Bool {
        lhs._id == rhs._id
    }
}

struct BackgroundModel: Codable {
    var thumb: String
    var small: String
    var full: String
    var regular: String
    var raw: String
}
