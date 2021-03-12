//
//  SwiftUIView.swift
//  
//
//  Created by Gabriel Soria Souza on 12/03/21.
//

import SwiftUI

struct ImageBackground: View {
    
    @Binding var loading: Bool
    @Binding var image: UIImage
    
    var body: some View {
        if !self.loading {
            Image(uiImage: self.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 120)
                .opacity(0.3)
        } else {
            self.progressView
        }
    }
    
    var progressView: some View {
        ZStack {
            Color.black
            ProgressView()
                .scaleEffect(1.5)
                .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
        }
    }
    
    private func oi() {
        
    }
}
