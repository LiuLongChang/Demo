//
//  ViewController.swift
//  Demo
//
//  Created by langyue on 16/1/6.
//  Copyright © 2016年 langyue. All rights reserved.
//

import UIKit

let ScreenWidth  = UIScreen.mainScreen().bounds.size.width
let ScreenHeight =  UIScreen.mainScreen().bounds.size.height

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

//    var region : String!
//    var province : String!
//    var city : String!
//    var area : String!
   
    
    
    @IBOutlet weak var resultLabel: UILabel!
    
    
    @IBAction func tapAction(sender: UIButton) {
        
        let vc = (NSBundle.mainBundle().loadNibNamed("AddressChoicePickerView", owner: nil, options: nil) as NSArray).lastObject as! AddressChoicePickerView
        vc.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight+44)
        
        
        vc.block = {(view: AddressChoicePickerView,btn: UIButton,locate: AreaObject)->Void in
        
            
            self.resultLabel.text = "\(locate.region)\(locate.province)\(locate.city)\(locate.area)"
            self.resultLabel.textColor = UIColor.redColor()
            view.hide()
            
        }
        
        
        self.view.addSubview(vc)
        vc.show()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

