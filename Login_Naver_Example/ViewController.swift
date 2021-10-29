//
//  ViewController.swift
//  Login_Naver_Example
//
//  Created by SG on 2021/10/28.
//

import Foundation
import UIKit
import NaverThirdPartyLogin

class ViewController: UIViewController, NaverThirdPartyLoginConnectionDelegate {
    
    
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    override func viewDidLoad() {
        loginInstance?.delegate = self
    }
    
    // 로그인에 성공한 경우 호출
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        performSegue(withIdentifier: "successLogin", sender: nil)
        print("Success login")
    }
    
    // referesh token
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        loginInstance?.accessToken
    }
    
    // 로그아웃
    func oauth20ConnectionDidFinishDeleteToken() {
        print("log out")
    }
    
    // 모든 error
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("error = \(error.localizedDescription)")
    }
    
    @IBAction func naverLoginBtn(_ sender: Any) {
        loginInstance?.requestThirdPartyLogin()
    }
    
}

