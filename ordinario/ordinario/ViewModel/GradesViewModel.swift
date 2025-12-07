//
//  GradesViewModel.swift
//  ordinario
//
//  Created by user286436 on 12/3/25.
//

import Foundation

class GradeViewModel: ObservableObject {
    
    public func getGlobalAverage(semesters:[SemesterGrades]) -> Double{
        let all = semesters.flatMap { $0.grades }
        let total = all.reduce(0) { $0 + $1.score }
        return total / Double(all.count)
    }
}
