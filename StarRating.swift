//
//  StarRating.swift
//  Pods-StarRatingControl_Example
//
//  Created by Rafael Moura on 29/07/2022.
//

import Foundation

public class StarRating: UIControl {
    
    private enum Constants {
        
        static let defaultMaximumRate = 3
        static let defaultRate = 0
        static let starsSpacing: CGFloat = 10
    }
    
    public var maximumRate: Int = Constants.defaultMaximumRate {
        
    }
    public var rate: Int = Constants.defaultRate
    
    private lazy var contentStack: UIStackView = {
       
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.spacing = Constants.starsSpacing
        
        return stackView
    }()
    
    
    public init() {
        
        super.init(frame: .zero)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadView() {
        
        for _ in 0..<maximumRate { appendStar() }
    }
    
    private func appendStar() {
        
        let star = UIButton(type: .system)
        star.setImage(UIImage(systemName: "star"), for: .normal)
        star.setImage(UIImage(systemName: "star.fill"), for: .selected)
        
        self.contentStack.addArrangedSubview(star)
    }
}
