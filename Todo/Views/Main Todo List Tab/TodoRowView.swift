//
//  TodoRowView.swift
//  Todo
//
//  Created by Minaga Ekanayake on 02/08/2023.
//

import SwiftUI

struct TodoRowView: View {
    @Binding var todo: Todo
    
    var body: some View {
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
}

struct TodoRowView_Previews: PreviewProvider {
    static var previews: some View {
        TodoRowView(todo: .constant(Todo(title: "Testing")))
    }
}
