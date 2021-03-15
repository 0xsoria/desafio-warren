//
//  File.swift
//  
//
//  Created by Gabriel Soria Souza on 12/03/21.
//

import Foundation

extension String {
    func convertToDecimal() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "pt_BR")
        
        if let prizeAsNumber = Double(self) {
            return numberFormatter.string(from: NSNumber(value: prizeAsNumber)) ?? self
        } else if let prizeAsInt = Int(self) {
            return numberFormatter.string(from: NSNumber(value: prizeAsInt)) ?? self
        } else {
            return self
        }
    }
}
