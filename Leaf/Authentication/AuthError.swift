//
//  AuthError.swift
//  Leaf
//
//  Created by Mohamed Atallah on 04/09/2025.
//

import Foundation

enum AuthError: String, Error {
    case NotAuthenticated
    case EmptyEmailOrPassword = "Empty Email or Password, Check again!"
}
