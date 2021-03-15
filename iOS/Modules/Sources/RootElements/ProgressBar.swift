//
//  File.swift
//  
//
//  Created by Gabriel Soria Souza on 12/03/21.
//

import SwiftUI

public struct ProgressBar: View {
    
    public var value: Float
    
    public init(value: Float) {
        self.value = value
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width,
                                  height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                Rectangle().frame(width: min(CGFloat(self.value) * geometry.size.width, geometry.size.width),
                                  height: geometry.size.height)
                    .foregroundColor(Color(UIColor.systemBlue))
                    .animation(.linear)
            }.cornerRadius(45.0)
        }
    }
}
