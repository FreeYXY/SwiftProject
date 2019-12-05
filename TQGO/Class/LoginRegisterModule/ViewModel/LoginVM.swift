//
//  LoginVM.swift
//  TQGO
//
//  Created by YXY on 2019/10/29.
//  Copyright © 2019 Techwis. All rights reserved.
//

import Foundation



class LoginVM {
    

    let phoneNumOB : Observable<Bool>
    var phoneNumStrOB : Observable<String>
    let passwordOB : Observable<Bool>
    let passwordStrOB : Observable<String>
    let securityCodeOB: Observable<Bool>
    let securityCodeStrOB: Observable<String>
    let loginEnableOB: Observable<Bool>
    var requestErrorOB: ReplaySubject<APIError> = ReplaySubject<APIError>.create(bufferSize: 1)
    let loading : PublishSubject<Bool> = PublishSubject()
    var disposeBag :DisposeBag?
    
    init(phoneNum: Observable<String>,password: Observable<String>,securityCode:Observable<String>,segment:Observable<Int>) {
        phoneNumStrOB = phoneNum.map{
                  $0.count > kLimitPhone ? $0.substring(to: kLimitPhone) : $0
              }.share(replay: 1)
        
        phoneNumOB = phoneNum
            .map { $0.count == kLimitPhone && $0.isMobileNumberClassification() }
            .share(replay: 1)
        
        passwordStrOB = password
        .map { $0.count > kLimitPassword ? $0.substring(to: kLimitPassword) : $0 }
        .share(replay: 1)
        
        passwordOB = password
            .map { $0.count < kLimitPassword && $0.count >= 8 }
            .share(replay: 1)
        
        securityCodeStrOB = securityCode.map{
            $0.count > kLimitSecurityCode ? $0.substring(to: kLimitSecurityCode) : $0
        }.share(replay: 1)
        
        securityCodeOB = securityCode
            .map { $0.count == kLimitSecurityCode}
            .share(replay: 1)
         
        let loginPasswordEnableOB = Observable.combineLatest(phoneNumOB, passwordOB,segment) { $0 && $1 && ($2 == 0) }
            .share(replay: 1)
        let loginsecurityCodeEnableOB = Observable.combineLatest(phoneNumOB, securityCodeOB,segment) { $0 && $1 && ($2 == 1)}
            .share(replay: 1)
        loginEnableOB  = Observable.combineLatest(loginPasswordEnableOB, loginsecurityCodeEnableOB) { $0 || $1 }.share(replay: 1)
    }

    //MARK: 登录请求
    func loginRequest() {
        var phoneNo = ""
        var loginPwd = ""
        loading.onNext(true)
        phoneNumStrOB.subscribe(onNext: { (str) in
            phoneNo = str
            }).disposed(by: disposeBag!)
        passwordStrOB.subscribe(onNext: { (str) in
            loginPwd = str
        }).disposed(by: disposeBag!)
        
        let param = ["phoneNo":phoneNo,"loginPwd":loginPwd.md5,"loginType":"0"]
        NetworkManager.loadData(api: APIInterfaceLoginRegister.userLogin(params:param), completionClosure: {[weak self] (response) -> (Void) in
            
            self?.loading.onNext(false)
            
            let flag = response.returnCode == KErrorCode.KErrorCode_SUCCESSE.rawValue  ? true : false
            self?.requestErrorOB.onNext(flag ? APIError.apiError_done : APIError.apiError_serverMessage(response.returnMsg ?? ""))
            guard flag == true else{return}
            // 存储用户信息
            guard  let model = UserInfo.deserialize(from: response.toJSONString(), designatedPath: "data") else {return}
            let realm =  RealmManager.instance
            try? realm.write {
                realm.add(model, update: Realm.UpdatePolicy.all)
            }

        }) {[weak self] (fail) -> (Void) in
            // 因未配置真正请求  所以请求必定失败  以下操作为模拟请求成功
            self?.loading.onNext(false)
            self?.requestErrorOB.onNext(APIError.apiError_done)
            
            
            // 此处为真正的请求失败后需做的做操
            // self?.loading.onNext(false)
            // self?.requestErrorOB.onNext(APIError.apiError_serverMessage("网络异常请重试"))
        }
    }
    
}
