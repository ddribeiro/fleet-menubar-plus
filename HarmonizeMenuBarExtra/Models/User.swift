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
    var devices: [Device]
    var manager: String
    var assignedApps: [Application]
    var gravatarUrl: String
    
    static let example = UserDetail(id: 1, startDate: .now, name: "Dale Ribeiro", company: "Harmonize Technologies, Inc.", department: "Product", departmentId: 1, jobTitle: "Product Engineer", emailAddress: "dale@harmonize.io", devices: [Device(id: 1, policies: [.example])], manager: "Dean Clark Jr (Dev)", assignedApps: [.example], gravatarUrl: "https://0.gravatar.com/avatar/ce8677131ede31409687636dea009c3a")
}

struct Application: Codable, Identifiable, Hashable {
    var id: Int
    var name: String
    var active: Bool
    var accessLevel: String?
    var expiresInHours: Int?
    var expiredAt: Date?
    var entitled: Bool
    
    static let example = Application(id: 1, name: "Zoom", active: true, expiresInHours: 48, expiredAt: .distantPast, entitled: true)
}

struct Device: Codable, Identifiable {
    var id: Int
    var policies: [Policy]
}

struct Policy: Codable, Identifiable {
    var id: Int
    var name: String
    var critical: Bool
    var description: String
    var resolution: String
    var response: String
    
    static let example = Policy(id: 1, name: "Disk Encryption", critical: false, description: "Checks to make sure that full disk encryption (FileVault) is enabled on macOS devices.", resolution: "To enable full disk encryption, on the failing device, select System Preferences > Security & Privacy > FileVault > Turn On FileVault.", response: "fail")
}
