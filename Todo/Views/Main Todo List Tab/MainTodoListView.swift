//
//  MainTodoListView.swift
//  Todo
//
//  Created by Minaga Ekanayake on 16/08/2023.
//

import SwiftUI

struct MainTodoListView: View {
    
    @ObservedObject var todoManager: TodoManager
    @State private var showAddSheet = false
    @State private var showConfirmAlert = false
    
    var body: some View {
        NavigationStack {

            List{
                ForEach(todoManager.todosFiltered, editActions: [.all]) {$todo in
                    TodoRowView(todo: Binding(get: { todo }, set: { todo = $0 }))
                }
                .onDelete { indexSet in
                    todoManager.todos.remove(atOffsets: indexSet)
                }
                .onMove { originalOffsets, newOffset in
                    todoManager.todos.move(fromOffsets: originalOffsets, toOffset: newOffset)
                }
            }
            .searchable(text: $todoManager.searchTerm)
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
                    .presentationDetents([.medium ])
            }
            .alert("Load sample data? Warning: This cannot be undone!", isPresented: $showConfirmAlert) {
                Button("Replace", role: .destructive) {
                    todoManager.loadSampleData()
                }
            }

        }
    }
}

struct MainTodoListView_Previews: PreviewProvider {
    static var previews: some View {
        MainTodoListView(todoManager: TodoManager())
    }
}
