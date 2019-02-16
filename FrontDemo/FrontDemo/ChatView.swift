//
//  ChatView.swift
//  FrontDemo
//
//  Created by 大野和也 on 2019/02/16.
//  Copyright © 2019 Tatsuika. All rights reserved.
//

import Foundation
import UIKit

class ChatView: UIViewController {
    
    @IBOutlet weak var chatTableView: UITableView!
    
    @IBOutlet weak var chatTextField: UITextField!
    
    @IBAction func sendChat(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
