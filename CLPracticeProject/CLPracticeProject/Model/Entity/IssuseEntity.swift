//
//  IssuseEntity.swift
//  CLPracticeProject
//
//  Created by Shun Zhang on 2020/05/24.
//  Copyright © 2020 Shun Zhang. All rights reserved.
//

import Mapper

struct Issue: Mappable {
    
    let identifier: Int
    let number: Int
    let title: String
    let body: String
    
    init(map: Mapper) throws {
        try identifier = map.from("id")
        try number = map.from("number")
        try title = map.from("title")
        try body = map.from("body")
    }
}
