//
//  BaseViewController.swift
//  RxSwiftBase
//
//  Created by 张亚飞 on 2024/3/6.
//

import UIKit
import RxCocoa
import RxSwift

class BaseViewController: UIViewController {

    let disposeBg = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
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
