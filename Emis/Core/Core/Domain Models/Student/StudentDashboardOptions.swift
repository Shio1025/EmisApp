//
//  DashboardOptions.swift
//  Core
//
//  Created by Shio Birbichadze on 27.08.23.
//

public struct StudentDashboardOptions {
    var options: [StudentDashboardOption]
    
    init(with options: [String]) {
        self.options = options.map { key in
            StudentDashboardOption(rawValue: key) ?? .none
        }
    }
    
    public var userDashboardOptions: [StudentDashboardOption] {
        var uniqueOptions = [StudentDashboardOption]()
        var seenOptions = Set<StudentDashboardOption>()
        
        for option in options {
            if !seenOptions.contains(option) && option != .none {
                seenOptions.insert(option)
                uniqueOptions.append(option)
            }
        }
        
        return uniqueOptions
    }
}

public enum StudentDashboardOption: String {
    case subjectCard = "SUBJECT_CARD_FOR_STUDENT"
    case subjectRegistration = "SUBJECT_REGISTRATION"
    case library = "LIBRARY"
    case none
}
