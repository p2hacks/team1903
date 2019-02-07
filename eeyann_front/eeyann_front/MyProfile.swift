//
//  MyProfile.swift
//  eeyann_front
//
//  Created by 猪飼　立晟 on 2019/02/07.
//  Copyright © 2019年 Tatsuika. All rights reserved.
//

import UIKit

class MyProfile: UIViewController {
    
    @IBOutlet weak var MyProfileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let profile_image = UIImage(named: "IMG_5810.JPG")
        MyProfileImage.image = profile_image
    }
    
}
