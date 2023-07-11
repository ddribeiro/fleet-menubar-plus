//
//  User.swift
//  HarmonizeMenuBarExtra
//
//  Created by Dale Ribeiro on 7/11/23.
//

import Foundation

struct User: Codable {
    var user: UserDetail
}

struct UserDetail: Codable, Identifiable {
    var id: Int
    var startDate: Date
    var name: String
    var company: String
    var department: String
    var departmentId: Int
    var jobTitle: String
    var emailAddress: String
    var manager: String
    var assignedApps: [Application]
    
    static let example = UserDetail(id: 1, startDate: .now, name: "Dale Ribeiro", company: "Harmonize Technologies, Inc.", department: "Product", departmentId: 1, jobTitle: "Product Engineer", emailAddress: "dale@harmonize.io", manager: "Dean Clark Jr (Dev)", assignedApps: [.example])
}

struct Application: Codable, Identifiable {
    var id: Int
    var name: String
    var active: Bool
    var expiresInHours: Int?
    var expiredAt: Date?
    var entitled: Bool
    
    static let example = Application(id: 1, name: "Zoom", active: true, expiresInHours: 48, expiredAt: .distantPast, entitled: true)
}
