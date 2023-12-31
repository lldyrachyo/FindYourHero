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

    func configure(with superhero: Superhero) {
        nameLabel.text = superhero.name
        guard let imageURL = URL(string: superhero.images.lg) else { return }
        
        let url = imageURL
        let processor = DownsamplingImageProcessor(size: heroImage.bounds.size)
        heroImage.kf.indicatorType = .activity
        heroImage.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        )
    }
}
