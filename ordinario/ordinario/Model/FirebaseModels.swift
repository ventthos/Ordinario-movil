//
//  FirebaseModels.swift
//  examenu2
//
//  Created by user286436 on 11/20/25.
//


import Foundation

// Root
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
    let cardFontColor: String
    let navBarColor: String
    let navBarColorInactive: String
}

struct AppStrings: Codable, Equatable  {
    let greetings: String
    let nombreInstitucion: String
}

struct AppValues: Codable, Equatable {
    let logoUrl: String
    let bannerImageUrl: String
    let userBannerUrl: String
}

struct AppData: Codable, Equatable {
    let annoucements: [String: AnnouncementInDb]
    let users: [String: UserDataDb]
}

struct AnnouncementInDb: Codable, Equatable  {
    let title: String
    let message: String
    let date: Date?
    let imageUrl: String?
}

// DB representations using dictionaries para grades/subjects internos
struct UserDataDb: Codable, Equatable  {
    let career: String
    let email: String
    let password : String
    let grades: [String: GradeDb]
    let group: String
    let name: String
    let photoUrl: String?
    let subjects: [String: SubjectInfoDb]
}

struct GradeDb: Codable, Equatable {
    let subjects: [String: GradeSubjectDb]
    let title: String
}

struct GradeSubjectDb: Codable, Equatable {
    let score: Double
    let subjectName: String
}

struct SubjectInfoDb: Codable, Equatable {
    let description: String
    let name: String
    let photoURL: String?
    let schedule: String
    let teacherName: String
}


struct ResponseConfig: Equatable  {
    struct Colors: Equatable  {
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
        let cardFontColor:String
        let navBarColor: String
        let navBarColorInactive: String
    }
    struct Strings: Equatable  {
        let greeting: String
        let nombreInstitucion: String
    }

    struct ValuesForApp: Equatable {
        let logoUrl: String
        let bannerImageUrl: String
        let userBannerUrl: String
    }

    
    let colors: Colors
    let strings: Strings
    let values: ValuesForApp
    let annoucements: [Announcement]
    let userData: [UserData]
}
