//
//  HeroViewCell.swift
//  FindYourHero
//
//  Created by Mark Papush on 9/4/23.
//

import UIKit
import Kingfisher

class HeroViewCell: UICollectionViewCell {
    @IBOutlet var heroImage: UIImageView! {
        didSet {
            heroImage.layer.cornerRadius = 15
        }
    }
    @IBOutlet var nameLabel: UILabel!
    
    private var activityIndicator: UIActivityIndicatorView?
//    private let networkManager
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator = showSpinner(in: heroImage)
    }
    
    func configure(with superhero: Superhero) {
        nameLabel.text = superhero.name
        guard let imageURL = URL(string: superhero.images.lg) else { return }
        
        heroImage.kf.setImage(with: imageURL) { [weak self] result in
            switch result {
            case .success(_):
                self?.activityIndicator?.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        return activityIndicator
    }
}
