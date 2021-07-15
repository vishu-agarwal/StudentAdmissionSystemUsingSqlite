//
//  ViewController.swift
//  StudentAdmissionSystemUsingSqlite
//
//  Created by DCS on 08/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//
//admin pannel  ..................
import UIKit

class ViewController: UIViewController {

   
    private let myImg: UIImageView = {
        
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 6
   img.image = UIImage(named: "admin")
        img.clipsToBounds = true
        return img
    }()
    
    private let mybtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Student Details", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.borderWidth = 5
        
        btn.addTarget(self, action: #selector(studDetail), for: .touchUpInside)
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 45
        return btn
    }()
    @objc private func studDetail(){
        let vc = StudentListVC()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    private let mybtn2: UIButton = {
        let btn = UIButton()
        btn.setTitle("NoticeBoard Details", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.borderWidth = 5
        
        btn.addTarget(self, action: #selector(noticeDetail), for: .touchUpInside)
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 45
        return btn
    }()
    @objc private func noticeDetail()
    {
        let vc = NoticeVC()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc private func logoutFunc(){
     
     UserDefaults.standard.setValue(nil, forKey: "adminToken")
     checkAuth()
     }
    
     private func checkAuth(){
     
     if let token = UserDefaults.standard.string(forKey: "adminToken"),
     let name = UserDefaults.standard.string(forKey: "username")
     {
     print("token :: \(name) | \(token)")
     
     }
    else
     {
            /*let vc = LoginVc()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.setNavigationBarHidden(true, animated: false)
            present(nav,animated: false)*/
        
        //navigationController?.popViewController(animated: true)
        
        self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Admin"
        view.addSubview(myImg)
        view.addSubview(mybtn)
        view.addSubview(mybtn2)
       // view.addSubview(mylbl)
        
        view.backgroundColor = .white
         let additem2 = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(logoutFunc))
        navigationItem.setRightBarButton(additem2, animated: true)
        // Do any additional setup after loading the view.
        
        checkAuth()
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        myImg.frame = CGRect(x: 40, y: view.safeAreaInsets.top + 30, width: 300, height: 150)
        mybtn.frame = CGRect(x: 80, y: myImg.bottom + 50, width: view.width/2, height: 100)
        mybtn2.frame = CGRect(x: 80, y: mybtn.bottom + 30, width: view.width / 2, height: 100)
        
    }

}

