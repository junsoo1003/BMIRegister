//
//  ViewController.swift
//  BMIRegister
//
//  Created by junsoo on 12/11/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, AddViewControllerDelegate {
    
    

    
    @IBOutlet weak var tableView: UITableView!
    
    // (String, String, String, String, String) 형태로 되어 있는 튜플로 된 배열 생성
    var array: [(String, String, String, String, String)] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addVC = segue.destination as? AddViewController {
            addVC.delegate = self
        }
    }
    
    func didUpdateBMI(tuple: (String, String, String, String, String)) {
        array.append(tuple)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        cell.labelDateAndTime.text = array[indexPath.row].0
        cell.labelHeight.text = array[indexPath.row].1
        cell.labelWeight.text = array[indexPath.row].2
        cell.labelBMI.text = array[indexPath.row].3
        cell.labelStatus.text = array[indexPath.row].4
        return cell
    }
    
    
}

