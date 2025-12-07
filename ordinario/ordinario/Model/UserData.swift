//
//  UserData.swift
//  ordinario
//
//  Created by user286436 on 12/6/25.
//


struct UserData: Equatable{
    let career: String
    let email: String
    let grades: [SemesterGrades]
    let group: String
    let name: String
    let photoUrl: String?
    let subjects: [Subject]
}
