//
//  Config.swift
//  CLPracticeProject
//
//  Created by Shun Zhang on 2020/05/24.
//  Copyright © 2020 Shun Zhang. All rights reserved.
//

import Foundation
import UIKit

enum Config {
    static let `default` = ConfigClass()
}

class ConfigClass{
    
    public struct VCName : Hashable, Equatable, RawRepresentable {
        public var rawValue: String
        

        public init(_ rawValue: String){
            self.rawValue = rawValue
        }

        public init(rawValue: String){
            self.rawValue = rawValue
        }
    }

    func load<T>(viewController clazz: T.Type, name: ConfigClass.VCName) -> T {
        let storyBoard = UIStoryboard(name: name.rawValue, bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: String(describing: clazz)) as! T
    }
}

extension ConfigClass.VCName{
    static let main = ConfigClass.VCName("Main")
}
