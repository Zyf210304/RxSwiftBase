//
//  SubscribeVC.swift
//  RxSwiftBase
//
//  Created by 张亚飞 on 2024/3/6.
//

import UIKit
import RxSwift
import RxCocoa
class SubscribeVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        // Do any additional setup after loading the view.
        
        let ob = Observable.of(1, 2, 3)
        let _ = ob.subscribe { event in
            print(event.element ?? 0)
            }
            .disposed(by: disposeBag)
        
        
        //这里要手动输入了
        let _ = ob.subscribe(onNext: { event in
            print(event)
        }, onCompleted: {
            print("completed")
        }, onDisposed: {
            print("Disposed")
        })
    
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
