//
//  MyProfile.swift
//  eeyann_front
//
//  Created by 猪飼　立晟 on 2019/02/07.
//  Copyright © 2019年 Tatsuika. All rights reserved.
//

import UIKit

let items = [
    "猪飼 立晟",
    "2-B ・ 情報システムコース",
    "愛知県",
    "よろしくお願いします！",
]

let reuseIdentifier = "reuseIdentifier"

class MyProfile: UIViewController {
    
    @IBOutlet weak var MyProfileImage: UIImageView!
    @IBOutlet weak var MyProfileTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let profile_image = UIImage(named: "IMG_5810.JPG")
        MyProfileImage.image = profile_image
        MyProfileTable.register(
            UITableViewCell.self,
            forCellReuseIdentifier : reuseIdentifier
        )
        MyProfileTable.dataSource = self
        MyProfileTable.tableFooterView = UIView(frame: .zero)
    }
    
}

extension MyProfile: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}


