//
//  SRRater.swift
//  StarRatingControl
//
//  Created by Rafael Moura on 29/07/2022.
//

import Foundation

public class SRRater: UIControl {
    
    private enum Constants {
        
        static let minMaximumValue = 3
        static let maxMaximumValue = 10
        static let defaultValue = 0
        static let starsSpacing: CGFloat = 10
    }
    
    private var _maximumValue: Int = Constants.minMaximumValue {
        
        didSet {
            if maximumValue != oldValue { reloadView() }
        }
    }
    
    /// This property defines the number of stars
    ///
    /// Minimum 3 and maximum 10. If you set a number less than 3 it will automatically set the minimum value (`3`) instead.
    /// And If you set a value greater than 10 it will set the maximum value (`10`).
    /// The default value is `3`
    public var maximumValue: Int {
    
        get { _maximumValue }
        
        set {
            
            let minimumValue = max(newValue, Constants.minMaximumValue)
            
            _maximumValue = min(minimumValue, Constants.maxMaximumValue)
            _value = min(_value, _maximumValue)
        }
    }
    
    private var _value: Int = Constants.defaultValue {
        
        didSet {
         
            guard let stars = contentStack.arrangedSubviews as? [SRStar] else { return }
            
            for (index, star) in stars.enumerated() { star.isSelected = index < _value }
            
            updateAccessibility()
        }
    }
    
    /// This property defines the current rating value, it is used to paint the corresponding stars
    ///
    /// The minimum value is `0`, and the maximum is the `maximumValue`.
    /// If you set any number less than `0` it will automatically set to `0`.
    /// And any value greater than the current `maximumValue` will set this automatically to `maximumValue`
    /// The default value is `0`
    public var value: Int {
        
        get { _value }
        
        set {
            
            let minValue = max(newValue, Constants.defaultValue)
            
            _value = min(minValue, _maximumValue)
         }
    }
    
    private lazy var contentStack: UIStackView = {
       
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.spacing = Constants.starsSpacing
        stackView.isUserInteractionEnabled = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
            
        return stackView
    }()
    
    public init() {

        super.init(frame: .zero)

        loadView()
        setupAccessibility()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        loadView()
        setupAccessibility()
    }
}

// MARK: - Private
private extension SRRater {
    
    private func loadView() {
        
        for i in 1..._maximumValue {
            
            let star = SRStar()
            star.isUserInteractionEnabled = false
            star.isSelected = i <= _value
            
            contentStack.addArrangedSubview(star)
            
            // It keeps the aspect ratio whatever is the component's height defined by the users
            star.widthAnchor.constraint(equalTo: star.heightAnchor).isActive = true
        }
    }
    
    private func reloadView() {
        
        contentStack.removeAllArrangedSubviews()
        loadView()
    }
    
    private func rate(for star: SRStar) -> Int {
        
        return (contentStack.arrangedSubviews.firstIndex(of: star) ?? 0) + 1
    }
}

// MARK: - Input Handlers
extension SRRater {

    public override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {

        rate(with: touch, event: event)
        return super.beginTracking(touch, with: event)
    }

    public override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {

        rate(with: touch, event: event)
        return  super.continueTracking(touch, with: event)
    }
    
    private func rate(with touch: UITouch, event: UIEvent?) {
        
        let touchLocation = touch.location(in: contentStack)
        
        let centeredLocation = CGPoint(x: touchLocation.x,
                                       y: contentStack.frame.midY)


        guard let star = contentStack.subviews.first(where: { $0.frame.contains(centeredLocation) }) as? SRStar else { return }
        
        value = rate(for: star)
        sendActions(for: .valueChanged)
    }
}

// MARK: - Accessibility
extension SRRater {

    private func setupAccessibility() {
        
        isAccessibilityElement = true
        accessibilityTraits = .adjustable
        accessibilityLabel = NSLocalizedString("starRatingControl",
                                               bundle: Bundle.init(for: Self.self),
                                               comment: "")

        updateAccessibility()
    }
    
    private func updateAccessibility() {
        
        let localizedFormat = NSLocalizedString("stars",
                                                bundle: Bundle.init(for: Self.self),
                                                comment: "")
        accessibilityValue = String.localizedStringWithFormat(localizedFormat, _value)
    }
    
    public override func accessibilityIncrement() {
        
        super.accessibilityIncrement()
        
        value += 1
    }
    
    public override func accessibilityDecrement() {
        
        super.accessibilityDecrement()
        
        value -= 1
    }
}

private extension UIStackView {
    
    func removeAllArrangedSubviews() {
        
        subviews.forEach {
            
            $0.removeFromSuperview()
            removeArrangedSubview($0)
        }
    }
}
