//
//  UserDefaults.swift
//  Core
//
//  Created by Shio Birbichadze on 25.08.23.
//

public protocol UserDefault {
    func save<T>(_ item: T, key: String)
    func read<T>(key: String) -> T?
}

public class UserDefaultsManager: UserDefault {
    
    public static let standard = UserDefaultsManager()
    
    private init() {}
    
    
    public func save<T>(_ item: T, key: String) {
        UserDefaults.standard.set(item, forKey: key)
    }
    
    public func read<T>(key: String) -> T? {
        UserDefaults.standard.value(forKey: key) as? T
    }
}
