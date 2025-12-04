//
//  GradesViewModel.swift
//  ordinario
//
//  Created by user286436 on 12/3/25.
//

import Foundation

class GradeViewModel: ObservableObject {
    @Published var semesters: [SemesterGrades] = [
        SemesterGrades(
            title: "Semestre 1",
            grades: [
                Grade(subjectName: "Cálculo Integral", score: 87),
                Grade(subjectName: "Programación en Swift", score: 95),
                Grade(subjectName: "Literatura Universal", score: 92)
            ]
        ),
        
        SemesterGrades(
            title: "Ordinario",
            grades: [
                Grade(subjectName: "Cálculo Integral", score: 82),
                Grade(subjectName: "Programación en Swift", score: 90),
                Grade(subjectName: "Literatura Universal", score: 94)
            ]
        )
    ]
    
    var globalAverage: Double {
        let all = semesters.flatMap { $0.grades }
        let total = all.reduce(0) { $0 + $1.score }
        return total / Double(all.count)
    }
}
