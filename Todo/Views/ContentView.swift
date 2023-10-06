//
//  ContentView.swift
//  Todo
//
//  Created by Minaga Ekanayake on 26/07/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var todoManager = TodoManager()
    

    
    var body: some View {
        TabView{
            MainTodoListView(todoManager: todoManager)
                .tabItem {
                    Text("Todos")
                    Image(systemName: "checkmark.circle.fill")
                }
            
            HowManyMoreView(todoManager: todoManager)
                .tabItem {
                    Text("How many more?")
                    Image(systemName: "number.circle")
                }
                .badge(todoManager.numTodosLeft)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
