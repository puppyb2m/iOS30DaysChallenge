//
//  TravelViewController.swift
//  CLPracticeProject
//
//  Created by Shun Zhang on 2020/06/08.
//  Copyright © 2020 Shun Zhang. All rights reserved.
//

import UIKit

class TravelViewController: UIViewController {
    var viewModel: TravelViewModel = TravelVM()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    static func newInstant()->TravelViewController{
        let vc = Config.default.load(viewController: self, name: .main)
        return vc
    }
}
