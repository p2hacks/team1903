//
//  Communication.swift
//  FrontDemo
//
//  Created by 猪飼　立晟 on 2019/02/17.
//  Copyright © 2019年 Tatsuika. All rights reserved.
//

import Foundation
import MultipeerConnectivity

protocol CommunicationDelegate : class {
    func dataLoad() -> Void
}

class Communication:NSObject, MCNearbyServiceBrowserDelegate, MCSessionDelegate,  MCNearbyServiceAdvertiserDelegate{
    func sendUserData() {
        usersImageDictionary[peerID]!.image = SendData.sendImage()
    }
    weak var delegate: CommunicationDelegate?
    
    let my_serviceType = "LCOC-Chat"
    let peerID : MCPeerID!
    let session : MCSession
    let browser : MCNearbyServiceBrowser!
    let assistant : MCNearbyServiceAdvertiser!
    
    var UserDatas : [UserData] // 通信中のデータ
    
    override init() {
        peerID = MypeerID
        session = MySession
        browser = MCNearbyServiceBrowser(peer: peerID, serviceType: my_serviceType)
        assistant = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: my_serviceType)
        UserDatas = [UserData(name: SendData.sendName(), cname: SendData.sendClass(), fname: SendData.sendFrom(), image: SendData.sendImage())]
        
        if ids.index(of: peerID) == nil {
            print("a")
            ids.append(peerID)
            usersImageDictionary[peerID] = UserData(name: SendData.sendName() + " : ", cname: SendData.sendClass(), fname: SendData.sendFrom(), image: SendData.sendImage())
        }
        
        super.init()
        self.session.delegate = self
        self.browser.delegate = self
        self.browser.startBrowsingForPeers()
        self.assistant.delegate = self
        self.assistant.startAdvertisingPeer()
    }
    
    //通信が切れた時の処理
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        print("bye" + peerID.displayName)
        /*
         if let index = self.ids.index(of: peerID) {
         self.ids.remove(at: index)
         self.usersImageDictionary[peerID] = nil
         }
         self.delegate?.dataLoad()
         */
    }
    
    //通信への招待
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        let msg = UserData(name: SendData.sendName(), cname: SendData.sendClass(), fname: SendData.sendFrom(), image: SendData.sendImage())
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(msg)
            self.browser.invitePeer(peerID, to: session, withContext: jsonData, timeout: 10)
        } catch {
            print("Error sending data: \(String(describing: error.localizedDescription))")
        }
    }
    
    //通信への招待が来た時の処理
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        
        invitationHandler(true, session)
        /*
         if context != nil{
         let jsonDecoder = JSONDecoder()
         let user = try! jsonDecoder.decode(UserData.self, from: context!)
         self.updateData(data: user, fromPeer: peerID)
         self.ids.append(peerID)
         self.usersImageDictionary[peerID] = user
         self.delegate?.dataLoad()
         }
         */
    }
    
    func updateData(data: UserData, fromPeer peerID: MCPeerID) {
        //self.chatView.text = self.chatView.text + message
        self.UserDatas.append(data)
    }
    
    //通信を受信した時の処理
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        // Called when a peer sends an NSData to us
        // This needs to run on the main queue
        /*
         let msg = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
         let text = msg as String?
         */
        DispatchQueue.main.async {
            let jsonDecoder = JSONDecoder()
            let user = try? jsonDecoder.decode(UserData.self, from: data)
            if user != nil {
                usersImageDictionary[peerID] = user!
                self.delegate?.dataLoad()
            }else{
                let msg = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                usersImageDictionary[peerID]!.name = msg! as String
            }
            if let index = ids.index(of: peerID) {
                ids.remove(at: index)
                ids.append(peerID)
            }else{
                ids.append(peerID)
            }
            self.delegate?.dataLoad()
        }
    }
    
    //sessionが変化したときの処理
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        print(state)
        switch state{
        case .connected:
            let msg = UserData(name: SendData.sendName(),
                               cname: SendData.sendClass(), fname: SendData.sendFrom(), image: SendData.sendImage())
            do {
                let jsonEncoder = JSONEncoder()
                let jsonData = try jsonEncoder.encode(msg)
                try self.session.send(jsonData, toPeers:[peerID], with: MCSessionSendDataMode.unreliable)
            } catch {
                print("Error sending data: \(String(describing: error.localizedDescription))")
            }
        case .notConnected:
            if let index = ids.index(of: peerID) {
                ids.remove(at: index)
                usersImageDictionary[peerID] = nil
            }
            self.delegate?.dataLoad()
        default :
            break
        }
    }
    
    //リソース, ストリームの処理
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        // Called when a peer establishes a stream with us
    }
    // The following methods do nothing, but the MCSessionDelegate protocol requires that we implement them.
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        // Called when a peer starts sending a file to us
    }
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        // Called when a file has finished transferring from another peer
    }
    
}

