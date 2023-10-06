//
//  HowManyMoreView.swift
//  Todo
//
//  Created by Minaga Ekanayake on 16/08/2023.
//

import SwiftUI

struct HowManyMoreView: View {
    
    @ObservedObject var todoManager: TodoManager
    
    var numTodosLeft: Int { todoManager.todos.filter{!$0.isCompleted}.count }
    var numTodosDone: Int {todoManager.todos.filter{$0.isCompleted }.count}
    
    var body: some View {
        VStack{
            Text("You have:")
                .font(.largeTitle)
            Text("\(todoManager.numTodosLeft)")
                .font(.system(size: 140))
                .foregroundColor(.accentColor)
                .padding()
            Text(todoManager.numTodosLeft == 1 ? "todo left.": "todos left.")
                .font(.largeTitle)
            Text("You have completed ^[\(todoManager.numTodosDone) todos](inflect: true). Good Job!")
                .padding(.top)
        }
    }
}

struct HowManyMoreView_Previews: PreviewProvider {
    static var previews: some View {
        HowManyMoreView(todoManager: TodoManager())
    }
}
