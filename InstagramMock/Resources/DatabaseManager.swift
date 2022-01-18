//
//  DatabaseManager.swift
//  InstagramMock
//
//  Created by Koki on 13.01.22.
//

import FirebaseDatabase

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database(url: "https://instagrammock-ed6fa-default-rtdb.europe-west1.firebasedatabase.app").reference()
    
    //MARK: -Public
    
    /// Check if the username and email is available
    /// - Parameters
    ///     - email: String representing email
    ///     - username: String representing username
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void ) {
        completion(true)
    }
    
    /// Insert username and password to database
    /// - Parameters
    ///     - email: String representing email
    ///     - username: String representing username
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        database.child(email.safeDatabaseKey()).setValue(["username": username]) { error, _ in
            if error == nil {
                //success
            }
            else {
                //failed
            }
        }
    }
}
