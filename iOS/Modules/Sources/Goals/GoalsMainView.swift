//
//  SwiftUIView.swift
//  
//
//  Created by Gabriel Soria Souza on 09/03/21.
//

import RootElements
import SwiftUI

public struct GoalsMainView: View {
    
    @State private var mainButtonState = true
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var goalsProvider = GoalsProvider()
    
    public init() {
        UITableView.appearance().backgroundColor = UIColor.black
    }
    
    public var body: some View {
        Group {
            if self.goalsProvider.isLoading {
                self.progressView
            } else if self.goalsProvider.isLoading == false && self.goalsProvider.errorLoading == false {
                self.goalsList
            } else {
                self.reloadButton
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing: self.logoutButton)       .onAppear(perform: {
            self.goalsProvider.requestGoals()
        })
    }
    
    var progressView: some View {
        ZStack {
            Color.black
            ProgressView()
                .scaleEffect(1.5)
                .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
        }
    }
    
    var reloadButton: some View {
        ZStack {
            Color.black
            MainButton(action: self.reload,
                       title: "Tentar de novo",
                       status: self.$mainButtonState)
        }
    }
    
    var goalsList: some View {
        ZStack {
            Color.black
            List {
                ForEach(self.goalsProvider.goals?.portfolios ?? [PortifolioModel](), id: \.self) { item in
                    GoalCellView(item: item).listRowBackground(Color.black)
                }
            }.background(Color.black)
        }
    }
    
    var logoutButton: some View {
        Button(action: self.dismiss, label: {
            Text("Logout").foregroundColor(.white)
        })
    }
    
    private func reload() {
        self.goalsProvider.requestGoals()
    }
    
    
    private func dismiss() {
        self.mode.wrappedValue.dismiss()
    }
    
}

struct GoalsMainView_Previews: PreviewProvider {
    static var previews: some View {
        GoalsMainView()
    }
}
