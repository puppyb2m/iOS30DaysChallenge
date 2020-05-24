//
//  GithubViewController.swift
//  CLPracticeProject
//
//  Created by Shun Zhang on 2020/05/24.
//  Copyright © 2020 Shun Zhang. All rights reserved.
//
import RxCocoa
import RxSwift
import Promises
import Moya
import Moya_ModelMapper
import UIKit
import RxOptional

class GithubViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var provider: MoyaProvider<GitHub>!
    let disposeBag = DisposeBag()
    enum CellConfig{
        enum CellName: String{
            case cell
        }
    }
    
    var latestRpositoryString:Observable<String>{
        return searchBar
            .rx.text
            .orEmpty
            .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
    }
    
    static func newInstant()->GithubViewController{
        let vc = Config.default.load(viewController: self, name: .main)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBinding()
    }
    
    func setupView(){
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellConfig.CellName.cell.rawValue)
    }
    func setupBinding(){
        provider = MoyaProvider<GitHub>()
        
        let viewModel = IssueTrackerViewModel(provider: provider, repositoryName: latestRpositoryString)
        viewModel
            .trackIssues()
            .bind(to: tableView.rx.items) { tableView, row, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: CellConfig.CellName.cell.rawValue, for: IndexPath(row: row, section: 0))
                cell.textLabel?.text = item.title
                
                return cell
            }
        .disposed(by: disposeBag)
        
        tableView
            .rx.itemSelected
            .subscribe(onNext:{ indexPath in
                if self.searchBar.isFirstResponder == true {
                    self.view.endEditing(true)
                }
            })
            .disposed(by: disposeBag)
        
    }
    
}
