//
//  ViewController.swift
//  SwiftSample
//
//  Copyright © 2015 Freshdesk. All rights reserved.
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
        let options = FAQOptions.init()
        options.showFaqCategoriesAsGrid = true;	//For displaying faq in grid format
        
        //Uncomment if you want to display faq with filter tags
        //let tags: [String] = ["Billing","Payment"] //Add tags array
        //options.filterByTags(tags, withTitle: "Payments")
        
        Hotline.sharedInstance().showFAQs(self, withOptions: options)
        
        
        //To display faq without options
        
        //Hotline.sharedInstance().showFAQs(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

