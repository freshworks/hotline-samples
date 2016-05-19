//
//  ViewController.swift
//  SwiftSample
//
//  Created by Harish Kumar on 19/05/16.
//  Copyright © 2016 Harish Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func presentConversationScreen(sender: AnyObject) {
        Hotline.sharedInstance().showConversations(self)
    }
    
    @IBAction func presentFAQHere(sender: AnyObject) {
        Hotline.sharedInstance().showFAQs(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }


}

