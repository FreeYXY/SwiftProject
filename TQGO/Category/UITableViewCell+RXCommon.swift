//
//  UITableViewCell+RXCommon.swift
//  TQGO
//
//  Created by YXY on 2019/11/5.
//  Copyright © 2019 Techwis. All rights reserved.
//

import Foundation
import UIKit
extension Reactive where Base: UITableViewCell {
    // 提供给外界重用序列
    public var prepareForReuse: RxSwift.Observable<Void> {
        var prepareForReuseKey: Int8 = 0
        if let prepareForReuseOB = objc_getAssociatedObject(base, &prepareForReuseKey) as? Observable<Void> {
            return prepareForReuseOB
        }
        let prepareForReuseOB = Observable.of(
            sentMessage(#selector(Base.prepareForReuse)).map { _ in }
            , deallocated)
            .merge()
        objc_setAssociatedObject(base, &prepareForReuseKey, prepareForReuseOB, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)

        return prepareForReuseOB
    }
    // 提供一个重用垃圾回收袋
    public var reuseBag: DisposeBag {
        MainScheduler.ensureExecutingOnScheduler()
        var prepareForReuseBag: Int8 = 0
        if let bag = objc_getAssociatedObject(base, &prepareForReuseBag) as? DisposeBag {
            return bag
        }
        
        let bag = DisposeBag()
        objc_setAssociatedObject(base, &prepareForReuseBag, bag, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        
        _ = sentMessage(#selector(Base.prepareForReuse))
            .subscribe(onNext: { [weak base] _ in
                let newBag = DisposeBag()
                guard let base = base else {return}
                objc_setAssociatedObject(base, &prepareForReuseBag, newBag, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            })
        return bag
    }
}

/*
 处理cell响应button事件时的  cell复用导致序列重复订阅响应
 方式一：
重用响应prepareForReuse,只要发现我们的cell已发生重用，通过RxSwift就会接受到一个重用序列的响应，起到绑定效果
这里还合并了cell的销毁序列，毕竟cell都销毁了也就没有任何响应的意义
cell.button.rx.tap.takeUntil(cell.rx.prepareForReuse)
    .subscribe(onNext: { () in
        print("点击了 \(indexPath)")
    })
通过takeUntil限定了button的点击响应能力
 
 
 方式二：
cell.button.rx.tap
    .subscribe(onNext: { () in
        print("点击了 \(indexPath)")
    })
    .disposed(by: cell.rx.reuseBag)

作者：Cooci_和谐学习_不急不躁
链接：<a href='https://www.jianshu.com/p/1c186afdae3b'>https://www.jianshu.com/p/1c186afdae3b</a>
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 
 方式三： 基类封装
 class LGCustomCell: UITableViewCell{
 var disposeBag = DisposeBag()
 override func prepareForReuse() {
         super.prepareForReuse()

         disposeBag = DisposeBag()
     }
 }

 作者：Cooci_和谐学习_不急不躁
 链接：<a href='https://www.jianshu.com/p/1c186afdae3b'>https://www.jianshu.com/p/1c186afdae3b</a>
 来源：简书
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
*/
