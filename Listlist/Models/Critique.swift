//
//  Critique.swift
//  Listlist
//
//  Created by Sasha Robinson on 2020-09-21.
//

import Foundation

struct Critique {
    
    // Properties of a critique
    // critiquedMedia is the name of the movie, song, etc.
    var critiquedMedia:String?
    var description:String?
    var rating: Int?
    var date:String?
    var authorId:String?
    var author:User?
}
