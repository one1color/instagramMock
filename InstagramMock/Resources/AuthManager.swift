//
//  AuthManager.swift
//  InstagramMock
//
//  Created by Koki on 13.01.22.
//

import FirebaseAuth

public class AuthManager {
    
    static let shared = AuthManager()
    
    //MARK: -Public
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void){
        /*
         - check user name is available
         - check email is available
         */
        
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate {
                //create account
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil , result != nil else {
                        //firebase auth could not create account
                        completion(false)
                        return
                    }
                    //insert account to database
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { inserted in
                        if inserted {
                            completion(true)
                            return
                        }
                        else {
                            //failed insert to database
                            completion(false)
                            return
                        }
                        
                    }

                }
            }
            else {
                // either username or email doesn not exsist
                completion(false)
            }
        }
        
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void){
        if let email = email {
            //email log in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                
            }
        } else if let username = username {
            //username log in
        }
        
    }
}
