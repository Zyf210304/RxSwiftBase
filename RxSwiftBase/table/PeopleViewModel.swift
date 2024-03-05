//
//  PeopleViewModel.swift
//  RxSwiftBase
//
//  Created by 张亚飞 on 2024/3/5.
//

import UIKit
import RxSwift

struct PeopleListModel {
    let data = Observable.just([
        People(name: "张三", age: 14),
        People(name: "李四", age: 14),
        People(name: "王五", age: 14),
        People(name: "赵六", age: 14),
    ])
}
