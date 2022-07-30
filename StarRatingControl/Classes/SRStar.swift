//
//  SRRater.swift
//  StarRatingControl
//
//  Created by Rafael Moura on 29/07/2022.
//

internal class SRStar: UIView {
    
    private enum Constants {
        
        static let unselectedStarImage = UIImage(systemName: "star")
        static let selectedStarImage = UIImage(systemName: "star.fill")
    }
    
    private lazy var imageView: UIImageView = {
        
        let imageView = UIImageView(image: Constants.unselectedStarImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var isSelected: Bool = false {
    
        didSet {
            
            imageView.image = isSelected ? Constants.selectedStarImage : Constants.unselectedStarImage
        }
    }
    
    init() {
        
        super.init(frame: .zero)

        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
