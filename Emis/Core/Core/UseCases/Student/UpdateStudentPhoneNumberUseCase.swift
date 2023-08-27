//
//  UpdateStudentPhoneNumberUseCase.swift
//  Core
//
//  Created by Shio Birbichadze on 27.08.23.
//

import Combine
import Resolver

public protocol UpdateStudentPhoneNumberUseCase {
    func updateStudentPhoneNumber(userId: String,
                                  phoneNumber: String) -> AnyPublisher<Void, Error>
}

public class UpdateStudentPhoneNumberUseCaseImpl: UpdateStudentPhoneNumberUseCase {
    
    @Injected var updateStudentPhoneNumberGateway: UpdateStudentPhoneNumberGateway
    
    public func updateStudentPhoneNumber(userId: String,
                                         phoneNumber: String) -> AnyPublisher<Void, Error> {
        updateStudentPhoneNumberGateway.updateStudentPhoneNumber(userId: userId,
                                                                 phoneNumber: phoneNumber)
    }
}
