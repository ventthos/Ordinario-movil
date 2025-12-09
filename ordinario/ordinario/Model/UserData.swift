//
//  UserData.swift
//  ordinario
//
//  Created by user286436 on 12/6/25.
//


struct UserData: Codable, Equatable, Identifiable{
    let id: String 
    let career: String
    let email: String
    let password : String
    let grades: [SemesterGrades]
    let group: String
    let name: String
    let photoUrl: String?
    let subjects: [Subject]
}
