//
//  TravelViewModel.swift
//  CLPracticeProject
//
//  Created by Shun Zhang on 2020/06/08.
//  Copyright © 2020 Shun Zhang. All rights reserved.
//

import Foundation

protocol TravelViewModel {
    var title: String { get }
}

class TravelVM: TravelViewModel{
    var title: String { return "What you would like to find"}
    
    
}
