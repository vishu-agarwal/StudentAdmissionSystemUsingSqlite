//
//  StudentListVC.swift
//  StudentManagementSystemCoreData
//
//  Created by DCS on 08/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class StudentListVC: UIViewController {
    
    
    private let studtbl = UITableView()
    private var studArray = [student]()
    
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        view.addSubview(studtbl)
        title = "Student - List"
        setuptbl()
        
        view.backgroundColor = .white
        let additem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newstudfunc))
        navigationItem.setRightBarButton(additem, animated: true)
        
        // Do any additional setup after loading the view.
    }
    
    @objc private func newstudfunc(){
        
        let vc = NewStudvc()
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        studtbl.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        studArray = sqlitehandler.shared.fetch()
        studtbl.reloadData()
        
        
    }
}
extension StudentListVC : UITableViewDelegate, UITableViewDataSource{
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
        
        sqlitehandler.shared.delete(for: id,completion: {
            [weak self] success in
            
            if success {
                self?.studArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                
                let  alert = UIAlertController(title: "Successfully", message: "Deletion Done !!!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {
                    [weak self] _ in
                    
                    self?.studtbl.reloadData()
                    // let vc = StudentListVC()
                    //self?.navigationController?.pushViewController(vc, animated: true)
                }))
                DispatchQueue.main.async {
                    self?.present(alert,animated: true,completion: nil)
                }
                
            }else
            {
                let  alert = UIAlertController(title: "Warning", message: "Some issue while delte data", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                DispatchQueue.main.async {
                    self?.present(alert,animated: true,completion: nil)
                }
            }
            
        })
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = NewStudvc()
        vc.students = studArray[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
}
