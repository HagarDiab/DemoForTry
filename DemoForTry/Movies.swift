//
//  Movies.swift
//  DemoForTry
//
//  Created by Hagar Diab on 3/19/20.
//  Copyright © 2020 Hagar Diab. All rights reserved.
//

import Foundation

class Movies {
    var id:String!
    var title:String!
    var image:String!
    var rating:Float!
    var releaseDate:String!
    var overview:String!
    
    init(Id:String,Title:String,Image:String,Rating:Float,ReleaseDate:String,Overview:String) {
        
        id=Id
        title=Title
        image=Image
        rating=Rating
        releaseDate=ReleaseDate
        overview=Overview
        
    }
}
