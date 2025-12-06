//
//  Announcement.swift
//  ordinario
//
//  Created by user286436 on 12/3/25.
//

import Foundation

struct Announcement: Identifiable {
    let id: UUID = UUID()
    let title: String
    let message: String
    let date: Date?
    let imageURL: String?  
}
