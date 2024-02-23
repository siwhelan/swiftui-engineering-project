//
//  User.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//
import Foundation

import Foundation

public struct User: Decodable, Identifiable {
    public let id = UUID()
    let username: String
    let _id: String
    let password: String
    let email: String
    let avatar: URL?
}
