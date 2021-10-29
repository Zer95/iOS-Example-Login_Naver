//
//  HomeViewController.swift
//  Login_Naver_Example
//
//  Created by SG on 2021/10/29.
//

import UIKit
import NaverThirdPartyLogin
import Alamofire
import Foundation

class HomeViewController: UIViewController, NaverThirdPartyLoginConnectionDelegate {

    

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var id: UILabel!
    @IBOutlet weak var mobile: UILabel!
    
    
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         getInfo()

        // Do any additional setup after loading the view.
    }
    
    func oauth20ConnectionDidFinishDeleteToken() {
        print("log out")
    }
    
    // 로그인에 성공한 경우 호출
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
      //  getInfo()
        print("Success login")
    }
    
    // referesh token
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        loginInstance?.accessToken
    }
    
    // 모든 error
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("error = \(error.localizedDescription)")
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        loginInstance?.requestDeleteToken()
        self.dismiss(animated: true, completion: nil)
    }
    
    // RESTful API, id가져오기
    func getInfo() {
      guard let isValidAccessToken = loginInstance?.isValidAccessTokenExpireTimeNow() else { return }
      
      if !isValidAccessToken {
        return
      }
      
      guard let tokenType = loginInstance?.tokenType else { return }
      guard let accessToken = loginInstance?.accessToken else { return }
        
      let urlStr = "https://openapi.naver.com/v1/nid/me"
      let url = URL(string: urlStr)!
      
      let authorization = "\(tokenType) \(accessToken)"
      
      let req = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
      
      req.responseJSON { response in
        guard let result = response.value as? [String: Any] else { return }
          
        print("리스폰 값: \(result)")
          
        guard let object = result["response"] as? [String: Any] else { return }
        guard let name = object["name"] as? String else { return }
        guard let email = object["email"] as? String else { return }
        guard let id = object["id"] as? String else {return}
        guard let mobile = object["mobile"] as? String else {return}
       
        
        print(email)
        
        self.nameLabel.text = "\(name)"
        self.emailLabel.text = "\(email)"
        self.id.text = "\(id)"
        self.mobile.text = "\(mobile)"
      }
    }

}
