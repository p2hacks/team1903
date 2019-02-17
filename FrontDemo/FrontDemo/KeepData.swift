//
//  KeepData.swift
//  FrontDemo
//
//  Created by 瀧本恒平 on 2019/02/16.
//  Copyright © 2019 Tatsuika. All rights reserved.
//

import Foundation
import UIKit

var fileURL: URL {
    let docsURL = FileManager.default.urls(
        for: .documentDirectory,
        in: .userDomainMask
        )[0]
    return docsURL.appendingPathComponent("nfile.txt")
}

var fileCnameURL: URL {
    let docsURL = FileManager.default.urls(
        for: .documentDirectory,
        in: .userDomainMask
        )[0]
    return docsURL.appendingPathComponent("cfile.txt")
}

var fileFnameURL: URL {
    let docsURL = FileManager.default.urls(
        for: .documentDirectory,
        in: .userDomainMask
        )[0]
    return docsURL.appendingPathComponent("ffile.txt")
}
var imageURL: URL {
    let docsURL = FileManager.default.urls(
        for: .documentDirectory,
        in: .userDomainMask
        )[0]
    return docsURL.appendingPathComponent("file.png")
}
var sendData: SendData = SendData()
class SendData{
    class func sendName() -> String {
        let file_name: String? = try? String(contentsOf: fileURL)
        let name = (file_name != nil && file_name != "") ? file_name! : "noname"
        return name + " : "
    }
    
    class func sendClass() -> String {
        let file_name: String? = try? String(contentsOf: fileCnameURL)
        let name = (file_name != nil && file_name != "") ? file_name! : "noname"
        return name
    }
    
    class func sendFrom() -> String {
        let file_name: String? = try? String(contentsOf: fileFnameURL)
        let name = (file_name != nil && file_name != "") ? file_name! : "noname"
        return name
    }
    
    class func sendImage() -> UIImage {
        let file_image: UIImage? = UIImage(contentsOfFile: imageURL.path)
        let image = (file_image != nil) ? file_image! : UIImage(named: "default_image")!
        return image
    }
}
