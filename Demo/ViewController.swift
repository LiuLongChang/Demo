//
//  ViewController.swift
//  Demo
//
//  Created by langyue on 16/1/6.
//  Copyright © 2016年 langyue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBOutlet weak var tapPress: UIButton!
    
    
    
    @IBAction func tapAction(sender: UIButton) {
        
        var vc = (NSBundle.mainBundle().loadNibNamed("AddressChoicePickerView", owner: nil, options: nil) as! NSArray).lastObject as! AddressChoicePickerView
        
        
        vc.block { (view:AddressChoicePickerView,btn:UIButton,locate: AreaObject) -> Void in
            
            
            
            
            return ""
        }
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

