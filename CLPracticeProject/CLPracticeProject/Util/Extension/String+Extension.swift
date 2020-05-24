//
//  String+Extension.swift
//  CLPracticeProject
//
//  Created by Shun Zhang on 2020/05/24.
//  Copyright © 2020 Shun Zhang. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var storyboard: UIStoryboard {
        return UIStoryboard(name: self, bundle: nil)
    }

    func load<T>(viewController clazz: T.Type) -> T {
        return storyboard.instantiateViewController(withIdentifier: String(describing: clazz)) as! T
    }
}
