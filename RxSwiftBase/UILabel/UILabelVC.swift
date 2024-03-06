//
//  UILabelVC.swift
//  RxSwiftBase
//
//  Created by 张亚飞 on 2024/3/6.
//

import UIKit
import RxCocoa
import RxSwift

class UILabelVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let Label = UILabel(frame: CGRect(x: 88, y: 88, width: 300, height: 100))
        Label.backgroundColor = .gray
        self.view.addSubview(Label)
        
        let Label_01 = UILabel(frame: CGRect(x: 88, y: 288, width: 300, height: 100))
        Label_01.backgroundColor = .gray
        self.view.addSubview(Label_01)
        
        let timer = Observable<Int>.interval(.milliseconds(100), scheduler: MainScheduler.instance)
        timer.map{ String(format: "%0.2d:%0.2d.%0.1d",
                          arguments: [($0 / 600) % 600, ($0 % 600 ) / 10, $0 % 10]) }
            .bind(to: Label.rx.text)
            .disposed(by: disposeBag)
        
        let timer_01 = Observable<Int>.interval(.milliseconds(100), scheduler: MainScheduler.instance)
        timer_01.map(formatTimeInterval)
            .bind(to: Label_01.rx.attributedText)
            .disposed(by: disposeBag)
    }
    

    //将数字转成对应的富文本
    func formatTimeInterval(ms: NSInteger) -> NSMutableAttributedString {
        let string = String(format: "%0.2d:%0.2d.%0.1d",
                            arguments: [(ms / 600) % 600, (ms % 600 ) / 10, ms % 10])
        //富文本设置
        let attributeString = NSMutableAttributedString(string: string)
        //从文本0开始6个字符字体HelveticaNeue-Bold,16号
        attributeString.addAttribute(NSAttributedString.Key.font,
                                     value: UIFont(name: "HelveticaNeue-Bold", size: 16)!,
                                     range: NSMakeRange(0, 5))
        //设置字体颜色
        attributeString.addAttribute(NSAttributedString.Key.foregroundColor,
                                     value: UIColor.white, range: NSMakeRange(0, 5))
        //设置文字背景颜色
        attributeString.addAttribute(NSAttributedString.Key.backgroundColor,
                                     value: UIColor.orange, range: NSMakeRange(0, 5))
        return attributeString
    }

}
