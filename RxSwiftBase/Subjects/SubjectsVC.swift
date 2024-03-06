//
//  SubjectsVC.swift
//  RxSwiftBase
//
//  Created by 张亚飞 on 2024/3/6.
//

import UIKit
import RxCocoa
import RxSwift

class SubjectsVC: BaseViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //PublishSubject 创建不需要付初始值  只能收到后面的事件 前面的事件 接收不到
        let subject = PublishSubject<String>()
        subject.onNext("0000")
        
        subject.subscribe { string in
            print("第一次订阅", string)
        } onError: { error in
            print(error)
        } onCompleted: {
            print("第一次 completed")
        }.disposed(by: disposeBg)
        
        subject.onNext("1111")
        
        subject.subscribe { string in
            print("第二次订阅", string)
        } onError: { error in
            print(error)
        } onCompleted: {
            print("第二次 completed")
        }.disposed(by: disposeBg)
        
        subject.onNext("2222")
        subject.onCompleted()
        
        subject.onNext("3333")
        subject.subscribe { string in
            print("第三次订阅", string)
        } onError: { error in
            print(error)
        } onCompleted: {
            print("第三次 completed")
        }.disposed(by: disposeBg)
        subject.onNext("4444")
        
        subject.onCompleted()
//        第一次订阅 1111
//        第一次订阅 2222
//        第二次订阅 2222
//        第一次 completed
//        第二次 completed
//        第三次 completed
        print("\n\n\n\n")
        
        
        //behaviorSubject 需要一个默认值来创建  可以接受临近 最上面的一个消息
         let subject2 = BehaviorSubject(value: 111)
        
        subject2.onNext(000)
        subject2.subscribe { event in
            print("BehaviorSubject 第一次订阅", event)
        }.disposed(by: disposeBg)
        
        subject2.onNext(222)
        subject2.onNext(333)
        subject2.onError(NSError(domain: "local", code: 0, userInfo: nil))
        
        subject2.subscribe{ event in
            print("BehaviorSubject 第二次订阅", event)
        }
        .disposed(by: disposeBg)
//        BehaviorSubject 第一次订阅 next(0)
//        BehaviorSubject 第一次订阅 next(222)
//        BehaviorSubject 第一次订阅 next(333)
//        BehaviorSubject 第二次订阅 next(333)
        print("\n\n\n\n")
        
        // ReplaySubject  buffersize缓存数量
        let subject3 = ReplaySubject<String>.create(bufferSize: 2)
        subject3.onNext("1111")
        subject3.onNext("2222")
        subject3.onNext("3333")
        subject3.subscribe { event in
            print("第一次订阅", event)
        }
        .disposed(by: disposeBg)
        subject3.onNext("4444")
        
        
        subject3.subscribe { event in
            print("第二次订阅", event)
        }
        .disposed(by: disposeBg)
        
        subject3.onCompleted()
        subject3.subscribe { event in
            print("第三次订阅", event)
        }
        .disposed(by: disposeBg)
//        第一次订阅 next(2222)
//        第一次订阅 next(3333)
//        第一次订阅 next(4444)
//        第二次订阅 next(3333)
//        第二次订阅 next(4444)
//        第一次订阅 completed
//        第二次订阅 completed
//        第三次订阅 next(3333)
//        第三次订阅 next(4444)
//        第三次订阅 completed
        print("\n\n\n\n")
        

        
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
