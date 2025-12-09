//
//  UserAdapter.swift
//  examenu2
//
//  Created by user286436 on 11/20/25.
//


import Foundation

class UserAdapter {
    static func convert(config: AppConfig) -> ResponseConfig {

        // elegir modo
        let isDark = config.mode == "dark"
        let modeColors = isDark ? config.colors.dark : config.colors.light

        // strings
        let strings = config.strings

        // Valores
        let appValues = config.values

        // Data
        let data = config.data

        // Convert announcements dict -> [Announcement] (preserva key como id)
        let announcementsArray: [Announcement] = data.annoucements
            .map { (key, item) in
                Announcement(
                    id: key,
                    title: item.title,
                    message: item.message,
                    date: item.date,
                    imageURL: item.imageUrl
                )
            }
            // opcional: ordenar por id o por date si quieres
            .sorted { $0.id < $1.id }

        // Convert users dict -> [UserData] (preserva key como id)
        let usersArray: [UserData] = data.users
            .map { (key, userDb) -> UserData in

                // grades: [String: GradeDb] -> [SemesterGrades]
                let semesters: [SemesterGrades] = userDb.grades
                    .map { (_, gradeDb) in
                        let gradesList: [Grade] = gradeDb.subjects
                            .map { (_, gradeSubjectDb) in
                                Grade(
                                    subjectName: gradeSubjectDb.subjectName,
                                    score: gradeSubjectDb.score
                                )
                            }
                            // opcional: ordenar
                            .sorted { $0.subjectName < $1.subjectName }

                        return SemesterGrades(
                            title: gradeDb.title,
                            grades: gradesList
                        )
                    }
                    // opcional: ordenar por title
                    .sorted { $0.title < $1.title }

                // subjects: [String: SubjectInfoDb] -> [Subject]
                let subjectsList: [Subject] = userDb.subjects
                    .map { (_, subjectDb) in
                        Subject(
                            name: subjectDb.name,
                            teacherName: subjectDb.teacherName,
                            photoURL: subjectDb.photoURL ?? "",
                            schedule: subjectDb.schedule,
                            description: subjectDb.description
                        )
                    }
                    .sorted { $0.name < $1.name }

                return UserData(
                    id: key,
                    career: userDb.career,
                    email: userDb.email,
                    password: userDb.password,
                    grades: semesters,
                    group: userDb.group,
                    name: userDb.name,
                    photoUrl: userDb.photoUrl,
                    subjects: subjectsList
                )
            }
            // opcional: ordenar por nombre
            .sorted { $0.name < $1.name }

        return ResponseConfig(
            colors: .init(
                background: modeColors.mainBg,
                cardBackground: modeColors.cardBackground,
                mainColor: modeColors.mainColor,
                mainFontColor: modeColors.mainFontColor,
                inputColor: modeColors.inputColor,
                labelInputColor: modeColors.labelInputColor,
                announcementsColor: modeColors.announcementsColor,
                gradesColor: modeColors.gradesColor,
                subjectsColor: modeColors.subjectsColor,
                tasksColor: modeColors.taskColor,
                cardFontColor: modeColors.cardFontColor,
                navBarColor: modeColors.navBarColor,
                navBarColorInactive: modeColors.navBarColorInactive
            ),
            strings: .init(
                greeting: strings.greetings,
                nombreInstitucion: strings.nombreInstitucion,
                homeText: strings.homeText,
                helpUrl: strings.helpUrl
            ),
            values: .init(
                logoUrl: appValues.logoUrl,
                bannerImageUrl: appValues.bannerImageUrl,
                userBannerUrl: appValues.userBannerUrl
            ),
            annoucements: announcementsArray,
            userData: usersArray
        )
    }
}
