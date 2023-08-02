//
//  ContentView.swift
//  Todo
//
//  Created by Minaga Ekanayake on 26/07/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var todoManager = TodoManager()
    
    @State private var showAddSheet = false
    
    @State private var showConfirmAlert = false
    
    var body: some View {
        NavigationStack {
            List{
                ForEach($todoManager.todos, editActions: [.all]) {$todo in
                    TodoRowView(todo: $todo)
                }
                .onDelete { indexSet in
                    todoManager.todos.remove(atOffsets: indexSet)
                }
                .onMove { originalOffsets, newOffset in
                    todoManager.todos.move(fromOffsets: originalOffsets, toOffset: newOffset)
                }
            }
            .navigationTitle("Todos")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItemGroup {
                    #if DEBUG
                    Button {
                        showConfirmAlert = true
                    } label: {
                        Image(systemName: "list.bullet.clipboard.fill")
                    }
                    #endif

                    Button {
                        showAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
            .sheet(isPresented: $showAddSheet) {
                NewTodoView(sourceArray: $todoManager.todos)
            }
            .alert("Load sample data? Warning: This cannot be undone!", isPresented: $showConfirmAlert) {
                Button("Replace", role: .destructive) {
                    todoManager.loadSampleData()
                }
            }

        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
