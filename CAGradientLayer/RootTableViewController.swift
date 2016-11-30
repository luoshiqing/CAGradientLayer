//
//  RootTableViewController.swift
//  CAGradientLayer
//
//  Created by sqluo on 2016/11/25.
//  Copyright © 2016年 sqluo. All rights reserved.
//

import UIKit


struct MyCtr {
    var name: String
    var classTyp: String
}


class RootTableViewController: UITableViewController {

    let ctrArray = [MyCtr(name: "渐变色-点击试试", classTyp: "ViewController"),
                    MyCtr(name: "圆环渐变", classTyp: "RingViewController"),
                    MyCtr(name: "心飞扬", classTyp: "HeartFlyViewController"),
                    MyCtr(name: "PickerView", classTyp: "PickerViewController")]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "首页"
        self.view.backgroundColor = UIColor.white
        
        self.tableView.tableFooterView = UIView()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ctrArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "MyCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: identifier)
        }
        
        cell?.textLabel?.text = self.ctrArray[indexPath.row].name
      

        return cell!
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let name = self.ctrArray[indexPath.row].name
        print(name)
        
        let classTyp = self.ctrArray[indexPath.row].classTyp
        if let ctr = NetWork.getClassType(classTyp) {
            ctr.navigationItem.title = name
            self.navigationController?.pushViewController(ctr, animated: true)
        }
        
        
    }

}
