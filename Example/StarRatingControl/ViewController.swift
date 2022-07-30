//
//  ViewController.swift
//  StarRatingControl
//
//  Created by Rafael Moura on 07/29/2022.
//  Copyright (c) 2022 Rafael Moura. All rights reserved.
//

import UIKit
import StarRatingControl

class ViewController: UIViewController {

    private enum Constants {
        
        static let horizontalMargin: CGFloat = 10.0
        static let contentSpacing: CGFloat = 20.0
        static let defaultMaximumValue = 5
    }
    
    private lazy var ratingControl: SRRater = {
        
        let control = SRRater().usingAutoLayout()
        control.maximumValue = Constants.defaultMaximumValue
        control.value = 3
        
        control.addTarget(self,
                          action: #selector(valueChanged(_:)),
                          for: .valueChanged)
        
        return control
    }()
    
    private lazy var valueLabel: UILabel = {
       
        let label = UILabel().usingAutoLayout()
        label.text = "\(ratingControl.value)"
        
        return label
    }()
    
    private lazy var maximumValueStepperStack: UIStackView = {
        
        let label = UILabel()
        label.text = "Maximum Value: "
        
        let stackView = UIStackView(arrangedSubviews: [label,
                                                       maximumValueStepper])
        
        return stackView
    }()
    
    private lazy var currentValueStepperStack: UIStackView = {
        
        let label = UILabel()
        label.text = "Current Value: "
        
        let stackView = UIStackView(arrangedSubviews: [label,
                                                       currentValueStepper])
        
        return stackView
    }()
    
    private lazy var maximumValueStepper: UIStepper = {
        
        let stepper = UIStepper()
        stepper.maximumValue = 10
        stepper.minimumValue = 3
        stepper.value = Double(Constants.defaultMaximumValue)
        stepper.addTarget(self,
                          action: #selector(maximumValueChanged(_:)),
                          for: .valueChanged)
        
        return stepper
    }()
    
    private lazy var currentValueStepper: UIStepper = {
        
        let stepper = UIStepper()
        stepper.maximumValue = 10
        stepper.minimumValue = 0
        stepper.addTarget(self,
                          action: #selector(currentValueChanged(_:)),
                          for: .valueChanged)
        
        return stepper
    }()
    
    private lazy var contentStack: UIStackView = {
       
        let label = UILabel()
        label.text = "Try changing values programmatically"
        
        let stackView = UIStackView(arrangedSubviews: [valueLabel,
                                                       ratingControl,
                                                       label,
                                                       currentValueStepperStack,
                                                       maximumValueStepperStack]).usingAutoLayout()
        
        stackView.axis = .vertical
        stackView.spacing = Constants.contentSpacing
        stackView.alignment = .center
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            contentStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            contentStack.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor,
                                                   constant: Constants.horizontalMargin),
            
            contentStack.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor,
                                                   constant: -Constants.horizontalMargin),
        ])
    }
    
    init() { super.init(nibName: nil, bundle: nil) }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ViewController {

    @objc
    func valueChanged(_ sender: SRRater) {
        
        valueLabel.text = "\(sender.value)"
        currentValueStepper.value = Double(sender.value)
    }
    
    @objc
    func maximumValueChanged(_ sender: UIStepper) {
        
        ratingControl.maximumValue = Int(sender.value)
        currentValueStepper.maximumValue = sender.value
    }
    
    @objc
    func currentValueChanged(_ sender: UIStepper) {
        
        ratingControl.value = Int(sender.value)
    }
}

