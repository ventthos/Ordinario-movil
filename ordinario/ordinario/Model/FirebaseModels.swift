//
//  FirebaseModels.swift
//  examenu2
//
//  Created by user286436 on 11/20/25.
//


import Foundation



struct AppConfig: Codable {
    let colors: ColorModes
    let mode: String
    let strings: AppStrings
    let values: AppValues
    let data: AppData
}

struct ColorModes: Codable {
    let dark: ColorSet
    let light: ColorSet
}

struct ColorSet: Codable {
    let mainBg: String
    let cardBackground: String
    let mainColor: String
    let mainFontColor: String
    let inputColor: String
    let labelInputColor: String
    let announcementsColor: String
    let gradesColor: String
    let subjectsColor: String
    let taskColor: String
}

struct AppStrings: Codable {
    let greetings: String
    let nombreInstitucion: String
}

struct AppValues: Codable{
    let logoUrl: String
    let bannerImageUrl: String
}

struct AppData: Codable{
    let annoucements: [AnnouncementInDb]
    let users: [UserDataDb]
}

struct AnnouncementInDb: Codable {
    let title: String
    let message: String
    let date: Date?
    let imageUrl: String?
}

struct ResponseConfig {
    struct Colors {
        let background: String
        let cardBackground: String
        let mainColor: String
        let mainFontColor: String
        let inputColor: String
        let labelInputColor: String
        let announcementsColor: String
        let gradesColor: String
        let subjectsColor: String
        let tasksColor: String
    }
    struct Strings {
        let greeting: String
        let nombreInstitucion: String
    }

    struct ValuesForApp{
        let logoUrl: String
        let bannerImageUrl: String
    }

    
    let colors: Colors
    let strings: Strings
    let values: ValuesForApp
    let annoucements: [Announcement]
    let userData: [UserData]
}

struct UserDataDb: Codable {
    let career: String
    let email: String
    let grades: [GradeDb]
    let group: String
    let name: String
    let photoUrl: String?
    let subjects: [SubjectInfoDb]
}

struct GradeDb: Codable {
    let subjects: [GradeSubjectDb]
    let title: String
}

struct GradeSubjectDb: Codable {
    let score: Double
    let subjectName: String
}

struct SubjectInfoDb: Codable {
    let description: String
    let name: String
    let photoURL: String?
    let schedule: String
    let teacherName: String
}
