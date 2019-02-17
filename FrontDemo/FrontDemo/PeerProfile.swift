//
//  PeerProfile.swift
//  FrontDemo
//
//  Created by 大野和也 on 2019/02/16.
//  Copyright © 2019 Tatsuika. All rights reserved.
//

import Foundation
import UIKit
class PeerProfile: UIViewController {
    
    @IBOutlet weak var peerImage: UIImageView!
    
    @IBOutlet weak var peerName: UILabel!
    @IBOutlet weak var peerClassName: UILabel!
    @IBOutlet weak var peerFromName: UILabel!
    
    @IBAction func moveChat(_ sender: UIButton) {
        let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "Chat") as! ViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
