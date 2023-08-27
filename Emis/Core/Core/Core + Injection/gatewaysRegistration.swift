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
    }
}
