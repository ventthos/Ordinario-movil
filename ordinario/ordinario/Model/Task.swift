//
//  Task.swift
//  ordinario
//
//  Created by user286436 on 12/3/25.
//

import Foundation

struct TaskItem: Identifiable, Equatable, Codable{
    var id = UUID()
    let subjectName: String
    let title: String
    let description: String
    let dueDate: Date
    var isCompleted: Bool
}
