//
//  useCasesRegistration.swift
//  Core
//
//  Created by Shio Birbichadze on 26.08.23.
//

import Resolver

extension Resolver {
    
    public static func registerUseCases() {
        register(LoginUseCase.self) { LoginUseCaseImpl() }
        register(StudentInfoUseCase.self) { StudentInfoUseCaseImpl() }
        register(StudentFinancialUseCase.self) { StudentFinancialUseCaseImpl() }
        register(StudentDashboardUseCase.self) { StudentDashboardUseCaseImpl() }
        register(StudentSubjectCardUseCase.self) { StudentSubjectCardUseCaseImpl() }
        register(UpdateStudentPhoneNumberUseCase.self) { UpdateStudentPhoneNumberUseCaseImpl() }
        register(TeacherDashboardUseCase.self) { TeacherDashboardUseCaseImpl() }
    }
}
