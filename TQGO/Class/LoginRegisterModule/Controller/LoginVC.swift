//
//  LoginVC.swift
//  TQGO
//
//  Created by YXY on 2019/10/21.
//  Copyright © 2019 Techwis. All rights reserved.
//

import UIKit


class LoginVC: UIViewController {
   
    private let phoneTF = UITextField()
    private let passwordTF = UITextField()
    private let securityCodeTF = UITextField()
    private let loginBtn = UIButton(type: UIButton.ButtonType.custom)
    let segmentView  = UISegmentedControl(items: ["密码登录","短信登录"])
    private var viewModel: LoginVM!
    let disposeBag = DisposeBag()
    lazy var leftImgRect = CGSize(width: 82-15, height: 22)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "登录"
        extendedLayoutIncludesOpaqueBars = true
        navigationController?.navigationBar.isTranslucent = true
        
        let tap = UITapGestureRecognizer()
        view.addGestureRecognizer(tap)
        tap.rx.event.subscribe(onNext: {[weak self] (tap) in
            self?.view.endEditing(true)
        }).disposed(by: disposeBag)
        
        setupView()
        let registerBtn =  UIButton(type: UIButton.ButtonType.custom)
        registerBtn.setTitle("登录", for: UIControl.State.normal)
        registerBtn.setTitleColor(KCOLOR_Base.font_gray, for: UIControl.State.normal)
        registerBtn.titleLabel?.font = kFont(size: 14)
        registerBtn.rx.tap.subscribe(onNext: {[weak self] (sender) in
            self?.navigationController?.pushViewController(RegisterVC(), animated: true)
        }).disposed(by: disposeBag)
            
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: registerBtn)
   
        //MARK: 数据绑定
        viewModel = LoginVM(phoneNum: self.phoneTF.rx.text.orEmpty.asObservable(),
                            password: self.passwordTF.rx.text.orEmpty.asObservable(),
                            securityCode:self.securityCodeTF.rx.text.orEmpty.asObservable(),
                            segment:self.segmentView.rx.selectedSegmentIndex.asObservable())
        viewModel.disposeBag = disposeBag
        viewModel.phoneNumStrOB.bind(to: self.phoneTF.rx.text).disposed(by: disposeBag)
        viewModel.securityCodeStrOB.bind(to: self.securityCodeTF.rx.text).disposed(by: disposeBag)
        viewModel.loginEnableOB.subscribe(onNext: {[weak self] (enable) in
                  self?.loginBtn.isEnabled = enable
                  self?.loginBtn.backgroundColor = enable ? KCOLOR_Base.font_blue : KCOLOR_Base.font_gray
              }).disposed(by: disposeBag)
        
         segmentView.rx.selectedSegmentIndex.subscribe(onNext: {[weak self] (index) in
                    self?.passwordTF.isHidden = (index == 0) ? false : true
                    self?.securityCodeTF.isHidden = (index == 1) ? false : true
        }).disposed(by: disposeBag)
        
        viewModel.requestErrorOB.subscribe(onNext: {[weak self] (apiError) in
            switch apiError {
            case .apiError_done:
                self?.navigationController?.popViewController(animated: true)
            case .apiError_serverMessage(let str):
                self?.view.makeToast(str)
            case .apiError_netError(let str):
                self?.view.makeToast(str)
            }
        }).disposed(by: disposeBag)
        viewModel.loading.bind(to: self.rx.isLoadingAnimating).disposed(by: disposeBag)
       
     }
    
}

extension LoginVC{
    
    //MARK: 布局视图
    func setupView() {
      
        segmentView.selectedSegmentIndex = 0
        segmentView.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:KCOLOR_Base.font_gray], for: UIControl.State.normal)
        segmentView.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:KCOLOR_Base.font_blue], for: UIControl.State.selected)
        segmentView.ensureiOS12Style()
        view.addSubview(segmentView)
        segmentView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(kSafeAreaTopHeight)
            make.height.equalTo(48)
        }
       
        
        let marginView = UIView()
        marginView.backgroundColor = KCOLOR_Base.viewBackground
        view.addSubview(marginView)
        marginView.snp.makeConstraints { (make) in
            make.right.left.equalToSuperview()
            make.top.equalTo(segmentView.snp.bottom)
            make.height.equalTo(kMarginHeight)
        }
        //MARK:手机号码
        phoneTF.placeholder = "请输入手机号码"
        phoneTF.font = kFont(size: 14)
        phoneTF.textColor = KCOLOR_Base.font_black
        phoneTF.keyboardType = UIKeyboardType.numberPad
        phoneTF.clearButtonMode = UITextField.ViewMode.whileEditing
        view.addSubview(phoneTF)
        phoneTF.snp.makeConstraints { (make) in
            make.top.equalTo(marginView.snp.bottom)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(kSectionHeight)
        }
        phoneTF.leftViewWithImgName(imgName: "icon_phone_num", size: leftImgRect)
        
        let lineView = UIView()
        lineView.backgroundColor = KCOLOR_Base.line
        view.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(phoneTF)
            make.top.equalTo(phoneTF.snp.bottom)
            make.height.equalTo(kLineHeight)
        }
        //MARK:密码
        passwordTF.placeholder = "请输入8-16位密码"
        passwordTF.font = kFont(size: 14)
        passwordTF.textColor = KCOLOR_Base.font_black
        passwordTF.keyboardType = UIKeyboardType.default
        passwordTF.clearButtonMode = UITextField.ViewMode.whileEditing
        passwordTF.isSecureTextEntry = true
        view.addSubview(passwordTF)
        passwordTF.snp.makeConstraints { (make) in
            make.top.equalTo(lineView.snp.bottom)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(kSectionHeight)
        }
        passwordTF.leftViewWithImgName(imgName: "icon_security_lock", size: leftImgRect)
        passwordTF.rx.text.orEmpty.subscribe(onNext: {[weak self] (text) in
              if text.count > kLimitPassword{
                self?.phoneTF.text =  text.substring(to: kLimitPassword)
              }
        }).disposed(by: disposeBag)
        
        let line_one = UIView()
        line_one.backgroundColor = KCOLOR_Base.line
        view.addSubview(line_one)
        line_one.snp.makeConstraints { (make) in
            make.left.right.equalTo(lineView)
            make.top.equalTo(lineView.snp.bottom).offset(kSectionHeight)
            make.height.equalTo(kLineHeight)
        }
        //MARK:验证码
        securityCodeTF.isHidden = true
        securityCodeTF.placeholder = "请输入验证码"
        securityCodeTF.font = kFont(size: 14)
        securityCodeTF.textColor = KCOLOR_Base.font_black
        securityCodeTF.keyboardType = UIKeyboardType.numberPad
        securityCodeTF.clearButtonMode = UITextField.ViewMode.whileEditing
        view.addSubview(securityCodeTF)
        securityCodeTF.snp.makeConstraints { (make) in
            make.top.equalTo(lineView.snp.bottom)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(kSectionHeight)
        }
        securityCodeTF.leftViewWithImgName(imgName: "icon_verity_code", size: leftImgRect)
       

        //MARK: 登录
        loginBtn.isEnabled = false
        loginBtn.setTitle("登录", for: UIControl.State.normal)
        loginBtn.setTitleColor(.white, for: UIControl.State.normal)
        loginBtn.titleLabel?.font = kFont(size: 16)
        loginBtn.backgroundColor = KCOLOR_Base.font_gray
        view.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(line_one.snp.bottom).offset(60)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(kSectionHeight)
        }
        loginBtn.cornerRadius(radius: 15)
        loginBtn.rx.tap.subscribe(onNext: {[weak self] (sender) in
            self?.viewModel.loginRequest()
        }).disposed(by: disposeBag)
        
    }
    
    
}
