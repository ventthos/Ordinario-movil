//
//  Grade.swift
//  ordinario
//
//  Created by user286436 on 12/3/25.
//

import Foundation

struct Grade: Identifiable {
    let id = UUID()
    let subjectName: String
    let score: Double
}

struct SemesterGrades {
    let title: String
    let grades: [Grade]
}
