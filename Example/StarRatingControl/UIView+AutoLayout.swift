//
//  UIView+AutoLayout.swift
//  StarRatingControl_Example
//
//  Created by Rafael Moura on 30/07/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func usingAutoLayout() -> Self {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
