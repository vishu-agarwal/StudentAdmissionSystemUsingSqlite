//
//  NoticeVC.swift
//  StudentAdmissionSystemUsingSqlite
//
//  Created by DCS on 12/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class NoticeVC: UIViewController {

    
    private var noticearray = [note]()
    
    private let noticetbl = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        noticearray = sqlitehandler.shared.nfetch()
        noticetbl.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "NOTICE-BOARD"
        
        view.addSubview(noticetbl)
        
        setuptbl()
        
        view.backgroundColor = .white
        let additem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newNoticefunc))
        navigationItem.setRightBarButton(additem, animated: true)
       /* let additem2 = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(logoutFunc))
        navigationItem.setRightBarButton(additem2, animated: true)*/
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        noticetbl.frame = view.bounds
    }
    
    @objc private func newNoticefunc(){
        
        let vc = NewNoticeVC()
        navigationController?.pushViewController(vc, animated: true)
    }

}
extension NoticeVC : UITableViewDelegate, UITableViewDataSource{
    private func setuptbl(){
        
        noticetbl.register(UITableViewCell.self, forCellReuseIdentifier: "noticecell")
        noticetbl.delegate = self
        noticetbl.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticearray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noticecell", for : indexPath)
        let note  = noticearray[indexPath.row]
        cell.textLabel?.text = "\(String(note.ntitle))"
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
        let id  = noticearray[indexPath.row].nid
        
        sqlitehandler.shared.ndelete(for: String(id),completion:
        {
            [weak self] success in
            if success {
                self?.noticearray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                
                let  alert = UIAlertController(title: "Successfully", message: "Deletion Done !!!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {
                    [weak self] _ in
                   // let vc = NoticeVC()
                    //self?.navigationController?.pushViewController(vc, animated: true)
                    
                    self?.noticetbl.reloadData()
                }))
                DispatchQueue.main.async {
                    self?.present(alert,animated: true,completion: nil)
                }
                
            }
            else
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
        
        let vc = NewNoticeVC()
        vc.notes = noticearray[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
