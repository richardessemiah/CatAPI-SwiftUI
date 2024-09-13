//
//  FavoritesResponse.swift
//  SprintTreeProject
//
//  Created by Richard Essemiah on 13/09/2024.
//

import Foundation
import ObjectMapper

/*
 {
     "id": 232488318,
     "user_id": "49afrb",
     "image_id": "2rq",
     "sub_id": "richard_ess",
     "created_at": "2024-09-13T11:47:03.000Z",
     "image": {
         "id": "2rq",
         "url": "https://cdn2.thecatapi.com/images/2rq.jpg"
     }
 }
 */

class FavoritesResponse: Mappable, Identifiable, Hashable {
    static func == (lhs: FavoritesResponse, rhs: FavoritesResponse) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        return
    }
    
    var id: String?
    var userIid: String?
    var imageId: String?
    var subId: String?
    var image: CatImage?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        userIid <- map["user_id"]
        imageId <- map["image_id"]
        subId <- map["sub_id"]
        image <- map["image"]
    }
}

/*
 "image": {
     "id": "2rq",
     "url": "https://cdn2.thecatapi.com/images/2rq.jpg"
 }
*/

class CatImage: Mappable, Identifiable, Hashable {
    static func == (lhs: CatImage, rhs: CatImage) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        return
    }
    
    var id: String?
    var url: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        url <- map["url"]
    }
}
