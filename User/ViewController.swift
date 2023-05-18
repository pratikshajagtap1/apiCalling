//
//  ViewController.swift
//  User
//
//  Created by pratiksha jagtap on 5/16/23.
//

import UIKit
import Alamofire
import SDWebImage
class ViewController: UIViewController {
    @IBOutlet weak var usersTableView: UITableView!

    @IBOutlet weak var popBtn: UIButton!
    let context = DataBaseHandler().context
    var users = [Users]()
    let searchController = UISearchController(searchResultsController: nil)
    var searchUsers = [Users]()
    @objc let refreshPull = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJsonData()
        registerXib()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        self.popBtn.layer.cornerRadius = 25
       // setRefreshPullControl()
    }
    func registerXib(){
        usersTableView.dataSource = self
        usersTableView.delegate = self
        let uinib=UINib(nibName: "UsersTableViewCell", bundle: nil)
        self.usersTableView.register(uinib, forCellReuseIdentifier: "UsersTableViewCell")
    }
      func setRefreshPullControl(){
     refreshPull.tintColor = .red
     refreshPull.addTarget(self, action:#selector(getter: refreshPull), for: .valueChanged)
     self.usersTableView.refreshControl = refreshPull
     func refresh(sender:UIRefreshControl){
     sender.endRefreshing()
     }
}
func loadJsonData()
{
    AF.request("https://reqres.in/api/users?page=2").response { (response) in
        print(response.result)
        if let data = response.data{
            do{
                let getjsonObject = try (JSONSerialization.jsonObject(with: data) as! [String : Any])
                let jsonObjects = getjsonObject["data"] as! [[String : Any]]
                for eachdictionary in jsonObjects{
                    let userID = eachdictionary["id"] as! Int
                    let userName = eachdictionary["first_name"] as! String
                    let userLastname = eachdictionary["last_name"] as! String
                    let email = eachdictionary["email"] as! String
                    let userAvatar = eachdictionary["avatar"] as! String
                    let newUser = Users(id: userID, email: email, first_name: userName, last_name: userLastname, avatar: userAvatar)
                        self.users.append(newUser)
                    DataBaseHandler().saveData(first_name: userName, last_name: userLastname,email:email,id: Int64(userID),avatar: userAvatar)
                        self.usersTableView.reloadData()
                }
            }catch{
                print(error)
            }
        }
    }
}
    
}
    
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return users.count
        default:
            return searchUsers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = self.usersTableView.dequeueReusableCell(withIdentifier: "UsersTableViewCell", for: indexPath) as? UsersTableViewCell
        if(indexPath.section==0){
            setRefreshPullControl()
            cell?.userNameLabel.text = users[indexPath.row].first_name+" "+users[indexPath.row].last_name
        }else{
            let userObject = searchUsers[indexPath.row]
            cell?.userNameLabel.text = users[indexPath.row].first_name+" "+users[indexPath.row].last_name
            
        }
            cell?.userEmailLabel.text = users[indexPath.row].email
            let urlString = users[indexPath.row].avatar
            let url = URL(string: urlString)
            cell?.userImageView.sd_setImage(with: url)
            cell?.userImageView.layer.cornerRadius = 50
            cell?.userImageView.layer.borderWidth = 3
            cell?.userImageView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
            
            return cell!
    }
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         var userDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "UsersDetailViewController") as! UsersDetailViewController
           userDetailVC.user = users[indexPath.row]
           navigationController?.pushViewController(userDetailVC, animated: true)
       }
}

extension ViewController:UISearchResultsUpdating,UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else{return}
        if searchText == ""{
            self.searchUsers = self.users
        }
        else{
            searchUsers = users.filter({
                return $0.first_name.contains(searchText)
            })
        }
        usersTableView.reloadData()
    }
}
