//
//  File 2.swift
//  
//
//  Created by Gabriel Soria Souza on 12/03/21.
//

import RootElements
import SwiftUI

struct GoalCellView: View {
    
    private let queue = OperationQueue()
    var item: PortifolioModel
    @State private var image = UIImage()
    @State private var isLoading = true
    
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
        .onAppear(perform: {
            guard let url = URL(string: item.background.small) else {
                return
            }
            let op = NetworkImageOperation(url: url)
            op.completionBlock = {
                DispatchQueue.main.async {
                    self.image = op.image ?? UIImage()
                    self.isLoading = false
                }
            }
            queue.addOperation(op)
        }).background(ImageBackground(loading: self.$isLoading,
                                      image: self.$image).clipped())
    }
    
}
