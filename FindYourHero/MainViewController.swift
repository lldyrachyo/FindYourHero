//
//  MainViewController.swift
//  FindYourHero
//
//  Created by Mark Papush on 9/4/23.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "Cell"

class MainViewController: UICollectionViewController {
    var heroes: [Superhero] = []
    private let networkManager = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchHeroes()
    }
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return heroes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "heroCell", for: indexPath) as! HeroViewCell
        let superHero = heroes[indexPath.row]
        cell.configure(with: superHero)
        return cell
    }

    private func fetchHeroes() {
        networkManager.fetchData { [weak self] result in
            switch result {
            case .success(let heroes):
                self?.heroes = heroes
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    @IBAction func clearCache(_ sender: UIBarButtonItem) {
        let cache = ImageCache.default
        cache.clearMemoryCache()
        cache.clearDiskCache()
    }
}
