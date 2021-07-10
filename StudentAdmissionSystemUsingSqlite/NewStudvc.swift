//
//  NewStudvc.swift
//  StudentManagementSystemCoreData
//
//  Created by DCS on 08/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class NewStudvc: UIViewController {
    
    
    var students : student?

    private let spidtxt:UITextField = {
        let txt = UITextField()
        txt.placeholder = "Enter SPID"
        txt.textColor = .blue
        txt.borderStyle = .roundedRect
        txt.font = UIFont(name : "", size : 20.0)
        txt.textAlignment = .center
        
        return txt
    }()
    
    private let nametxt:UITextField = {
        let txt = UITextField()
        txt.placeholder = "Enter Name"
        txt.textColor = .blue
        txt.borderStyle = .roundedRect
        txt.font = UIFont(name : "", size : 20.0)
        txt.textAlignment = .center
        
        return txt
    }()
    private let agetxt:UITextField = {
        let txt = UITextField()
        txt.placeholder = "Enter Age"
        txt.textColor = .blue
        txt.borderStyle = .roundedRect
        txt.font = UIFont(name : "", size : 20.0)
        txt.textAlignment = .center
        
        return txt
    }()
    private let citytxt:UITextField = {
        let txt = UITextField()
        txt.placeholder = "Enter city"
        txt.textColor = .blue
        txt.borderStyle = .roundedRect
        txt.font = UIFont(name : "", size : 20.0)
        txt.textAlignment = .center
        
        return txt
    }()
    
    private let phonetxt:UITextField = {
        let txt = UITextField()
        txt.placeholder = "Enter Phone No"
        txt.textColor = .blue
        txt.borderStyle = .roundedRect
        txt.font = UIFont(name : "", size : 20.0)
        txt.textAlignment = .center
        
        return txt
    }()

    private let stdtxt:UITextField = {
        let txt = UITextField()
        txt.placeholder = "Enter Class"
        txt.textColor = .blue
        txt.borderStyle = .roundedRect
        txt.font = UIFont(name : "", size : 20.0)
        txt.textAlignment = .center
        
        return txt
    }()
    
    
    private let mybtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Save Me!!", for: .normal)
        btn.addTarget(self, action: #selector(savestud), for: .touchUpInside)
        btn.backgroundColor = .green
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    
    
    @objc private func savestud()
    {
        let name = nametxt.text!
        let id = spidtxt.text!
        let city = citytxt.text!
        let std = stdtxt.text!
        let age = Int(agetxt.text!)!
        let phone = phonetxt.text!
        let stud  = student(id: id, name: name, city: city, phone: phone, std: std, age: age)
        /*
        sqlitehandler.shared.insert(stud: stud){
            [weak self] success in
            
            if success {
                
                let  alert = UIAlertController(title: "Success!", message: "insert datra successfully", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {[weak self]  _ in self?.navigationController?.popViewController(animated: true)}))
                DispatchQueue.main.async {
                    self?.present(alert,animated: true,completion: nil)
                }
            }else
            {
                let  alert = UIAlertController(title: "Warniong", message: "Some issue while save data", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                DispatchQueue.main.async {
                    self?.present(alert,animated: true,completion: nil)
                }
            }
            
        }*/
        
        if let stud = students{
            
            let updatestud = student(id: stud.spid, name: stud.studName, city: stud.city, phone: stud.phoneno, std: stud.standard, age: stud.age)
            update(stud:updatestud)
            
        }
        else{
            let insertstud =  student(id: stud.spid, name: stud.studName, city: stud.city, phone: stud.phoneno, std: stud.standard, age: stud.age)
            insert(stud: insertstud)
            
        }
        
        
    }

    private func insert (stud : student)
        {
            sqlitehandler.shared.insert(stud: stud){
                [weak self] success in
                
                if success {
                    
                    let  alert = UIAlertController(title: "Success!", message: "insert datra successfully", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {[weak self]  _ in self?.navigationController?.popViewController(animated: true)}))
                    DispatchQueue.main.async {
                        self?.present(alert,animated: true,completion: nil)
                    }
                }else
                {
                    let  alert = UIAlertController(title: "Warniong", message: "Some issue while save data", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                    DispatchQueue.main.async {
                        self?.present(alert,animated: true,completion: nil)
                    }
                }
                
            }
            
            
    }
    
    private func update (stud : student)
    {
        sqlitehandler.shared.update(stud: stud){
            [weak self] success in
            
            if success {
                
                let  alert = UIAlertController(title: "Success!", message: "insert datra successfully", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {[weak self]  _ in self?.navigationController?.popViewController(animated: true)}))
                DispatchQueue.main.async {
                    self?.present(alert,animated: true,completion: nil)
                }
            }else
            {
                let  alert = UIAlertController(title: "Warniong", message: "Some issue while save data", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                DispatchQueue.main.async {
                    self?.present(alert,animated: true,completion: nil)
                }
            }
            
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(spidtxt)
        view.addSubview(agetxt)
        view.addSubview(citytxt)
        view.addSubview(nametxt)
        view.addSubview(phonetxt)
        view.addSubview(stdtxt)
        view.addSubview(mybtn)
        view.backgroundColor = .black
        if let stud = students{
            
            spidtxt.text = stud.spid
            nametxt.text = stud.studName
            citytxt.text = stud.city
            phonetxt.text = stud.phoneno
            stdtxt.text = stud.standard
            agetxt.text = String(stud.age)
            
            
            
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
       spidtxt.frame = CGRect(x: 40, y: view.safeAreaInsets.top + 20, width: view.width - 80, height: 40)
        nametxt.frame = CGRect(x: 40, y: spidtxt.bottom + 10, width: view.width - 80, height: 40)
        agetxt.frame = CGRect(x: 40, y: nametxt.bottom + 10, width: view.width - 80, height: 40)
        stdtxt.frame = CGRect(x: 40, y: agetxt.bottom + 10, width: view.width - 80, height: 40)
        phonetxt.frame = CGRect(x: 40, y: stdtxt.bottom + 10, width: view.width - 80, height: 40)
        citytxt.frame = CGRect(x: 40, y: phonetxt.bottom + 10, width: view.width - 80, height: 40)
        mybtn.frame = CGRect(x: 40, y: citytxt.bottom + 10, width: view.width - 80, height: 40)
    }

}

