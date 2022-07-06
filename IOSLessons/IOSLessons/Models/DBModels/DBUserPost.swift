//
//  DBUserPost.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 06.07.2022.
//

import Foundation

import RealmSwift

class DBUserPost: Object {
    @Persisted (primaryKey: true) var id: Int
    @Persisted var userId: Int
    @Persisted var date: Int
    @Persisted var text: String
    @Persisted var imageUrls: List<String>
    @Persisted var likeCount: Int
    @Persisted var isLiked: Bool

    override init() {
        super.init()
    }

    required init(_ post: UserPost) {
        super.init()
        id = post.id
        userId = post.userId
        date = post.date
        text = post.text
        imageUrls = List<String>()
        imageUrls.append(objectsIn: post.imageUrls)
        likeCount = post.likeCount
        isLiked = post.isLiked
    }

    public func toModel() -> UserPost {
        let result = UserPost(id: id,
                              userId: userId,
                              date: date,
                              text: text,
                              imageUrls: imageUrls.map( {$0} ),
                              likeCount: likeCount,
                              isLiked: isLiked
        )
        return result
    }
}
