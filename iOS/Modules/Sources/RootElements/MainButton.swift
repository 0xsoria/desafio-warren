//
//  SwiftUIView.swift
//  
//
//  Created by Gabriel Soria Souza on 09/03/21.
//

import SwiftUI

public struct MainButton: View {
    
    var action: (() -> Void)
    var title: String
    @Binding var status: Bool
    
    public init(action: @escaping (() -> Void), title: String, status: Binding<Bool>) {
        self.action = action
        self.title = title
        self._status = status
    }
    
    public var body: some View {
        Button(action: self.action, label: {
            Text(self.title)
                .fontWeight(.bold)
        })
        .foregroundColor(Color.white)
        .overlay(RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.red, lineWidth: 0))
        .padding()
        .frame(width: 300, height: 40, alignment: .center)
        .background(self.status ? Color.red : Color.gray)
        .cornerRadius(10.0)
        .disabled(!self.status)
    }
}

struct MainButton_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
    }
}
