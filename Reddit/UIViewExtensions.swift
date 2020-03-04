//
//  UIViewExtensions.swift
//  Reddit
//
//  Created by Andrew Carter on 8/30/19.
//  Copyright © 2019 AshleyCo. All rights reserved.
//

import Foundation
import UIKit

protocol ClassNameIdentifiable {
    
}

protocol ClassNameNibLoadable {
    
}

extension ClassNameIdentifiable where Self: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension ClassNameNibLoadable where Self: UITableViewCell {

    static var nib: UINib? {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
}
