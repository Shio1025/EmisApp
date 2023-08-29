//
//  ResolverRegistration + Routers.swift
//  Emis
//
//  Created by Shio Birbichadze on 11.05.23.
//

import Resolver

extension Resolver {
    public static func registerRouters() {
        register {
            LoginPageRouter()
        }
        register {
            ProfilePageRouter()
        }
        register {
            MoreMenuRouter()
        }
        register {
            PasswordResetRouter()
        }
        register {
            MainPageRouter()
        }
    }
}
