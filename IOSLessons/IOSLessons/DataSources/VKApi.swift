//
//  VKApi.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 16.06.2022.
//

import Foundation

enum VKApi {
    /// авторизация
    case authorize
    /// Получение списка друзей
    case getFriends

    case getProfile

    case getPhotos

    case getGroups

    case searchGroups
}

extension VKApi {
    var endPoint: String {
        switch self {
        case .authorize: return "/authorize"
        case .getProfile: return "/method/account.getProfileInfo"
        case .getFriends: return "/method/friends.get"
        case .getPhotos: return "/method/photos.get"
        case .getGroups: return "/method/groups.get"
        case .searchGroups: return "/method/search.getHints"
        }
    }
}

extension VKApi {
    var host: String {
        switch self {
        case .authorize: return "oauth.vk.com"
        default: return "api.vk.com"
        }
    }
}

