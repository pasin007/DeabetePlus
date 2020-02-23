//
//  BaseView.swift
//  deabeteplus
//
//  Created by Ji Ra on 1/12/2562 BE.
//  Copyright © 2562 Ji Ra. All rights reserved.
//

import UIKit

protocol BaseViewProtocol: class {
    var nibName: String { get }
    var contentView: UIView! { get set }
}

extension BaseViewProtocol where Self: UIView {
    func loadNib(_ name: String) {
        Bundle.main.loadNibNamed(name, owner: self, options: nil)
    }

    func bindingView() {
        loadNib(nibName)

        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        addSubview(contentView)
    }
}

class BaseUIView: UIView, BaseViewProtocol {
    @IBOutlet weak var contentView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        bindingView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        bindingView()
    }

    var nibName: String {
        return "\(self) must override `nibName` property"
    }
}
