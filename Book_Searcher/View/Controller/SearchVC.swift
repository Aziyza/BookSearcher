//
//  SearchVC.swift
//  Book_Searcher
//
//  Created by Mac on 7/8/21.
//

import UIKit

class SearchVC: UIViewController {
    
    private let bookCellID = "BookCell"
    private let reloadViewID = "ReloadView"
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "BookCell", bundle: nil), forCellWithReuseIdentifier: bookCellID)
            collectionView.register(UINib(nibName: "ReloadView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: reloadViewID)
        }
    }
    
    let searchController = UISearchController()
    var searchViewModel = SearchViewModel()
    var data = [BookModel]()
    var totalBooks = 0
    
    var isLoading = false
    var loadingView: ReloadView?
    var searchText: String?
    var pageCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Books"
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search book"
        searchViewModel.delegate = self
        
        let bgView = UIImageView(image: #imageLiteral(resourceName: "book"))
        bgView.contentMode = .scaleAspectFill
        collectionView.backgroundView = bgView
               
    }
}

//MARK: - CollectionView Configuration
extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bookCellID, for: indexPath) as? BookCell else { return UICollectionViewCell() }
        cell.configure(model: data[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width, height: 150)
        return size
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailVC(nibName: "DetailVC", bundle: nil)
        vc.book = data[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // collectionView Infinity scrolling methods for getting more data

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            if kind == UICollectionView.elementKindSectionFooter {
                let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reloadViewID, for: indexPath) as! ReloadView
                loadingView = footerView
                return footerView
            }
            return UICollectionReusableView()
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if data.isEmpty {
            return CGSize.zero
        }
        return CGSize(width: collectionView.bounds.size.width, height: 55)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            if indexPath.row == data.count-1 && !isLoading {
                loadMoreData()
            }
        }

        func loadMoreData() {
            if !isLoading {
                if data.count < totalBooks {
                    self.loadingView?.indicator.startAnimating()
                    isLoading = true
                    pageCount = pageCount + 20
                    searchViewModel.getSearchResult(query: searchText!, startIndex: pageCount)
                } else {
                    self.loadingView?.indicator.stopAnimating()
                    self.loadingView?.indicator.hidesWhenStopped = true
                }
                
            }
        }
    
}

//MARK: - SearchController Delegate Methods
extension SearchVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchText = searchBar.text
        searchViewModel.getSearchResult(query: searchBar.text!)
        searchController.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - Recieving fetched book data
extension SearchVC: SearchResultDelegate {
    func getNextResult(data: [BookModel]) {
        self.data = self.data + data
        self.isLoading = false
        collectionView.reloadData()
    }
    
    func getResult(data: [BookModel], totalItems: Int) {
        self.data = data
        self.totalBooks = totalItems
        collectionView.backgroundView = UIImageView()
        collectionView.reloadData()
    }
    
}
