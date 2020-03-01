//
//  BaseViewController.swift
//  deabeteplus
//
//  Created by Ji Ra on 1/12/2562 BE.
//  Copyright © 2562 Ji Ra. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

typealias BaseViewController = _BaseViewController & NVActivityIndicatorViewable

protocol BaseViewControllerProtocol: class {
    static var instance: UIViewController { get }
}

/// MARK - Xib
protocol _BaseViewController: BaseViewControllerProtocol {}
extension _BaseViewController where Self: UIViewController {
    static var instance: UIViewController {
        return Self(nibName: "\(Self.self)", bundle: nil)
    }
}

/// MARK - Storyboard
protocol BaseViewControllerFromStoryboard: BaseViewControllerProtocol {
    static var identifier: String { get }
    static var storyboardName: String { get }
}

extension BaseViewControllerFromStoryboard where Self: UIViewController {
    static var instance: UIViewController {
        return UIStoryboard(name: Self.storyboardName, bundle: nil).instantiateViewController(withIdentifier: Self.identifier) as! Self
    }
}

