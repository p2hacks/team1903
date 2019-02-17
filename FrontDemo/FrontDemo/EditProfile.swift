//
//  editProfile.swift
//  FrontDemo
//
//  Created by 大野和也 on 2019/02/16.
//  Copyright © 2019 Tatsuika. All rights reserved.
//

import Foundation
import UIKit
import MultipeerConnectivity

class EditProfile: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == classPicker{
            return Datalist1.count
        }
        else{
            return Datalist2.count
        }
    }
    

    
    @IBAction func updateData(_ sender: UIButton) {
        print(fileURL)
        print(fileCnameURL)
        try? nameField.text?.write(to :fileURL, atomically: true, encoding: .utf8)
        try? classLabel.text?.write(to :fileCnameURL, atomically: true, encoding: .utf8)
        try? fromLabel.text?.write(to :fileFnameURL, atomically: true, encoding: .utf8)
        try? profileImage.image?.pngData()?.write(to: imageURL)
        usersImageDictionary[MypeerID]!.name = SendData.sendName()
        usersImageDictionary[MypeerID]!.cname = SendData.sendClass()
        usersImageDictionary[MypeerID]!.fname = SendData.sendFrom()
        usersImageDictionary[MypeerID]!.image = SendData.sendImage()
        let msg = usersImageDictionary[MypeerID]
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(msg)
            try MySession.send(jsonData, toPeers: MySession.connectedPeers, with: MCSessionSendDataMode.unreliable)
        } catch {
            print("Error sending data: \(String(describing: error.localizedDescription))")
        }
        // "更新"を押したらキーボード消える
        nameField.endEditing(true)
    }
    
    
    
    @IBAction func moveChat(_ sender: UIButton) {
        let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "Chat") as! ViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBAction func selectImage(_ sender: UIButton) {//Anyで指定されていた
        // カメラロールが利用可能か？
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            // 写真を選ぶビュー
            let pickerView = UIImagePickerController()
            // 写真の選択元をカメラロールにする
            // 「.camera」にすればカメラを起動できる
            pickerView.sourceType = .photoLibrary
            // デリゲート
            pickerView.delegate = self
            // ビューに表示
            self.present(pickerView, animated: true)
        }
    }
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var classLabel: UILabel!
    
    @IBOutlet weak var classPicker: UIPickerView!
    
    @IBOutlet weak var fromLabel: UILabel!
    
    @IBOutlet weak var fromPicker: UIPickerView!
    
    //classLabel.text? = S
    
    let Datalist1 = ["A","B","C","D","E","F","G","H","I","J","K","L"]
    
    let Datalist2 = ["北海道","青森県","岩手県","宮城県","秋田県","山形県","福島県",
                     "茨城県","栃木県","群馬県","埼玉県","千葉県","東京都","神奈川県",
                     "新潟県","富山県","石川県","福井県","山梨県","長野県","岐阜県",
                     "静岡県","愛知県","三重県","滋賀県","京都府","大阪府","兵庫県",
                     "奈良県","和歌山県","鳥取県","島根県","岡山県","広島県","山口県",
                     "徳島県","香川県","愛媛県","高知県","福岡県","佐賀県","長崎県",
                     "熊本県","大分県","宮崎県","鹿児島県","沖縄県","その他"]
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print(SendData.sendName())
        
        classPicker.delegate = self
        
        fromPicker.delegate = self
        
        classPicker.dataSource = self
        
        fromPicker.dataSource = self
        
        //classLabel.text = "選択"
        
        //fromLabel.text = "選択"
        
        nameField.delegate = self
        //delegateを自身に設定
        
        nameField.clearButtonMode = .whileEditing
        //入力している文字を全消しするclearボタンを設定(書いている時のみの設定)
        
        nameField.returnKeyType = .done
        //改行ボタンを完了ボタンに変更
        
        //nameField.placeholder = "入力してください"
        nameField.text = SendData.sendName()
        
        classLabel.text = SendData.sendClass()
        
        fromLabel.text = SendData.sendFrom()
        //文字が何も入力されていない時に表示される文字
        
        self.view.addSubview(nameField)
        //viewにtextfieldをsubviewとして追加
        
        nameField.keyboardType = UIKeyboardType.default
        //self.profileImage.image = SendData.sendImage()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //完了を押すとkeyboardを閉じる処理
    func textFieldShouldReturn(_ nameField: UITextField) -> Bool {
        /*
        func sendName(_ sender: Any) {
            try? nameField.text!.write(to: fileURL,atomically: true,encoding: .utf8)
            print(nameField.text!)
            
        }
        */

        //Keyboardを閉じる
        nameField.resignFirstResponder()
        
        return true
        
    }
    
    //keyboard以外の画面を押すと、keyboardを閉じる処理
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.nameField.isFirstResponder) {
            self.nameField.resignFirstResponder()
        }
    }
    
    //データを返す処理
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == classPicker{
            return Datalist1[row]
        }
        else {
            return Datalist2[row]
        }
    }
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        
        if pickerView == classPicker{
            classLabel.text = Datalist1[row]
        }
        else {
            fromLabel.text = Datalist2[row]
            
        }
    }
    
    // 写真を選んだ後に呼ばれる処理
   /* private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 選択した写真を取得する
        let image = info[.originalImage] as! UIImage
        // ビューに表示する
        self.ImageView.image = image
        // 写真を選ぶビューを引っ込める
        self.dismiss(animated: true)
    }*/
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        print("test")
        // ビューに表示する
        guard let _:UIImage = image, let data = image.pngData() else {
            return
        }
        self.profileImage.image = image
        // 写真を選ぶビューを引っ込める
        self.dismiss(animated: true)
    }
}

/*struct UserData{
    let : String
    let image: UIImage?
}

extension UserData: Decodable {
    enum CodingKeys: String, CodingKey {
        case title
        case image
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        
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
        try container.encode(title, forKey: .title)
        
        if let image = image, let imageData = image.pngData() {
            let imageDataBase64String = imageData.base64EncodedString()
            try container.encode(imageDataBase64String, forKey: .image)
        }
    }
}*/
