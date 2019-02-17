//
//  ViewController.swift
//  FrontDemo
//
//  Created by 猪飼　立晟 on 2019/02/16.
//  Copyright © 2019年 Tatsuika. All rights reserved.
//

import UIKit
import MultipeerConnectivity
let reuseIdentifier = "reuseIdentifier"
class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, CommunicationDelegate{
    func dataLoad() {
        print("aaa")
        self.chatTableView.reloadData()
    }
    
    let communication = Communication()
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var chatTextField: UITextField!
    @IBAction func moveEditProfile(_ sender: UIButton) {
        let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "EditProfile") as! EditProfile
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    @IBAction func sendChat(_ sender: Any) {
        if let index = ids.index(of: self.communication.peerID) {
            ids.remove(at: index)
            ids.append(self.communication.peerID)
        }
        let msg = (SendData.sendName() + " : " + self.chatTextField.text!).data(using: String.Encoding.utf8, allowLossyConversion: false)
        do {
            try self.communication.session.send(msg!, toPeers: self.communication.session.connectedPeers, with: MCSessionSendDataMode.unreliable)
            
        } catch {
            print("Error sending data: \(String(describing: error.localizedDescription))")
        }
        
        usersImageDictionary[self.communication.peerID]!.name = SendData.sendName() + " : " + self.chatTextField.text!
        self.chatTableView.reloadData()
        // "送信"を押したらキーボード消える
        chatTextField.endEditing(true)
    }
    
    
    func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        //let second = self.storyboard?.instantiateViewController(withIdentifier: "ViewProfile") as! ViewProfile
        let idsIndex = ids.count - Int(indexPath.row) - 1
        let selectID = ids[idsIndex]
        let selectUserData = usersImageDictionary[selectID]
        let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "PeerProfile") as! PeerProfile
        secondViewController.name = selectUserData!.name
        secondViewController.cname = selectUserData!.cname
        secondViewController.fname = selectUserData!.fname
        secondViewController.image = selectUserData!.image
//        self.navigationItem.title
//        secondViewController.modalTransitionStyle = .
        self.present(secondViewController, animated: true, completion: nil)
//        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.chatTableView.reloadData()
        print(ids.count)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("helloviewDidLoad")
        chatTableView.dataSource = self
        chatTableView.delegate = self
        chatTableView.tableFooterView = UIView(frame: .zero)
        
        chatTableView.estimatedRowHeight=50
        chatTableView.rowHeight = UITableView.automaticDimension
        
        chatTextField.delegate = self
        
        chatTextField.returnKeyType = .done
        //改行ボタンを完了ボタンに変更
        
        self.view.addSubview(chatTextField)
        //viewにtextfieldをsubviewとして追加
        
        chatTextField.keyboardType = UIKeyboardType.default
        
        self.communication.delegate = self
    }
    
    /*
    // キーボード関連 - ここから
    // Notification発行
    func configureObserver() {
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                 name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                 name: UIResponder.keyboardWillHideNotification, object: nil)
        //print("Notificationを発行")
    }
    // キーボードが表示時に画面をずらす。
    @objc func keyboardWillShow(_ notification: Notification?) {
        guard let rect = (notification?.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        UIView.animate(withDuration: duration) {
            let transform = CGAffineTransform(translationX: 0, y: -(rect.size.height))
            self.view.transform = transform
        }
        //print("keyboardWillShowを実行")
    }
    
    /// キーボードが降りたら画面を戻す
    @objc func keyboardWillHide(_ notification: Notification?) {
        guard let duration = notification?.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? TimeInterval else { return }
        UIView.animate(withDuration: duration) {
            self.view.transform = CGAffineTransform.identity
        }
        //print("keyboardWillHideを実行")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // ここまで
    */
    
    //完了を押すとkeyboardを閉じる処理
    func textFieldShouldReturn(_ chatTextField: UITextField) -> Bool {
        /*
         func sendName(_ sender: Any) {
         try? nameField.text!.write(to: fileURL,atomically: true,encoding: .utf8)
         print(nameField.text!)
         
         }
         */
        //Keyboardを閉じる
        chatTextField.resignFirstResponder()
        
        return true
        
    }
    
    //keyboard以外の画面を押すと、keyboardを閉じる処理
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.chatTextField.isFirstResponder) {
            self.chatTextField.resignFirstResponder()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        print(usersImageDictionary.count)
        return usersImageDictionary.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
        
        let idsIndex = ids.count - (indexPath.row + 1)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text =  usersImageDictionary[ids[idsIndex]]!.name + " : "
        cell.accessoryType = .disclosureIndicator
        
        let Resize:CGSize = CGSize.init(width: 50, height: 50)
        cell.imageView!.image =
            usersImageDictionary[ids[idsIndex]]!.image?.resize(size: Resize)
        return cell
    }
}
extension UIImage {
    func resize(size _size: CGSize) -> UIImage? {
        let widthRatio = _size.width / size.width
        let heightRatio = _size.height / size.height
        let ratio = widthRatio < heightRatio ? widthRatio : heightRatio
        
        let resizedSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        
        UIGraphicsBeginImageContextWithOptions(resizedSize, false, 0.0) // 変更
        draw(in: CGRect(origin: .zero, size: resizedSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
}
