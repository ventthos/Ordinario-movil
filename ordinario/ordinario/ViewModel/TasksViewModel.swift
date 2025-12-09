//
//  TasksViewModel.swift
//  ordinario
//
//  Created by user286436 on 12/8/25.
//


import SwiftUIclass TasksViewModel: ObservableObject {    @Published var subjects: [Subject] = []    init(user: UserData) {        self.subjects = user.subjects    }    /// Devuelve todas las tareas de todas las materias    var allTasks: [TaskItem] {        subjects.flatMap { $0.tasks }    }    /// Devuelve tareas agrupadas por materia    var groupedTasks: [String: [TaskItem]] {        Dictionary(grouping: allTasks, by: { $0.subjectName })    }    /// Cambia el estado de completed    func toggleTask(_ task: TaskItem) {        for i in subjects.indices {            if let taskIndex = subjects[i].tasks.firstIndex(where: { $0.id == task.id }) {                subjects[i].tasks[taskIndex].isCompleted.toggle()                break            }        }    }}