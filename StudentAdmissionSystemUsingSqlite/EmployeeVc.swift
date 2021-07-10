//
//  EmployeeVc.swift
//  StudentManagementSystemCoreData
//
//  Created by DCS on 08/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class EmployeeVc: UIViewController {

    
    private let studtbl = UITableView()
    private var studArray = [student]()
    
    @objc private func logoutFunc(){
        
        UserDefaults.standard.setValue(nil, forKey: "sessionToken")
        checkAuth()
    }
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        view.addSubview(studtbl)
        title = "Student"
        setuptbl()
        
        view.backgroundColor = .white
        let additem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newstudfunc))
        navigationItem.setLeftBarButton(additem, animated: true)
        let additem2 = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(logoutFunc))
        navigationItem.setRightBarButton(additem2, animated: true)
        // Do any additional setup after loading the view.
    }
    
    @objc private func newstudfunc(){
        
        let vc = NewStudvc()
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    private func checkAuth(){
        
        if let token = UserDefaults.standard.string(forKey: "sessionToken"),
            let name = UserDefaults.standard.string(forKey: "username")
        {
            print("token :: \(name) | \(token)")
            
        }
        else{
            let vc = LoginVc()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.setNavigationBarHidden(true, animated: false)
            present(nav,animated: false)
            
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        studtbl.frame = view.bounds
    }

    override func viewWillAppear(_ animated: Bool)
    {
        studArray = sqlitehandler.shared.fetch()
        studtbl.reloadData()
         checkAuth()
        
    }
}
extension EmployeeVc : UITableViewDelegate, UITableViewDataSource{
    private func setuptbl(){
        
        studtbl.register(UITableViewCell.self, forCellReuseIdentifier: "studcell")
        studtbl.delegate = self
        studtbl.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studcell", for : indexPath)
        let stud  = studArray[indexPath.row]
        cell.textLabel?.text = "\(stud.spid)\t|\t\(stud.studName)\t|\t\(stud.standard)"
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let id  = studArray[indexPath.row].spid
        
        sqlitehandler.shared.delete(for: id){
            [weak self] success in
            
            if success {
                
               tableView.deleteRows(at: [indexPath], with: .automatic)
                self?.studArray.remove(at: indexPath.row)
            }else
            {
                let  alert = UIAlertController(title: "Warning", message: "Some issue while delte data", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                DispatchQueue.main.async {
                    self?.present(alert,animated: true,completion: nil)
                }
            }
            
        }
    }
    
    
}