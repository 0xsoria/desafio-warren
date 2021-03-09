//
//  SwiftUIView.swift
//  
//
//  Created by Gabriel Soria Souza on 07/03/21.
//

import SwiftUI

struct TextFieldsView: View {

    @Binding var emailText: String
    @Binding var passwordText: String

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            TextField("Digite seu e-mail", text: self.$emailText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.leading)
                .padding(.trailing)
            SecureField("Digite sua senha", text: self.$passwordText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.leading)
                .padding(.trailing)
        }
    }
}

struct TextFieldsView_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
    }
}
