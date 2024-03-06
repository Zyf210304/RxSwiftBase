//
//  DisposeVC.swift
//  RxSwiftBase
//
//  Created by 张亚飞 on 2024/3/6.
//

import UIKit
import RxSwift
import RxCocoa

class DisposeVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let ob = Observable.of(1, 2, 4)
        let sub = ob.subscribe { event in
            print(event)
        }
//        自动释放
            .disposed(by: disposeBg)
        
        //手动释放
//        sub.dispose()
        
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
