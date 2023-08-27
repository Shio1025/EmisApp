//
//  TeacherDashboardOptions.swift
//  Core
//
//  Created by Shio Birbichadze on 27.08.23.
//

public struct TeacherDashboardOptions {
    var options: [TeacherDashboardOption]
    
    init(with options: [String]) {
        self.options = options.map { key in
            TeacherDashboardOption(rawValue: key) ?? .none
        }
    }
    
    public var userDashboardOptions: [TeacherDashboardOption] {
        var uniqueOptions = [TeacherDashboardOption]()
        var seenOptions = Set<TeacherDashboardOption>()
        
        for option in options {
            if !seenOptions.contains(option) && option != .none {
                seenOptions.insert(option)
                uniqueOptions.append(option)
            }
        }
        
        return uniqueOptions
    }
}

public enum TeacherDashboardOption: String {
    case subjectCard = "SUBJECT_CARD_FOR_TEACHER"
    case subjectRegistration = "SUBJECT_HISTORY_FOR_TEACHER"
    case library = "LIBRARY"
    case none
}
