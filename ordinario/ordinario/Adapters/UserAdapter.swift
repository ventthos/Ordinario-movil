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
        
        return ResponseConfig(
            colors: .init(
                background: modeColors.mainBg,
                cardBackground: modeColors.cardBackground,
                mainColor: modeColors.mainColor,
                mainFontColor: modeColors.mainFontColor,
                inputColor: modeColors.inputColor,
                labelInputColor: modeColors.inputColor,
                announcementsColor: modeColors.announcementsColor,
                gradesColor: modeColors.gradesColor,
                subjectsColor: modeColors.subjectsColor,
                tasksColor: modeColors.taskColor
            ),
            strings: .init(
                greeting: strings.greetings,
                nombreInstitucion: strings.nombreInstitucion
            ),
            values: .init(
                logoUrl: appValues.logoUrl,
                bannerImageUrl: appValues.bannerImageUrl
            ),
            annoucements: .init(
                data.annoucements.map { item in
                    Announcement(
                        title: item.title,
                        message: item.message,
                        date: item.date,
                        imageURL: item.imageUrl
                    )
                }
            )
        )
    }
    
    static func convertUserData(user: UserDataDb) -> UserData{
        return UserData(
            career: user.career,
            email: user.email,
            grades: .init(
                user.grades.map{ item in
                    SemesterGrades(
                        title: item.title,
                        grades: .init(
                            item.subjects.map{ grade in
                                Grade(
                                    subjectName: grade.subjectName,
                                    score: grade.score
                                )
                            }
                        )
                    )
                }
            ),
            group: user.group,
            name: user.name,
            photoUrl: user.photoUrl,
            subjects: .init(
                user.subjects.map{ subject in
                    Subject(
                        name: subject.name,
                        teacherName: subject.teacherName,
                        photoURL: subject.photoURL ?? "",
                        schedule: subject.schedule,
                        description: subject.description
                    )
                }
            )
        )
    }
}
