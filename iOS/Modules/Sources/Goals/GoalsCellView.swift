//
//  File 2.swift
//  
//
//  Created by Gabriel Soria Souza on 12/03/21.
//

import SwiftUI

struct GoalCellView: View {
    
    var item: PortifolioModel
    
    var body: some View {
            VStack {
                HStack {
                    Text(self.item.name).foregroundColor(.white)
                    Spacer()
                    Text(String(item.goalAmount ?? 0)).foregroundColor(.white)
                }
                HStack {
                    Text(String(item.totalBalance)).foregroundColor(.white)
                    Spacer()
                    Text(item.goalDate).foregroundColor(.white)
                }
            
        }
    }
}
