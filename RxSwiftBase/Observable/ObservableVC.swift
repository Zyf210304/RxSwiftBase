//
//  ObservableVC.swift
//  RxSwiftBase
//
//  Created by 张亚飞 on 2024/3/5.
//

import UIKit
import RxSwift
import RxCocoa

enum myError: Error {
    case errorA
    case errorB
}

class ObservableVC: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // Do any additional setup after loading the view.
        
        //just() 需要一个初始值
        let observable1 = Observable<String>.just("string")
        
        //of() 这个方法可以接受可变数量的参数 （要同类型）
        let observable2 = Observable.of("1", "2", "3")
        
        //form() 这个方法需要一个数据
        let observable3 = Observable.from(["1", "2", "3"])
        
        //emyty() 是一个空内容的序列
        let observable4 = Observable<Int>.empty()
        
        //never() 是永远不会发出 event 也不会终止
        let observable5 = Observable<Int>.never()
        
        //error()
        let observable6 = Observable<Error>.error(myError.errorA)
        
        //range() 创建一个范围的序列
        let observable7 = Observable.range(start: 1, count: 5)
        let observable7_0 = Observable.of(1, 2, 3, 4, 5)
        
        //repeatElement() 无限发出给定元素的event (用不终止)
        let observable8 = Observable.repeatElement(1)
        
        //generate() 判断条件为 true 才会执行序列
        let observable9 = Observable.generate(initialState: 0) { item in
            item < 10
        } iterate: { item in
            item + 2
        }
        
        // create() 这个方法接受一个block形式的参数
        let obervable10 = Observable<String>.create { ob in
            ob.onNext("fighting")
            ob.onCompleted()
            return Disposables.create {
                
            }
        }
        
        //deferred() 创建一个工厂
        var isOdd = true
        let factory: Observable<Int> = Observable.deferred {
            isOdd = !isOdd
            
            if isOdd {
               return Observable.of(1, 3, 5, 7)
            } else {
               return Observable.of(2, 4, 6, 8)
            }
        }
        //第一次订阅
        factory.subscribe { event in
            print("\(isOdd)", event)
        }
        //第二次订阅
        factory.subscribe { event in
            print("\(isOdd)", event)
        }
        
        
        //interval() 每隔一段时间，发出一个索引数
        let ob = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        ob.subscribe {event in
            print("ob-->",event)
        }
        .disposed(by: disposeBag)
        
        //timer() 创建一个经过设定的一段时间后 产生唯一的元素
        let ob2 = Observable<Int>.timer(RxTimeInterval.seconds(5), scheduler: MainScheduler.instance)
        ob2.subscribe {event in
            print("ob2--->",event)
        }
        .disposed(by: disposeBag)
        
        
        
        
        //第二种 就是经过设定一段时间 每隔一段时间产生一个元素
        //第一个参数就是等待5秒 第二个参数为每一秒产生一个元素
//        let ob3 = Observable<Int>.timer(RxTimeInterval.seconds(5), period: RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        
        
        
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
