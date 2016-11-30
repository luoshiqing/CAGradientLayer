//
//  PickerViewController.swift
//  CAGradientLayer
//
//  Created by sqluo on 2016/11/28.
//  Copyright © 2016年 sqluo. All rights reserved.
//

import UIKit

class PickerViewController: BaseViewController ,UIPickerViewDelegate ,UIPickerViewDataSource{

    
    var myPickerView: UIPickerView?
    
    
    var dataArray = [String]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //创建数组
        for item in 0...20 {
            self.dataArray.append("\(item)个")
        }
        
        
        //
        self.loadPickerView()
        
 
        
    }
    
    fileprivate func loadPickerView(){
        
        let toLeft: CGFloat = 40
        let w: CGFloat = self.view.frame.width - 40 * 2
        let h: CGFloat = 200
        let y: CGFloat = (self.view.frame.height - h) / 2
        
        myPickerView = UIPickerView(frame: CGRect(x: toLeft, y: y, width: w, height: h))
        
        
        
        myPickerView?.delegate = self
        myPickerView?.dataSource = self
        
        self.view.addSubview(myPickerView!)
        
        
        
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //设置默认的选择的值
        myPickerView!.selectRow(2, inComponent: 0, animated: false)
        self.myPickerView?.reloadComponent(0)
        
    }
    

    
    
    //代理
    //返回几列
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //每列多少行
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dataArray.count
    }
    
    //设置选择框各选项的内容，继承于UIPickerViewDelegate协议
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        

        
        return self.dataArray[row]
        
    }
    //高度
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    

    
    //自定义
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        //获取当前选择的row
        let r: Int = pickerView.selectedRow(inComponent: component)
        
        print(r)
        
        
        let h: CGFloat = self.pickerView(pickerView, rowHeightForComponent: component)

        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: h))
        
        label.backgroundColor = UIColor.clear
        
        
        
        if row == r {
            label.textColor = UIColor.red
            
            label.font = UIFont.systemFont(ofSize: 22)
        }else{
            label.textColor = UIColor.blue
            
            label.font = UIFont.systemFont(ofSize: 16)
        }
        
        
        
        
        label.textAlignment = .center
        

        let text = self.dataArray[row]
        label.text = text
        
        
        return label
        
    }
    
    
    
    
    
    
    
    //检测响应选项的选择状态
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(component,row)
        
//        let label = self.myPickerView?.view(forRow: row, forComponent: component) as! UILabel
//     
//        label.textColor = UIColor.red
//        
//        label.font = UIFont.systemFont(ofSize: 22)
//    
//        print(self.dataArray[row])
        
        self.myPickerView?.reloadComponent(0)
        
    }
    
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
}
