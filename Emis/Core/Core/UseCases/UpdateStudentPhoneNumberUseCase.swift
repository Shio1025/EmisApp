//
//  UpdateStudentPhoneNumberUseCase.swift
//  Core
//
//  Created by Shio Birbichadze on 27.08.23.
//

import Combine
import Resolver

public protocol UpdatePhoneNumberUseCase {
    func updateStudentPhoneNumber(userId: String,
                                  phoneNumber: String) -> AnyPublisher<Void, Error>
}

public class UpdatePhoneNumberUseCaseImpl: UpdatePhoneNumberUseCase {
    
    @Injected var updatePhoneNumberGateway: UpdatePhoneNumberGateway
    
    public func updateStudentPhoneNumber(userId: String,
                                         phoneNumber: String) -> AnyPublisher<Void, Error> {
        updatePhoneNumberGateway.updateStudentPhoneNumber(userId: userId,
                                                          phoneNumber: phoneNumber)
    }
}
