//
//  RealmManager.swift
//  TQGO
//  realm工具类
//  Created by YXY on 2019/11/15.
//  Copyright © 2019 Techwis. All rights reserved.
//

import Foundation


class RealmManager {
    //MARK: db路径
    static var url:URL = {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first?.fileByAppendingPaths(byAppendingPaths: "/Realm")
        path?.fileCreateDirectory()
        let dbPath = path?.fileByAppendingPaths(byAppendingPaths:"/TQGODB.realm")
        return URL(string: dbPath!)!
    }()
    //MARK: realm单例
    static let instance :Realm = {

        let realm = try! Realm()
        DLog(message: "realm数据库存储路径：\(realm.configuration.fileURL!.absoluteString)")
        return realm
        // 获取 Realm 文件的父目录
//        let folderPath = realm.configuration.fileURL!.deletingLastPathComponent().path
//        // 禁用此目录的文件保护
//        try? FileManager.default.setAttributes([FileAttributeKey.protectionKey : FileProtectionType.none], ofItemAtPath: folderPath)
    
    }()
    
}

extension RealmManager{
    //MARK: 配置Realm 用于数据库迁移
        static func config () {
            
            Realm.Configuration.defaultConfiguration = Realm.Configuration(
                fileURL: url,
                schemaVersion: 1,
                migrationBlock: { migration, oldSchemaVersion in
                    // We haven’t migrated anything yet, so oldSchemaVersion == 0
                    if (oldSchemaVersion < 1) {
                        // 1
                        // Nothing to do!
                        // Realm will automatically detect new properties and removed properties
                        // And will update the schema on disk automatically
                        // 2
                        // 合并两个属性为一个新属性
    //                    migration.enumerateObjects(ofType: UserInfo.className()) { oldObject, newObject in
    //                        // combine name fields into a single field
    //                        let firstName = oldObject!["firstName"] as! String
    //                        let lastName = oldObject!["lastName"] as! String
    //                        newObject!["fullName"] = "\(firstName) \(lastName)"
    //                    }
                        // 3
                        // 属性重命名
                        // The renaming operation should be done outside of calls to `enumerateObjects(ofType: _:)`.
                        // migration.renameProperty(onType: UserInfo.className(), from: "yearsSinceBirth", to: "age")
                    }
            })
            
            
            Realm.asyncOpen { (realm, error) in
                if let _ = realm {
                    print("Realm 服务器配置成功!")
                }else if let error = error {
                    print("Realm 数据库配置失败：\(error.localizedDescription)")
                }
            }
        }
}
