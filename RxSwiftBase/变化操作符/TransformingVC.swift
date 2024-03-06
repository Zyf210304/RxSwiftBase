//
//  TransformingVC.swift
//  RxSwiftBase
//
//  Created by 张亚飞 on 2024/3/6.
//

import UIKit
import RxSwift
import RxCocoa

class TransformingVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        testBuffer()
        testwindow()
        
    }
    

    func testBuffer() {
        //buffer  缓冲组合
        let subject = PublishSubject<String>()
        subject
            .buffer(timeSpan: .seconds(2), count: 3, scheduler: MainScheduler.instance)
            .subscribe { item in
                print(item)
//                next(["1", "2", "3"])
//                next(["a", "b", "c"])
//                next(["A"])
//                next([])
            }
            .disposed(by: disposeBag)
        
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
        
        subject.onNext("a")
        subject.onNext("b")
        subject.onNext("c")
        
        subject.onNext("A")
    }
    
    func testwindow() {
        //        window 操作符和 buffer 十分相似。不过 buffer 是周期性的将缓存的元素集合发送出来，而 window 周期性的将元素集合以 Observable 的形态发送出来。
        //        同时 buffer要等到元素搜集完毕后，才会发出元素序列。而 window 可以实时发出元素序列。
        let subject = PublishSubject<String>()
        
        //每3个元素作为一个子Observable发出
        subject
            .window(timeSpan: .seconds(2), count: 3, scheduler: MainScheduler.instance)
            .subscribe { [weak self] in
                print("subscribe:\($0)")
                $0.asObservable()
                    .subscribe(onNext: { print($0) })
                    .disposed(by: self!.disposeBag)
            }
            .disposed(by: disposeBag)
        
        subject.onNext("a")
        subject.onNext("b")
        subject.onNext("c")
//        print("Resources.total ", RxSwift.Resources.total)
        
        subject.onNext("1")
//        print("Resources.total ", RxSwift.Resources.total)
        subject.onNext("2")
        subject.onNext("3")
//        print("Resources.total ", RxSwift.Resources.total)
        
    }
    
    
    

}
