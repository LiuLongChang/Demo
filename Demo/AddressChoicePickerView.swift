//
//  AddressChoicePickerView.swift
//  Demo
//
//  Created by langyue on 16/1/6.
//  Copyright © 2016年 langyue. All rights reserved.
//

import UIKit


class AreaObject: NSObject {
    
    var region : String = ""
    var province : String = ""
    var city : String = ""
    var area : String = ""
    
}





class AddressChoicePickerView: UIView,UIPickerViewDataSource,UIPickerViewDelegate {
    
    typealias addressChoicePickerViewBlock = (view:AddressChoicePickerView,btn: UIButton,locate: AreaObject)->Void
    
    
    
    @IBOutlet weak var contentViewHeightCons: NSLayoutConstraint!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var locate : AreaObject!
    
    
    var regionArr : NSArray = []
    var provinceArr : NSArray = []
    var cityArr : NSArray = []
    var areaArr : NSArray = []
    
    
    
     var block:addressChoicePickerViewBlock?
    
    
    
    
    override func awakeFromNib() {
        
        self.frame = UIScreen.mainScreen().bounds
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        self.regionArr = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("AreaPlist.plist", ofType: nil)!)!
        self.provinceArr = self.regionArr[0]["provinces"] as! NSArray
        self.cityArr = self.provinceArr[0]["cities"] as! NSArray
        self.areaArr = self.cityArr[0]["areas"] as! NSArray
        self.locate?.region = self.regionArr[0]["region"] as! String
        self.locate?.province = self.provinceArr[0]["province"]  as! String
        self.locate?.city = self.cityArr[0]["city"] as! String
        if self.areaArr.count != 0 {
            self.locate?.area = self.areaArr[0] as! String
        }else{
            self.locate?.area = ""
        }

        
    }
    
    
    
    @IBAction func dismissBtnPress(sender: UIButton) {
        self.hide()
    }
    
    @IBAction func finishBtnPress(sender: UIButton) {
        if (self.block != nil) {
            self.block!(view: self,btn: sender,locate: self.locate)
        }
    }
    
    
    
    
//    let view = (NSBundle.mainBundle().loadNibNamed("AddressChoicePickerView", owner: nil, options: nil) as NSArray).firstObject
    
    func show(){
        
        let win = UIApplication.sharedApplication().keyWindow
        let topView = ((win?.subviews)! as NSArray).firstObject as! UIView
        topView.addSubview(self)
        
        UIView.animateWithDuration(0.3) { () -> Void in
            self.contentViewHeightCons.constant = 250;
            self.layoutIfNeeded()
        }
        
        
    }
    
    
    func hide(){
        UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.alpha = 0;
                self.contentViewHeightCons.constant = 0
                self.layoutIfNeeded()
            }) { (finished) -> Void in
                self.removeFromSuperview()
        }
        
    }
    
    
    
    
    func customView(){
        self.contentViewHeightCons.constant = 0
        self.layoutIfNeeded()
    }
    
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch component {
        case 0:
            return self.regionArr.count
        case 1:
            return self.provinceArr.count
        case 2:
            return self.cityArr.count
        case 3:
            if self.areaArr.count != 0 {
                return self.areaArr.count
            }
        default:
            return 0
        }
        return 0
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch (component){
        case 0:
            return self.regionArr[row]["region"] as? String
        case 1:
            return self.provinceArr[row]["province"] as? String
        case 2:
            return self.cityArr[row]["city"] as? String
        case 3:
            if self.areaArr.count != 0 {
                return self.areaArr[row] as? String
            }
        default:
            return ""
            
        }
        
        return ""
    }
    
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        
        var pickerLabel = view as? UILabel
        if (pickerLabel == nil) {
            
            pickerLabel = UILabel()
            pickerLabel?.minimumScaleFactor = 8.0
            pickerLabel?.adjustsFontSizeToFitWidth = true
            pickerLabel?.textAlignment = NSTextAlignment.Center
            pickerLabel?.backgroundColor = UIColor.clearColor()
            pickerLabel?.font = UIFont.boldSystemFontOfSize(15)
            
        }
        pickerLabel?.text = self.pickerView(pickerView, titleForRow: row, forComponent: component)
        return pickerLabel!
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch (component){
            case 0:
            self.provinceArr = self.regionArr[row]["provinces"] as! NSArray
            self.pickerView.reloadComponent(1)
            self.pickerView.selectRow(0, inComponent: 1, animated: true)
            
            
            self.cityArr = self.provinceArr[0]["cities"] as! NSArray
            self.pickerView.reloadComponent(2)
            self.pickerView.selectRow(0, inComponent: 2, animated: true)
            
            self.areaArr = self.cityArr[0]["areas"] as! NSArray
            self.pickerView.reloadComponent(3)
            self.pickerView.selectRow(0, inComponent: 3, animated: true)
            
            self.locate.region = self.regionArr[row]["region"] as! String
            self.locate.province = self.provinceArr[0]["province"] as! String
            self.locate.city = self.cityArr[0]["city"] as! String
            
            if self.areaArr.count != 0 {
                self.locate.area = self.areaArr[0] as! String
            }else{
                self.locate.area = ""
            }
            
            
            case 1:
            self.cityArr = self.provinceArr[row]["cities"] as! NSArray
            self.pickerView.reloadComponent(2)
            self.pickerView.selectRow(0, inComponent: 2, animated: true)
            
            
            self.areaArr = self.cityArr[0]["areas"] as! NSArray
            self.pickerView.reloadComponent(3)
            self.pickerView.selectRow(0, inComponent: 3, animated: true)
            
            
            self.locate.province = self.provinceArr[row]["province"] as! String
            self.locate.city = self.cityArr[0]["city"] as! String
            if self.areaArr.count != 0 {
                self.locate.area = self.areaArr[0] as! String
            }else{
                self.locate.area = ""
            }
            
            
            case 2:
                self.areaArr = self.cityArr[row]["areas"] as! NSArray
                self.pickerView.reloadComponent(3)
                self.pickerView.selectRow(0, inComponent: 3, animated: true)
            
                self.locate.city = self.cityArr[row]["city"] as! String
                if self.areaArr.count != 0 {
                    self.locate.area = ""
                }else{
                    self.locate.area = ""
            }
            
        case 3:
            if self.areaArr.count != 0{
                self.locate.area = self.areaArr[row] as! String
            }else{
                self.locate.area = ""
            }
            
            
        default:
            break
            
            
            
        }
        
        
        
        
        
    }
    
    
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}




extension AddressChoicePickerView {
    
    
   
    
    
}



