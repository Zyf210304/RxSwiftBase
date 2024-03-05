//
//  PeopleVC.swift
//  RxSwiftBase
//
//  Created by 张亚飞 on 2024/3/5.
//

import UIKit
import RxCocoa
import RxSwift

class PeopleVC: UIViewController {

    @IBOutlet weak var myTable: UITableView!
    
    let peopleList = PeopleListModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        print("12313")
        
        // Do any additional setup after loading the view.
        myTable.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")

        peopleList.data
            .bind(to: myTable.rx.items(cellIdentifier: "myCell")){_, model, cell in
                cell.textLabel?.text = model.name
                cell.detailTextLabel?.text = String(model.age)
            }.disposed(by: disposeBag)
        
        myTable.rx.modelSelected(People.self).subscribe { people in
            print("选择了\(people.element!.name)")
        }.disposed(by: disposeBag)
        
        myTable.rx.itemSelected.subscribe { indexPath in
            print("选择了\(indexPath.element!.row)")
        }.disposed(by: disposeBag)
        
    }
    
    deinit {
        print(self,"dead")
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
