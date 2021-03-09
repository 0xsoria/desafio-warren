import SwiftUI
import RootElements

public struct MainLoginView: View {
    
    @Binding private(set) var isLogged: Bool
    @Binding private(set) var showLogin: Bool
    @State private var emailText = String()
    @State private var passwordText = String()
    @ObservedObject private var login = LoginRequester()
    @State private var textStatus = false
    
    public init(isLogged: Binding<Bool>, showLogin: Binding<Bool>) {
        self._isLogged = isLogged
        self._showLogin = showLogin
    }
    
    public var body: some View {
        VStack {
            Spacer()
            Text("Entre com suas credenciais")
                .foregroundColor(.white)
            Spacer()
            TextFieldsView(emailText: self.$emailText,
                           passwordText: self.$passwordText)
            Spacer()
            Text(self.login.statusMessage)
                .foregroundColor(.white)
            Spacer()
            MainButton(action: self.continueAction,
                       title: "Continuar",
                       status: self.$textStatus).onChange(of: !self.emailText.isEmpty && !self.passwordText.isEmpty, perform: { value in
                            self.textStatus = value
                       })
            Spacer()
        }.background(Color.black)
    }
    
    private func continueAction() {
        self.login.login(with: emailText, and: passwordText) { result in
            self.isLogged = result
            self.showLogin = !result
            if result {
                self.emailText = String()
                self.passwordText = String()
            }
        }
    }
}

struct MainLoginView_PreViews: PreviewProvider {
    static var previews: some View {
        Text("")
    }
}
