import FeatureLogin
import SwiftUI
import RootElements

public struct MainView: View {
    
    @State private var showLogin = true
    @State private var isLogged = false
    @State private var buttonEnabled = true
    
    public init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().backgroundColor = .black
    }
    
    public var body: some View {
        NavigationView {
            ZStack {
                Color.black
                VStack {
                    NavigationLink(
                        destination: Next(),
                        isActive: self.$isLogged,
                        label: {})
                    MainButton(action: self.login,
                               title: "Login",
                               status: self.$buttonEnabled)
                }
            }
            .navigationBarTitle("Seus Objetivos", displayMode: .inline)
            .sheet(isPresented: self.$showLogin, content: {
                MainLoginView(isLogged: self.$isLogged,
                              showLogin: self.$showLogin)
                    .navigationBarTitle("Login", displayMode: .inline)
            })
        }
    }
    
    private func login() {
        self.showLogin = true
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

struct Next: View {
    var body: some View {
        Text("Em desenvolvimento...")
    }
}
