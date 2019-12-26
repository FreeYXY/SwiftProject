//
//  YXYBanner.swift
//  TQGO
//
//  Created by YXY on 2018/12/3.
//  Copyright © 2018 Techwis. All rights reserved.
//

import UIKit
import Kingfisher

private let YXYBannerViewDefaultCell_id = "YXYBannerViewDefaultCell_id"
typealias YXYBannerViewCustomCellBlock = (_ collectionView: UICollectionView, _ indexPath: IndexPath, _ picture: String) -> UICollectionViewCell

// 滚动方向
enum YXYBannerScrollDirection : Int {
    case top
    case left
    case bottom
    case right
}

class YXYBanner: UIView {
    /** 网络图片 url string 数组 */
    var imageURLStringsGroup:[String] = []{
        didSet{
            // 仅一张轮播图时 不滚动 多张才滚动
            if imageURLStringsGroup.count > 1 {
                collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: scrollPosition, animated: false)
//                self.bringSubviewToFront(self.pageControl)
//                self.pageControl.numberOfPages = self.pictures.count
//                self.pageControl.currentPage = 0
                startTimer()
            }
        }
    }
    // 默认图
    var placeholderImage: UIImage?
    
    /** 每张图片对应要显示的文字数组 */
    var titlesGroup:[String?] = []{
        didSet{
            if titlesGroup.count > 0 {
//                self.pageControlStyle = .right
//                self.titleLab.text = titles.count > self.index ? titles[self.index] : ""
//                self.bringSubviewToFront(self.pageControl)
            }
        }
    }
    
    var didTapActionAtIndexBlock : (( _: Int ) -> Void)?
    // default is 2.0f, 如果小于0.5不自动播放
    var autoScrollDelay: TimeInterval = 2
    
    // 滚动方向
    var direction: YXYBannerScrollDirection = .left {
        willSet {
//            switch newValue {
//            case .left, .top:
//                self.pageControl.currentPage = 0
//                self.index = 0

//            case .right, .bottom:
//                self.pageControl.currentPage = self.pictures.count - 1
//                self.index = self.pictures.count - 1
            }
    }
    
    // pageControl 的对齐方式
//    var pageControlStyle: JPageControlStyle = .center {
//
//        willSet {
    
//        }
//    }
    // 设置图片的ContentMode
    var imageContentMode: UIView.ContentMode?
    
    /// 自定义cell回调
    var customCellBlock: YXYBannerViewCustomCellBlock?
    
    var timer: Timer?
    
    
    convenience init(frame: CGRect,imageURLStringsGroup:[String]?) {
        self.init(frame: frame)
        if let imageURLStringsGroup = imageURLStringsGroup{
            self.imageURLStringsGroup = imageURLStringsGroup
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var datas: [String]? {
        var firstIndex = 0
        var secondIndex = 0
        var thirdIndex = 0
        switch imageURLStringsGroup.count {
        case 0:
            return []
        case 1:
            break
        default:
            firstIndex = (index - 1) < 0 ? imageURLStringsGroup.count - 1 : index - 1
            secondIndex = index
            thirdIndex = (index + 1) > imageURLStringsGroup.count - 1 ? 0 : index + 1
        }
        return [imageURLStringsGroup[firstIndex] ,imageURLStringsGroup[secondIndex] ,imageURLStringsGroup[thirdIndex]]
    }
    var index: Int = 0 {
        willSet {
            if titlesGroup.count > 0 {
//                self.titleLab.text = self.titles.count > newValue ? self.titles[newValue] : ""
            }
        }
    }
    
    lazy var contentOffset: CGFloat = {
        switch self.direction {
        case .left, .right:
            return  collectionView.contentOffset.x
            
        case .top, .bottom:
            return  collectionView.contentOffset.y
        }
    }()
    
    lazy var scrollPosition: UICollectionView.ScrollPosition = {
        switch direction {
        case .left:
            return UICollectionView.ScrollPosition.left
            
        case .right:
            return UICollectionView.ScrollPosition.right
            
        case .top:
            return UICollectionView.ScrollPosition.top
            
        case .bottom:
            return  UICollectionView.ScrollPosition.bottom
        }
    }()
    
    /// 如果需要自定义 AnyClass cell 需调用下面方法
    open func register(_ cellClasss: [Swift.AnyClass?], identifiers: [String], customCellBlock: @escaping YXYBannerViewCustomCellBlock) {
        self.customCellBlock = customCellBlock
        for (index, identifier) in identifiers.enumerated() {
            collectionView.register(cellClasss[index], forCellWithReuseIdentifier: identifier)
        }
    }
    
    lazy var layout:UICollectionViewFlowLayout = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = size
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        switch direction {
        case .left, .right:
            layout.scrollDirection = .horizontal
            
        case .top, .bottom:
            layout.scrollDirection = .vertical
        }
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(YXYCycleScrollViewDefaultCell.self, forCellWithReuseIdentifier: YXYBannerViewDefaultCell_id)
        collectionView.backgroundColor = UIColor.clear
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        addSubview(collectionView)
        return collectionView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout.itemSize = bounds.size
        collectionView.collectionViewLayout = layout
        collectionView.frame = bounds
        startTimer()
    }

    deinit {
        stopTimer()
    }
}

extension YXYBanner:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let customCellBlock = customCellBlock  {
            return customCellBlock(collectionView, indexPath, datas![indexPath.item])
        }else{
            let defaultCell  = collectionView.dequeueReusableCell(withReuseIdentifier: YXYBannerViewDefaultCell_id, for: indexPath) as! YXYCycleScrollViewDefaultCell
            if let imageContentMode = imageContentMode {
                defaultCell.imageView.contentMode = imageContentMode
            }
            if (datas?.count)! < 1{
                defaultCell.imageView.image = placeholderImage
                return defaultCell
            }
            
            if datas![indexPath.item].hasPrefix("http") {
                defaultCell.imageView.kf.setImage(with: URL(string: datas![indexPath.item]), placeholder: placeholderImage)
            } else {
                defaultCell.imageView.image = UIImage(named: datas![indexPath.item])
            }
            return defaultCell
        }
    }

}

extension YXYBanner:UIScrollViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        startTimer()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset: CGFloat = 0
        switch direction {
        case .left, .right:
            offset = scrollView.contentOffset.x
        case .top, .bottom:
            offset = scrollView.contentOffset.y
        }
        
        if offset >= contentOffset * 2 {
            
            if index == imageURLStringsGroup.count - 1 {
                index = 0
            } else {
                index += 1
            }
            collectionView.reloadData()
            collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: scrollPosition, animated: false)
        }
        
        if offset <= 0 {
            if index == 0 {
                index = imageURLStringsGroup.count - 1
            } else {
                index -= 1
            }
            collectionView.reloadData()
            collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: scrollPosition, animated: false)
        }

//        UIView.animate(withDuration: 0.3) {
//
//            self.pageControl.currentPage = self.index
//        }
    }
    // 添加定时器
    func startTimer() {
        if imageURLStringsGroup.count < 1 {
            return
        }
        stopTimer()
        if autoScrollDelay >= 0.5 {
            timer =  Timer.scheduledTimer(withTimeInterval: autoScrollDelay, repeats: true) { (timer) in
                var item: Int = 0
                switch self.direction {
                case .left, .bottom:
                    item = 2
                case .top, .right:
                    item = 0
                }
                self.collectionView.scrollToItem(at: IndexPath(item: item, section: 0), at: self.scrollPosition, animated: true)
            }
            RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)
        }
    }
    
    //关闭定时器
    func stopTimer() {
        if let _ = timer?.isValid {
            timer?.invalidate()
            timer = nil
        }
    }
}


class YXYCycleScrollViewDefaultCell: UICollectionViewCell {
    
    let imageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.size.equalTo(CGSize(width:  frame.width, height: frame.height))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
