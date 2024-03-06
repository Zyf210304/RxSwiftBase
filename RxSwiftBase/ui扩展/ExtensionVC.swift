//
//  ExtensionVC.swift
//  RxSwiftBase
//
//  Created by 张亚飞 on 2024/3/6.
//

import UIKit
import RxCocoa
import RxSwift

class ExtensionVC: BaseViewController {

    @IBOutlet weak var myLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let obsevable = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
        
        obsevable
            //可以在map里面赋予初始值
            .map { CGFloat( $0 + 14) }
//            //使用lable的扩展
//            .bind(to: myLable.fontSize)
            //使用Rx的扩展
            .bind(to: myLable.rx.fontSize)
            .disposed(by: disposeBg)
        
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
//扩展lable
extension UILabel {
    public var fontSize:Binder<CGFloat> {
        return Binder(self) { label, fonSize in
            label.font = UIFont.systemFont(ofSize: fonSize)
        }
    }
}



//扩展rx
extension Reactive where Base: UILabel {
    public var fontSize: Binder<CGFloat> {
        return Binder(self.base) { label, fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}
