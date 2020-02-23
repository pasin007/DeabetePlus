//
//  BaseViewCell.swift
//  deabeteplus
//
//  Created by Ji Ra on 1/12/2562 BE.
//  Copyright © 2562 Ji Ra. All rights reserved.
//

import UIKit

protocol CellProtocol {
    static var nib: UINib { get }
    static var identifier: String { get }
}

protocol BaseViewCell: CellProtocol {}

// Table view cell
extension BaseViewCell where Self: UITableViewCell {
    static var nib: UINib {
        return UINib(nibName: "\(Self.self)", bundle: nil)
    }

    static var identifier: String {
        return "\(Self.self)"
    }
}

// Table view header footer
extension BaseViewCell where Self: UITableViewHeaderFooterView {
    static var nib: UINib {
        return UINib(nibName: "\(Self.self)", bundle: nil)
    }

    static var identifier: String {
        return "\(Self.self)"
    }
}

// Collection view cell
extension BaseViewCell where Self: UICollectionViewCell {
    static var nib: UINib {
        return UINib(nibName: "\(Self.self)", bundle: nil)
    }

    static var identifier: String {
        return "\(Self.self)"
    }
}

// Collection reusable view
extension BaseViewCell where Self: UICollectionReusableView {
    static var nib: UINib {
        return UINib(nibName: "\(Self.self)", bundle: nil)
    }

    static var identifier: String {
        return "\(Self.self)"
    }
}
