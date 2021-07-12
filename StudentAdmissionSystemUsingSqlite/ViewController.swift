//
//  ViewController.swift
//  StudentAdmissionSystemUsingSqlite
//
//  Created by DCS on 08/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let mylbl : UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize : 50)
        lbl.textColor = .white
        
        lbl.text = "Welcome !!"
        lbl.textAlignment = .center
        
        return lbl
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
        let vc = EmployeeVc()
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Admin"
        
        view.addSubview(mybtn)
        view.addSubview(mybtn2)
        view.addSubview(mylbl)
        
        view.backgroundColor = .brown
        
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        mylbl.frame = CGRect(x: 75, y: view.safeAreaInsets.top + 30, width: view.width, height: 80)
        mybtn.frame = CGRect(x: 75, y: mylbl.bottom + 40, width: view.width/2, height: 100)
        mybtn2.frame = CGRect(x: 75, y: mybtn.bottom + 20, width: view.width / 2, height: 100)
        
    }

}

