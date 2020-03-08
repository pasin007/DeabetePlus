//
//  HomewViewController.swift
//  deabeteplus
//
//  Created by Ji Ra on 1/12/2562 BE.
//  Copyright © 2562 Ji Ra. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class HomeViewController: UIViewController, BaseViewController {
    
    enum Page: Int {
        case one = 0, two, three
    }
    // MARK: - Outlet
//    @IBOutlet weak var calPerDayStringLabel: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            configureTableView()
        }
    }
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: - Properties
    private var viewModel: FoodViewModel = FoodViewModel()
    private var foods: [Food] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    private var calToEat: Int = 0
    private var carbToEat: Int = 0
    private var currentPage: Page = .one
    
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !AppManager.shared.isAcceptTerm {
//            Navigator.shared.showAccepTermVIew(self)
        }
        fetchUser()
        
        configureSwip()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
//        setCal()
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        fetchFood()
        guard !UserManager.shared.isLogin else {
            // isLogin
//            if UserManager.shared.currentUser?.currentProfile == nil {
//                Navigator.shared.showSelectProfileView(self)
//            }
            return
        }
        Navigator.shared.showLoginView(self)
        
    }
    

}

/// MARK : Function
extension HomeViewController {
    @IBAction func showMoreView() {
        Navigator.shared.showImageView(self)
    }
    
    @IBAction func navigatorToMoreView() {
        Navigator.shared.navigateToMoreView(self)
    }
    
    func setCal() {
        guard let user = UserManager.shared.currentUser else { return }
        let calPerDayString = "\(user.cal_perday)"
//        calPerDayStringLabel.text = "\(calPerDayString)"
        print(calPerDayString)
    }
    
    func fetchUser() {
        guard let userId = UserManager.shared.userId else { return }
        Loading.startLoading(self)
        UserViewModel().getProfile(userId, onSuccess: { [weak self] (user) in
            UserManager.shared.login(user)
            Loading.stopLoading(self)
            self?.fetchFood()
        }) { [weak self] (_) in
            Loading.stopLoading(self)
        }
        
    }
    
    func fetchFood() {
        Loading.startLoading(self)
        viewModel.recommendFood(onSuccess: setFood) { (_) in
            Loading.stopLoading(self)
        }
    }
    
    func setFood(_ recommendFood: RecommendFood) {
        Loading.stopLoading(self)
        calToEat = recommendFood.cal_today
        carbToEat = recommendFood.carb_today
        self.foods = recommendFood.foods
//        calPerDayStringLabel.text = "\(foods.cal_today)"
    }
    
    
    @IBAction func pageControlSelectionAction(_ sender: UIPageControl) {
        let page: Int? = sender.currentPage
        currentPage =  Page(rawValue: page ?? 0)!
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
       if gesture.direction == .right {
            switch currentPage {
            case .one:
                break
            case .two:
               currentPage = .one
                
            case .three:
               currentPage = .two
            }
            pageControl.currentPage = currentPage.rawValue
       }
       else if gesture.direction == .left {
            switch currentPage {
            case .one:
                currentPage = .two
            case .two:
                currentPage = .three
            case .three:
                break
            }
          pageControl.currentPage = currentPage.rawValue
       }
    }
}

// MARK: - Configuration
extension HomeViewController {
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        // Register Header
        tableView.register(HomeHeaderViewCell.nib, forHeaderFooterViewReuseIdentifier: HomeHeaderViewCell.identifier)
        
        // Register Cells
        tableView.register(FoodViewCell.nib, forCellReuseIdentifier: FoodViewCell.identifier)
    }
    
    private func configureSwip() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }

}

// MARK: UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = UITableViewCell()
            
            cell.textLabel?.text = "เมนูอาหารแนะนำ"
            cell.textLabel?.textAlignment = .center
            if let font = UIFont(name: "Kodchasan-SemiBold", size: 18) {
                cell.textLabel?.font = font
            }
            cell.textLabel?.textColor = .white
            cell.backgroundColor = .clear
            
            cell.selectionStyle = .none
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodViewCell.identifier, for: indexPath) as? FoodViewCell else { return UITableViewCell() }
        let food = foods[indexPath.row - 1]
        cell.configure(food)
        return cell
    }
    
    
}

// MARK: UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row != 0 else { return }
        let food = foods[indexPath.row - 1]
        Navigator.shared.navigatorToFood(self, food: food)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0//95
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeHeaderViewCell.identifier) as? HomeHeaderViewCell else { return nil }
        header.configure(cal: calToEat, carb: carbToEat)
        return header
    }
}
