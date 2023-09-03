//
//  gatewaysRegistration.swift
//  Core
//
//  Created by Shio Birbichadze on 26.08.23.
//

import Resolver

extension Resolver {
    
    public static func registerGateways() {
        register(LoginGateway.self) { LoginGatewayImpl() }
        register(StudentInfoGateway.self) { StudentInfoGatewayImpl() }
        register(StudentFinancialGateway.self) { StudentFinancialGatewayImpl() }
        register(StudentDashboardOptionsGateway.self) { StudentDashboardOptionsGatewayImpl() }
        register(StudentSubjectCardGateway.self) { StudentSubjectCardGatewayImpl() }
        register(UpdatePhoneNumberGateway.self) { UpdatePhoneNumberGatewayImpl() }
        register(TeacherDashboardOptionsGateway.self) { TeacherDashboardOptionsGatewayImpl() }
        register(TeacherInfoGateway.self) { TeacherInfoGatewayImpl() }
        register(LibraryGateway.self) { LibraryGatewayImpl() }
        register(TeacherSubjectCardGateway.self) { TeacherSubjectCardGatewayImpl() }
        register(TeacherCourseInfoGateway.self) { TeacherCourseInfoGatewayImpl() }
        register(getStudentGradesGateway.self) { getStudentGradesGatewayImpl() }
        register(UpdateMarkGateway.self) { UpdateMarkGatewayImpl() }
        register(StudentCourseInfoGateway.self) { StudentCourseInfoGatewayImpl() }
        register(SubjectRegistrationFilterGateway.self) { SubjectRegistrationFilterGatewayImpl() }
        register(RegisterSubjectGateway.self) { RegisterSubjectGatewayImpl() }
        register(GetRegisteredSubjectsGateway.self) { GetRegisteredSubjectsGatewayImpl() }
    }
}
