//
//  StudentVC.swift
//  StudentAdmissionSystemUsingSqlite
//
//  Created by DCS on 13/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class StudentVC: UIViewController {

    let sid = UserDefaults.standard.string(forKey: "username")
    let sname = UserDefaults.standard.string(forKey: "name")
    let sclass = UserDefaults.standard.string(forKey: "std")
    let sphone = UserDefaults.standard.string(forKey: "phone")
    
    private var studarray = [student]()
    private var noticearray = [note]()
    
    private let namlbl : UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize : 30)
        lbl.textColor = .white
        
        lbl.text = ""
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    private let userlbl : UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize : 30)
        lbl.textColor = .white
        
        lbl.text = ""
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    private let noticelbl : UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize : 15)
        lbl.textColor = .white
        
        lbl.text = ""
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    private let stdlbl : UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize : 30)
        lbl.textColor = .white
        
        lbl.text = ""
        lbl.textAlignment = .center
        
        return lbl
    }()

    private let phonelbl : UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize : 20)
        lbl.textColor = .white
        
        lbl.text = ""
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    private let mybtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("CLICK ME !!", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.borderWidth = 10
        
        btn.addTarget(self, action: #selector(changepwd), for: .touchUpInside)
        btn.backgroundColor = .blue
        btn.layer.cornerRadius = 30
        return btn
    }()
    
    @objc private func changepwd()
    {
        
        let c = studarray.count
        for i in 0..<c
        {
            if sid == studarray[i].spid
            {
                let id = self.studarray[i].spid
                let name = self.studarray[i].studName
                let std = self.studarray[i].standard
                let phn = self.studarray[i].phoneno
                let age = self.studarray[i].age
                
                
                let  alert = UIAlertController(title: "Update Password", message: "This is your password Change it If want !! ", preferredStyle: .alert)
                alert.addTextField{(tf) in
                    tf.text = "\(self.studarray[i].password)"
                    
                }
                let action = UIAlertAction(title: "Submit", style: .default){
                    (_) in
                    guard let pwd = alert.textFields?[0].text
                        else{
                            
                            return
                    }
                    
                    let stud = student(id: id, name: name, password: pwd, phone: phn, std: std, age: age)
                    sqlitehandler.shared.updatepwd(stud: stud)
                    { [weak self] success in
                        if success{
                            
                            let  alert = UIAlertController(title: "Success", message: "", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {[weak self]  _ in
                                
                                let vc = StudentVC()
                                self?.navigationController?.pushViewController(vc, animated: true)
                            }))
                            DispatchQueue.main.async {
                                self!.present(alert,animated: true,completion: nil)
                            }
                        }
                        
                        else{
                            
                            let  alert = UIAlertController(title: "Warning!", message: "Password not updated", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                            DispatchQueue.main.async {
                                self!.present(alert,animated: true,completion: nil)
                            }
                        }
                        
                    }
                    
                }
               alert.addAction(action)
                
                DispatchQueue.main.async {
                    self.present(alert,animated: true,completion: nil)
                }
                
            }
            
        }
        
    }
    
    @objc private func logoutFunc(){
        
        UserDefaults.standard.setValue(nil, forKey: "studToken")
        checkAuth()
    }
    
    private func checkAuth(){
        
        if let token = UserDefaults.standard.string(forKey: "studToken")
            //let name = UserDefaults.standard.string(forKey: "username")
        {
            print("token :: \(sname) | \(token)")
            
        }
        else
        {
            let vc = LoginVc()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.setNavigationBarHidden(true, animated: false)
            present(nav,animated: false)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        title = "Student - Profile"
        
        view.addSubview(userlbl)
        view.addSubview(stdlbl)
        view.addSubview(namlbl)
        view.addSubview(phonelbl)
        view.addSubview(noticelbl)
        view.addSubview(mybtn)
        
        //view.backgroundColor = .black
        
        let additem2 = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(logoutFunc))
        navigationItem.setRightBarButton(additem2, animated: true)
        // Do any additional setup after loading the view.
        
        //checkAuth()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        studarray = sqlitehandler.shared.fetch()
        noticearray = sqlitehandler.shared.nfetch()
        
        let c = noticearray.count
        for i in 0..<c
        {
            noticelbl.text = noticearray[i].msg
        }
        
        namlbl.text = sname
        stdlbl.text = sclass
        userlbl.text = sid
        phonelbl.text = sphone
        
        checkAuth()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        userlbl.frame = CGRect(x: 120, y: view.safeAreaInsets.top + 20, width: 100, height: 100)
        namlbl.frame = CGRect(x: 120, y: userlbl.bottom + 5, width: 100, height: 100)
        stdlbl.frame = CGRect(x: 120, y: namlbl.bottom + 5, width: 100, height: 100)
        phonelbl.frame = CGRect(x: 100, y: stdlbl.bottom + 5, width: 200, height: 100)
        noticelbl.frame = CGRect(x: 5, y: phonelbl.bottom + 5, width: 300, height: 100)
        mybtn.frame = CGRect(x: 80, y: noticelbl.bottom + 1, width: 200, height: 100)
        

        
    }
    
   
}
