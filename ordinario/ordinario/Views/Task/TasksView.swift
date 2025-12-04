//
//  TasksView.swift
//  ordinario
//
//  Created by user286436 on 12/3/25.
//

import SwiftUI

struct TasksView: View {
    
    // 📌 Tú inyectas las tareas aquí
    @State var tasks: [TaskItem]

    let primaryBackground = Color(red: 28/255, green: 28/255, blue: 30/255)
    let cardBackgroundColor = Color(red: 44/255, green: 44/255, blue: 46/255)
    let accentColor = Color(red: 255/255, green: 87/255, blue: 51/255)

    var body: some View {
        ZStack {
            primaryBackground.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    
                    // Título
                    Text("Tareas")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .padding(.top)

                    // Agrupado por materia
                    let grouped = Dictionary(grouping: tasks, by: { $0.subjectName })

                    ForEach(grouped.keys.sorted(), id: \.self) { subject in
                        VStack(alignment: .leading, spacing: 10) {

                            Text(subject)
                                .font(.title2.bold())
                                .foregroundColor(.white)
                                .padding(.leading)

                            ForEach(grouped[subject]!) { task in
                                TaskCard(
                                    task: task,
                                    toggleCompleted: { toggleTask(task) }
                                )
                            }
                        }
                    }
                }
                .padding(.bottom, 40)
            }
        }
        .preferredColorScheme(.dark)
    }

    // 📌 Actualiza solo localmente
    func toggleTask(_ task: TaskItem) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
}


#Preview {
    TasksView(tasks: [
        TaskItem(
            subjectName: "Cálculo Integral",
            title: "Tarea 1: Integrales",
            description: "Resolver los ejercicios del 1 al 10.",
            dueDate: Date().addingTimeInterval(86400),
            isCompleted: false
        ),
        TaskItem(
            subjectName: "Programación en Swift",
            title: "Proyecto UI",
            description: "Crear una interfaz usando VStack y HStack.",
            dueDate: Date().addingTimeInterval(172800),
            isCompleted: true
        )
    ])
}
