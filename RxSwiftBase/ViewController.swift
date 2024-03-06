//
//  ViewController.swift
//  RxSwiftBase
//
//  Created by 张亚飞 on 2024/3/5.
//

import UIKit
import RxSwift
import RxCocoa

struct DataModel {
    let className: UIViewController.Type?
    let name: String?
}

struct DataListModel {
    let data = Observable.just([
        DataModel(className: PeopleVC.self, name: "tableView"),
        DataModel(className: ObservableVC.self, name: "Observable"),
        DataModel(className: SubscribeVC.self, name: "subscribe")
    ])
}

class ViewController: UIViewController {

    @IBOutlet weak var myTable: UITableView!
    
    let disposeBag = DisposeBag()
    let dataList = DataListModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "RxSwift"
        
        myTable.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        
        dataList.data
            .bind(to: myTable.rx.items(cellIdentifier: "myCell")) {_, model, cell in
                cell.textLabel?.text = model.name
            }.disposed(by: disposeBag)
        
        myTable.rx.modelSelected(DataModel.self).subscribe { event in
            let lVCClass = event.element?.className
            if let lVCClass = lVCClass {
                let  lVC = lVCClass.init()
//                print(event)
                self.navigationController?.pushViewController(lVC, animated: true)
            }
        }.disposed(by: disposeBag)
        
        
    }


}

