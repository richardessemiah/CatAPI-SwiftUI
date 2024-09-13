//
//  Cat.swift
//  SprintTreeProject
//
//  Created by Richard Essemiah on 12/09/2024.
//

import Foundation
import ObjectMapper

/*
{
    "id": "12p",
    "url": "https://cdn2.thecatapi.com/images/12p.jpg",
    "width": 716,
    "height": 802
}
 */

class CatReponse: Mappable, Identifiable, Hashable {
    static func == (lhs: CatReponse, rhs: CatReponse) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        return 
    }
    
    var id: String?
    var url: String?
    var width: CGFloat?
    var height: CGFloat?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        url <- map["url"]
        width <- map["width"]
        height <- map["height"]
    }
}

class DefaultResponse: Mappable {
    required init?(map: Map) {}
    
    func mapping(map: Map) {}
}
