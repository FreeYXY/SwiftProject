
//
//  UIImage+YYCommon.swift
//  TQGO
//
//  Created by YXY on 2019/10/23.
//  Copyright © 2019 Techwis. All rights reserved.
//

import Foundation
import Photos

extension UIImage{
    
    
    /// 旋转image
    /// - Parameter orientation: 旋转方向
    func imageRotation(orientation:UIImage.Orientation) ->UIImage{
        
        var rotate: Double = 0.0;
        var rect : CGRect = CGRect.zero
        var translateX:CGFloat = 0;
        var translateY: CGFloat = 0;
        var scaleX :CGFloat = 1.0;
        var scaleY :CGFloat = 1.0;
        
        switch (orientation) {
        case .left:
            rotate = Double.pi/2;
            rect = CGRect(x: 0, y: 0, width: self.size.height, height: self.size.width)
            translateX = 0
            translateY = -(rect.size.width)
            scaleY = rect.size.width / rect.size.height
            scaleX = rect.size.height / rect.size.width
            break
        case .right:
            rotate = 3 * Double.pi/2;
            rect = CGRect(x: 0, y: 0, width: self.size.height, height: self.size.width)
            translateX = -(rect.size.height)
            translateY = 0
            scaleY = rect.size.width / rect.size.height
            scaleX = rect.size.height / rect.size.width
            break
        case .down:
            rotate = Double.pi;
            rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
            translateX = -(rect.size.width)
            translateY = -(rect.size.height)
            break
        default:
            rotate = 0.0;
            rect =  CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
            translateX = 0;
            translateY = 0;
            break;
        }
        
        UIGraphicsBeginImageContext(rect.size)
        let context:CGContext?  = UIGraphicsGetCurrentContext()
        //做CTM变换
        context!.translateBy(x: 0, y: rect.size.height)
        context!.scaleBy(x: 1.0, y: -1.0)
        context!.rotate(by: CGFloat(rotate));
        context!.translateBy(x: translateX, y: translateY);
        context!.scaleBy(x: scaleX, y: scaleY);
        //绘制图片
        context?.draw(self.cgImage!, in:  CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height), byTiling: false)
        let newPic:UIImage? = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext()
        return newPic!
    }
    
    
    /// 切圆角
    /// - Parameter radius: 角度
    func cornerRadius(radius: CGFloat) -> UIImage{
        let rect  = CGRect(origin: CGPoint.zero, size: size)
        let bezierPath = UIBezierPath(roundedRect:rect , cornerRadius: radius)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale);
        let context = UIGraphicsGetCurrentContext()
        context?.addPath(bezierPath.cgPath);
        context?.clip()
        draw(in: rect)
        context?.drawPath(using: CGPathDrawingMode.fillStroke)
        let output : UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return output!
        
      
    }
}


extension UIImage{
    
    /// 保存图片至相册
    /// - Parameter albumName: 相册名字
    func savePhoto(albumName:String) {
        var assetsID:String?
        PHPhotoLibrary.shared().performChanges({
            assetsID = PHAssetCreationRequest.creationRequestForAsset(from: self).placeholderForCreatedAsset?.localIdentifier
        }) { (success, error) in
            if success == false {return}
            let assetCollection = self.createAssetCollection(albumName: albumName)
            PHPhotoLibrary.shared().performChanges({
                guard assetsID  !=  nil else{
                    return
                }
                let asset = PHAsset.fetchAssets(withLocalIdentifiers: [assetsID!], options: nil)
                guard assetCollection  !=  nil else{
                    return
                }
                PHAssetCollectionChangeRequest(for:assetCollection!)?.addAssets(asset)
            }) { (success, error) in
                
            }
        }
    }
    
    /// 获取指定名字相册  存在直接返回 不存在则创建
    /// - Parameter albumName: 相册名字
    func createAssetCollection(albumName:String) -> PHAssetCollection? {
        let assetCollections =  PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.album, subtype: PHAssetCollectionSubtype.albumRegular, options: nil)
        for i in  0..<assetCollections.count {
            if  assetCollections[i].localizedTitle == albumName{
                return assetCollections[i]
            }
        }
        var assetsCollectionID:String?
        PHPhotoLibrary.shared().performChanges({
            let request = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: albumName)
            assetsCollectionID = request.placeholderForCreatedAssetCollection.localIdentifier
        }) { (success, error) in
            
        }
        guard assetsCollectionID != nil else{
            return nil
        }
        return PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [assetsCollectionID!], options: nil).lastObject
    }
}
