//
//  TextViewVC.swift
//  RxSwiftBase
//
//  Created by 张亚飞 on 2024/3/6.
//

import UIKit
import RxCocoa
import RxSwift

class TextViewVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let textField = UITextField(frame: CGRect(x:10, y:88, width:200, height:30))
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(textField)
        
        //当文本框内容改变时，将内容输出到控制台上
//        注意： .orEmpty 可以将 String? 类型的 ControlProperty 转成 String，省得我们再去解包。
//        textField.rx.text.orEmpty.asObservable()
//            .subscribe(onNext: {
//                print("您输入的是：\($0)")
//            })
//            .disposed(by: disposeBag)
        
        //        另外一个写法 changed 效果是一样的
                //当文本框内容改变时，将内容输出到控制台上
        textField.rx.text.orEmpty.changed
            .subscribe(onNext: {
                print("您输入的是：\($0)")
            })
            .disposed(by: disposeBag)
        
        
//        现在我们来实现这样的一个效果
        /**
         我们将第一个 textField 里输入的内容实时地显示到第二个 textField 中。
         同时 label 中还会实时显示当前的字数。
         最下方的“提交”按钮会根据当前的字数决定是否可用（字数超过 5 个字才可用）
         */
        self.textField()
        
        
        
        
    }
    
    
    
    func textField() {
        //创建文本输入框
        let inputField = UITextField(frame: CGRect(x:10, y:150, width:200, height:30))
        inputField.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(inputField)
        
        //创建文本输出框
        let outputField = UITextField(frame: CGRect(x:10, y:200, width:200, height:30))
        outputField.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(outputField)
        
        //创建文本标签
        let label = UILabel(frame:CGRect(x:20, y:300, width:300, height:30))
        self.view.addSubview(label)
        
        //创建按钮
        let button:UIButton = UIButton(type:.system)
        button.frame = CGRect(x:20, y:400, width:40, height:30)
        button.setTitle("提交", for:.normal)
        self.view.addSubview(button)
        
        
        //当文本框内容改变
//        Throttling 是 RxSwift 的一个特性。因为有时当一些东西改变时，通常会做大量的逻辑操作。而使用 Throttling 特性，不会产生大量的逻辑操作，而是以一个小的合理的幅度去执行。比如做一些实时搜索功能时，这个特性很有用。
        let input = inputField.rx.text.orEmpty.asDriver() // 将普通序列转换为 Driver
            .throttle(.microseconds(300)) //在主线程中操作，0.3秒内值若多次改变，取最后一次
        
        //内容绑定到另一个输入框中
        input.drive(outputField.rx.text)
            .disposed(by: disposeBag)
        
        //内容绑定到文本标签中
        input.map{ "当前字数：\($0.count)" }
            .drive(label.rx.text)
            .disposed(by: disposeBag)
        
        let textFields = [inputField, outputField].map({$0!})
        //根据内容字数决定按钮是否可用
        input.map{ $0.count > 5}
            .drive(button.rx.isEnabled)
            .disposed(by: disposeBag)
    }

    

}
