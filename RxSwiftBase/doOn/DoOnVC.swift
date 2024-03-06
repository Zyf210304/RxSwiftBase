//
//  DoOnVC.swift
//  RxSwiftBase
//
//  Created by 张亚飞 on 2024/3/6.
//

import UIKit
import RxSwift
import RxCocoa

class DoOnVC: BaseViewController {

    //doOn是用来监听时间的生命周期 它会在每次发送前被调用
    //doOn 和 subscribe 是一样的
    //do(onNext:) 会在 subsribe(onNext:)前调用
    //do(onCompleted:) 会在 subsribe(onCompleted:)前调用
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let ob = Observable.of(1, 2, 3)
        
        let _ = ob.do(onNext: { event in
            print("do-->",event)
        }, onCompleted: {
            print("do-->","completed")
        }, onDispose: {
            print("do-->","Disposed")
        })
        .subscribe(onNext: { event in
            print("subscribe-->",event)
        }, onCompleted: {
            print("subscribe-->","completed")
        }, onDisposed: {
            print("subscribe-->","Disposed")
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
