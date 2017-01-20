//
//  ViewController.swift
//  SwiftSample
//
//  Created by Sanjith J K on 17/01/17.
//
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func presentConversationScreen(_ sender: Any) {
        Hotline.sharedInstance().showConversations(self)

    }

    @IBAction func presentFAQsHere(_ sender: Any) {
        let options = FAQOptions.init()
        options.showFaqCategoriesAsGrid = true;	//For displaying faq in grid format

        //Uncomment if you want to display faq with filter tags
        //let tags: [String] = ["Billing","Payment"] //Add tags array
        //options.filterByTags(tags, withTitle: "Payments")

        Hotline.sharedInstance().showFAQs(self, with: options)

        //To display faq without options

        //Hotline.sharedInstance().showFAQs(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

