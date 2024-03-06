//
//  BindtoVC.swift
//  RxSwiftBase
//
//  Created by 张亚飞 on 2024/3/6.
//

import UIKit
import RxCocoa
import RxSwift

class BindtoVC: BaseViewController {

    @IBOutlet weak var myLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let obervable = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
        
        //绑定observe
        
        //观察者  处理所有
//        let observe: AnyObserver<String> = AnyObserver { [weak self] event in
//            switch event {
//            case .next(let text):
//                self?.myLable.text = text
//            default:
//                break
//            }
//        }
//
//
//        obervable
//
        
        
        // binder 用于特定场景
        // 不会处理错误事件
        // 确保绑定都是在给定的scheduler上执行 默认 MainScheduler.instance
//        let binderServer: Binder<String> = Binder(myLable){ lab,text in
//            lab.text = text
//        }
//        obervable
//            .map{"当前索引\($0)"}
//            .bind(to: binderServer)
//            .disposed(by: disposeBag)
        
        
        obervable
            .map{"当前索引\($0)"}
            .bind(to: myLable.rx.text)
            .disposed(by: disposeBag)
        
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
