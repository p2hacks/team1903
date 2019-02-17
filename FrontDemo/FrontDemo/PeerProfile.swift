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
    
    var name = "a"
    var cname = "b"
    var fname = "c"
    var image: UIImage!
    
    @IBAction func moveChat(_ sender: UIButton) {
        let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "Chat") as! ViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.peerName.text = String(name[name.startIndex..<name.index(of: ":")!])
        self.peerClassName.text = cname
        self.peerFromName.text = fname
        self.peerImage.image = image!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.peerName.text = name
        self.peerClassName.text = cname
        self.peerFromName.text = fname
        self.peerImage.image = image!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
