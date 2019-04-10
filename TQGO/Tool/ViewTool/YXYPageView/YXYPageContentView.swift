//
//  YXYPageContentView.swift
//  TQGO
//
//  Created by YXY on 2019/3/21.
//  Copyright © 2019 Techwis. All rights reserved.
//

import UIKit

protocol YXYContenViewProtocol:class {
    func pageContenViewDidScroll(fromIndex:NSInteger,toIndex:NSInteger)
}

let pageContentCollectionCell_id = "pageContentCollectionCell_id"

class YXYPageContentView: UIView {
    var subVCArr:Array<PromotionSubVC>!
    private var parentVC:UIViewController!
    private var startOffsetX:CGFloat = 0;
    weak var pageContenViewDelegate:YXYContenViewProtocol?
    
    var contentViewCurrentIndex = 0{
        didSet{
            if (contentViewCurrentIndex < 0 || contentViewCurrentIndex > subVCArr.count-1) {
                return;
            }
            collectionView.scrollToItem(at: IndexPath(item: contentViewCurrentIndex, section: 0), at: .centeredHorizontally,animated: true)
            
                //    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:contentViewCurrentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
    }

    lazy var collectionView: UICollectionView = {
        
        var layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
    
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.bounces = false;
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier:pageContentCollectionCell_id )
        
        return collectionView
    }()
    
    convenience init(frame:CGRect,subVCArr:[PromotionSubVC],parentVC:UIViewController) {
        self.init(frame: frame)
        self.subVCArr = subVCArr
        self.parentVC = parentVC
        self.addSubview(self.collectionView)
        let _ = subVCArr.map { (vc) -> Void in
            self.parentVC.addChildViewController(vc)
        }
    }
}

extension YXYPageContentView:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subVCArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pageContentCollectionCell_id, for: indexPath)
        cell.addSubview((self.subVCArr?[indexPath.row].view)!)
        return cell
    
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x;

    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let  scrollView_W = scrollView.bounds.size.width;
        let currentOffsetX = scrollView.contentOffset.x;
        let startIndex = floor(startOffsetX/scrollView_W);
        let endIndex = floor(currentOffsetX/scrollView_W);
        if pageContenViewDelegate != nil {
            pageContenViewDelegate!.pageContenViewDidScroll(fromIndex: NSInteger(startIndex), toIndex: NSInteger(endIndex))
        }
    }
}

