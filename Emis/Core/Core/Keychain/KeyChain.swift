//
//  Keychain.swift
//  Core
//
//  Created by Shio Birbichadze on 20.06.23.
//

public protocol Keychain {
    func save<T>(_ item: T, service: String, account: String) -> Bool where T : Codable
    func read<T>(service: String, account: String, type: T.Type) -> T? where T : Codable
    func delete(service: String, account: String)
}

public class KeychainManager: Keychain {
    
    public static let standard = KeychainManager()
    
    private init() {}
    
    public func save<T>(_ item: T, service: String, account: String) -> Bool where T : Codable {
        do {
            let data = try JSONEncoder().encode(item)
            return save(data, service: service, account: account)
        } catch {
            return false
        }
    }
    
    public func read<T>(service: String, account: String, type: T.Type) -> T? where T : Codable {
        guard let data = read(service: service, account: account) else {
            return nil
        }
        
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            return nil
        }
    }
    
    public func delete(service: String, account: String) {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            ] as CFDictionary
        
        SecItemDelete(query)
    }
}

public extension KeychainManager {
    
    private func save(_ data: Data, service: String, account: String) -> Bool {
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
        ] as CFDictionary
        
        // Add data in query
        var status = SecItemAdd(query, nil)
        
        // Item already exists
        if status == errSecDuplicateItem {
            let query = [
                kSecAttrService: service,
                kSecAttrAccount: account,
                kSecClass: kSecClassGenericPassword,
            ] as CFDictionary
            
            let attributesToUpdate = [kSecValueData: data] as CFDictionary
            
            // Update existing item
            status = SecItemUpdate(query, attributesToUpdate)
        }
        
        return status == noErr
    }
    
    func read(service: String, account: String) -> Data? {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        
        if SecItemCopyMatching(query, &result) == noErr {
            return result as? Data
        }
        
        return nil
    }
}
