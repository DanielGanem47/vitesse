//
//  User.swift
//  Vitesse
//
//  Created by daniel ganem on 23/06/2025.
//

import Foundation

class User: Codable, ObservableObject {
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var password: String = ""
}
