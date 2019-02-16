//
//  editProfile.swift
//  FrontDemo
//
//  Created by 大野和也 on 2019/02/16.
//  Copyright © 2019 Tatsuika. All rights reserved.
//

import Foundation
import UIKit

class EditProfile: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBAction func selectImage(_ sender: Any) {
    }
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var classPicker: UIPickerView!
    
    @IBOutlet weak var fromPicker: UIPickerView!
    
    
    override func viewDidLoad() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
