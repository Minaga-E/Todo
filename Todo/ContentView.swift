//
//  ContentView.swift
//  Todo
//
//  Created by Minaga Ekanayake on 26/07/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var todos = [Todo(title: "Feed the cat", isCompleted: true),
                                Todo(title: "Play with cat"),
                                Todo(title: "Get allergies"),
                                Todo(title: "Run away from cat"),
                                Todo(title: "Get a new cat")]
    
    var body: some View {
        NavigationStack {
            List($todos) { $todo in
                
                NavigationLink {
                    TodoDetailView(todo: $todo)
                } label: {
                    HStack {
                        Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                            .onTapGesture {
                                todo.isCompleted.toggle()
                            }
                        VStack {
                            Text(todo.title)
                                .strikethrough(todo.isCompleted)
                            if !todo.subtitle.isEmpty{
                                Text(todo.subtitle)
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                    .strikethrough(todo.isCompleted)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Todos")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
