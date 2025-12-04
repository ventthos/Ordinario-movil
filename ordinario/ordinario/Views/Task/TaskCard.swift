//
//  TaskCard.swift
//  ordinario
//
//  Created by user286436 on 12/3/25.
//

import SwiftUI
struct TaskCard: View {
    let task: TaskItem
    let toggleCompleted: () -> Void

    let cardBackgroundColor = Color(red: 44/255, green: 44/255, blue: 46/255)
    let accentColor = Color(red: 255/255, green: 87/255, blue: 51/255)

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            HStack {
                Text(task.title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: toggleCompleted) {
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(task.isCompleted ? accentColor : .gray)
                        .font(.title2)
                }
            }
            
            Text(task.description)
                .foregroundColor(.white.opacity(0.8))
                .font(.subheadline)

            HStack {
                Image(systemName: "clock")
                Text("Fecha límite: \(task.dueDate.formatted(date: .abbreviated, time: .shortened))")
                Spacer()
            }
            .foregroundColor(.white.opacity(0.7))
            .font(.footnote)
        }
        .padding()
        .background(cardBackgroundColor)
        .cornerRadius(15)
        .padding(.horizontal)
    }
}
