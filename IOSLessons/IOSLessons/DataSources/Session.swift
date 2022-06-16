//
//  Session.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 15.06.2022.
//

import Foundation


final class Session {
    static let clientId = "8194842"


    static var instance = Session()

    private init() { }

    var token: String = ""
    var userId: Int = -1
}
