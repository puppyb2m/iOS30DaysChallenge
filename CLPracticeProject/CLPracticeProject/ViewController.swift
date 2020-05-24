//
//  ViewController.swift
//  CLPracticeProject
//
//  Created by Shun Zhang on 2020/05/24.
//  Copyright © 2020 Shun Zhang. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift
import Promises

// 1. https://www.thedroidsonroids.com/blog/rxswift-by-examples-1-the-basics

class ViewController: UIViewController {
    
    var shownCities = [String]() // Data source for UITableView
    let allCities = ["New York", "London", "Oslo", "Warsaw", "Berlin", "Praga"]
    let disposeBag = DisposeBag()
    
    enum CellConfig{
        enum CellName: String{
            case cell
        }
    }
    
    var modelUpdateShowCitiesBySearching: (String)->Promise<()>{
        return { value in
            self.shownCities = self.allCities.filter{ $0.hasPrefix(value)}
            return Promise(())
        }
    }
    
    var viewReloadTabelView: ()->(){
        return { self.tableView.reloadData() }
    }
    
    var onSearchChanged:(String)->(){
        return { value in
            self.modelUpdateShowCitiesBySearching(value)
                .then(self.viewReloadTabelView)
        }
            
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellConfig.CellName.cell.rawValue)
        shownCities = allCities
        
        searchBar
            .rx.text
            .orEmpty
//            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: self.onSearchChanged)
            .disposed(by: disposeBag)
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellConfig.CellName.cell.rawValue, for: indexPath)
        cell.textLabel?.text = shownCities[indexPath.row]
        return cell
    }
    
    
}

