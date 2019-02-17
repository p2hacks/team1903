//
//  CommunicationData.swift
//  FrontDemo
//
//  Created by 大野和也 on 2019/02/17.
//  Copyright © 2019 Tatsuika. All rights reserved.
//

import Foundation
import MultipeerConnectivity
import UIKit
let MypeerID = MCPeerID(displayName: SendData.sendName())
let MySession = MCSession(peer: MypeerID)
struct UserData {
    var name: String
    var cname: String
    var fname: String
    var image: UIImage?
    init(name: String, cname: String, fname: String, image: UIImage?) {
        self.name = name
        self.cname = cname
        self.fname = fname
        self.image = image
    }
}
extension UserData: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case cname
        case fname
        case image
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        cname = try values.decode(String.self, forKey: .cname)
        fname = try values.decode(String.self, forKey: .fname)
        let imageDataBase64String = try values.decode(String.self, forKey: .image)
        if let data = Data(base64Encoded: imageDataBase64String) {
            image = UIImage(data: data)
        } else {
            image = nil
        }
    }
}
extension UserData: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(cname, forKey: .cname)
        try container.encode(fname, forKey: .fname)
        
        if let image = image, let imageData = image.pngData() {
            let imageDataBase64String = imageData.base64EncodedString()
            try container.encode(imageDataBase64String, forKey: .image)
        }
    }
}
var ids: [MCPeerID] = []
var usersImageDictionary: [MCPeerID:UserData] = [:]
class UsersDictionary {
    class func sendMyData() -> UserData?{
        return usersImageDictionary[MypeerID]
    }
    class func sendData(id: MCPeerID) -> UserData?{
        return usersImageDictionary[id]
    }
}
