//
//  SearchVC.swift
//  Book_Searcher
//
//  Created by Mac on 7/8/21.
//

import UIKit

class SearchVC: UIViewController {
    
    private let bookCellID = "BookCell"
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "BookCell", bundle: nil), forCellWithReuseIdentifier: bookCellID)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bookCellID, for: indexPath) as? BookCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width, height: 150)
        return size
    }
    
    
}
