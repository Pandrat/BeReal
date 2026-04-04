//
//  Post.swift
//  BeReal
//
//  Created by Sean Thelwell on 4/4/26.
//

import Foundation
import ParseSwift

struct Post: ParseObject {
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    var originalData: Data?
    
    var imageFile: ParseFile?
    var caption: String?
    var user: User?
}
