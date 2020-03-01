//
//  AccountViewController.swift
//  deabeteplus
//
//  Created by pasin on 14/12/2562 BE.
//  Copyright © 2562 Ji Ra. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, BaseViewController {
    
    //MARK: Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView! { didSet { cnfigureTableView() } }
    
    //MARK: Properties
    private let viewModel: UserViewModel = UserViewModel()
    private var friends: [Friend] = []
    
    var emptyFriendsCell: UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "ไม่มีการเพิ่มผู้ใช้"
        cell.textLabel?.textColor = UIColor(hexString: "#C4C4C4")
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont(name: "Kodchasan", size: 13)
        return cell
    }
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtonItem()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
        fetchFriends()
    }
    

}

extension AccountViewController {
    private func cnfigureTableView() {
        tableView.addShadow()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(FriendsListHeader.nib, forHeaderFooterViewReuseIdentifier: FriendsListHeader.identifier)
        
        tableView.register(AccountViewCell.nib, forCellReuseIdentifier: AccountViewCell.identifier)
        tableView.register(ActioonButtonViewCell.nib, forCellReuseIdentifier: ActioonButtonViewCell.identifier)
    }
    
    private func configureButtonItem() {
        
        let button: UIBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "add2"), style: .plain, target: self, action: #selector(doAddNewProfile))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc func doAddNewProfile() {
        Navigator.shared.navigatorToAddProfile(self)
    }
    
}

extension AccountViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = friends[indexPath.row].friend
        seeUserDetail(user)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FriendsListHeader.identifier) as! FriendsListHeader
        header.addAction = {
            print("ADD FRIEND")
        }
        header.backgroundColor = .gray
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension AccountViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count > 0 ? friends.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if friends.count == 0 {
            return emptyFriendsCell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountViewCell.identifier, for: indexPath) as? AccountViewCell
             else { return UITableViewCell() }
        let friend = friends[indexPath.row].friend
        cell.configure(friend)

        return cell
    }
    
    
}

/// MARK: Function
extension AccountViewController {
    @IBAction func doChangeProfile() {
        Navigator.shared.showSelectProfileView(self, type: .selectFromAccount)
    }
    
    @IBAction func doLogout() {
        showLogutAction()
    }
    
    func configureView() {
        
        guard let user = UserManager.shared.currentUser else { return }
        nameLabel.text = user.name
        if let imageUrl = user.image, let url = URL(string: imageUrl) {
            profileImageView.kf.setImage(with: url)
        } else {
            profileImageView.image = UIImage(named: "PROFILE3")
        }
    }
    
    private func fetchFriends() {
        viewModel.getFriends { (friends) in
            DispatchQueue.main.async { [weak self] in
                self?.friends = friends
                self?.tableView.reloadData()
            }
        }
    }
    
    @IBAction func doSeeDetail() {
        guard let user = UserManager.shared.currentUser else { return }
        seeUserDetail(user)
    }
    
    private func seeUserDetail(_ user: User) {
         Navigator.shared.navigatorToProfileDetail(self, user: user)
    }
}
