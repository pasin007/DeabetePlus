//
//  AccepTermViewController.swift
//  deabeteplus
//
//  Created by pasin on 26/1/2563 BE.
//  Copyright © 2563 Ji Ra. All rights reserved.
//

import UIKit

class AccepTermViewController: UIPageViewController, BaseViewController {
    
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var pageView: UIPageControl!
    
    var pages: [UIViewController] {
        return [
            TermOneViewController.instance,
            TermTwoViewController.instance,
            TermThreeViewController.instance
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        if let firstViewController = pages.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        // Do any additional setup after loading the view.
    }


}
// MARK: - Page View
extension AccepTermViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
          guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
              return nil
          }
          
          let previousIndex = viewControllerIndex - 1
          
          guard previousIndex >= 0 else {
              return nil
          }
          
          guard pages.count > previousIndex else {
              return nil
          }
          
          return pages[previousIndex]
    }
      
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let pageViewControllersCount = pages.count

        guard pageViewControllersCount != nextIndex else {
            return nil
        }
        
        guard pageViewControllersCount > nextIndex else {
            return nil
        }
        
        return pages[nextIndex]
    }
    


    
    private func createPage() {
        
    }
    

}

// MARK: - Action
extension AccepTermViewController {
    @IBAction func doToggleCheckBox(_ sender: UIButton) {
        let check = sender.isSelected
        if check {
            sender.setImage(UIImage(named: "MEDICINE TYPES-1"), for: .normal)
            acceptButton.backgroundColor = .yellow
        } else {
            sender.setImage(UIImage(named: "MEDICINE TYPES"), for: .normal)
            acceptButton.backgroundColor = .gray
        }
        acceptButton.isEnabled = check
    }
    
    @IBAction func doAccpetTerm() {
        
    }
}
