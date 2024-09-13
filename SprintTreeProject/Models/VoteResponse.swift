//
//  VoteResponse.swift
//  SprintTreeProject
//
//  Created by Richard Essemiah on 12/09/2024.
//

import Foundation
import ObjectMapper
/*
 {
     "message": "SUCCESS",
     "id": 1210331,
     "image_id": "asf2",
     "sub_id": "user_id",
     "value": 1,
     "country_code": "NL"
 */

class VoteReponse: Mappable, Identifiable, Hashable {
    static func == (lhs: VoteReponse, rhs: VoteReponse) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        return
    }
    
    var id: String?
    var message: String?
    var imageId: String?
    var subId: String?
    var value: Int?
    var image: CatImage?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        message <- map["message"]
        imageId <- map["image_id"]
        subId <- map["sub_id"]
        value <- map["value"]
        image <- map["image"]
    }
}


