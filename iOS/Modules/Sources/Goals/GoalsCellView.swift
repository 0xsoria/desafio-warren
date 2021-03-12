//
//  File 2.swift
//  
//
//  Created by Gabriel Soria Souza on 12/03/21.
//

import RootElements
import SwiftUI

struct GoalCellView: View {
    
    var item: PortifolioModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            ProgressBar(value: Float(item.totalBalance / Double(item.goalAmount ?? 1)))
                .frame(height: 10)
            Text(self.item.name)
                .foregroundColor(.white)
                .font(.title2)
                .fontWeight(.bold)
            Text(String(item.totalBalance).convertToDecimal())
                .foregroundColor(.white).font(.title3)
        }
    }
}
