//
//  SearchVC.swift
//  Book_Searcher
//
//  Created by Mac on 7/8/21.
//

import UIKit

class SearchVC: UIViewController {
    
    private let bookCellID = "BookCell"
    
//    @IBOutlet weak var searchbar: UISearchBar! {
//        didSet {
//            searchbar.delegate = self
//        }
//    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "BookCell", bundle: nil), forCellWithReuseIdentifier: bookCellID)
        }
    }
        
    var data:[BookModel] = [
        BookModel(thumbnail: "http://books.google.com/books/content?id=sWcPAQAAMAAJ&printsec=frontcover&img=1&zoom=5&source=gbs_api", title: "Programming Pearls", authors: ["Jon Louis Bentley"]),
        BookModel(thumbnail: "http://books.google.com/books/content?id=sWcPAQAAMAAJ&printsec=frontcover&img=1&zoom=5&source=gbs_api", title: "CGI Programming with Perl", authors: ["Peter Van-Roy", "Seif Haridi, Seif (Chief Scientist Haridi", "Swedish Inst of Computer Science)"])
    
    ]
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchViewModel = SearchViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Books"
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        
        searchViewModel.delegate = self
                
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
    
}

//MARK: - SearchController Delegate Methods
extension SearchVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
//        print(text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //TODO:: alert
        searchViewModel.getSearchResult(query: searchBar.text ?? "", maxResult: 20)
        
        searchController.dismiss(animated: true, completion: nil)
    }
    
}

extension SearchVC: SearchResultDelegate {
    func getResult(data: [BookModel]) {
        
    }
    
    
}






//extension SearchVC: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//        if searchText.isEmpty {
//            self.data = oldData
//        } else {
//            self.data = searchFor(text: searchText)
//        }
//        collectionView.reloadData()
//    }
//
//    func searchFor(text: String) -> [BookModel] {
//
//        var newData = [BookModel]()
//        for i in self.oldData where i.title.hasPrefix(text) {
//            newData.append(i)
//        }
//        return newData
//    }
//}
