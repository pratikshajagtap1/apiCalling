//
//  UsersDetailViewController.swift
//  User
//
//  Created by pratiksha jagtap on 5/17/23.
//

import UIKit
import SDWebImage
class UsersDetailViewController: UIViewController {
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var img: UIImageView!
    var user:Users?
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = "Name : \(user!.first_name + " " + user!.last_name)"
        name.textAlignment = .justified
        id.text = "Id: \(String(user!.id))"
        email.text = "Email: \(String(user!.email))"
        let url = URL(string: user!.avatar)
        img.sd_setImage(with: url!)
        img.layer.cornerRadius = 75
        img.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
    }
   
}
