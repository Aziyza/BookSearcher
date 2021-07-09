//
//  SearchViewModel.swift
//  Book_Searcher
//
//  Created by Mac on 7/8/21.
//

import UIKit
import Alamofire
import SwiftyJSON

let BASE_URL = "https://www.googleapis.com/books/v1/volumes?q="

protocol SearchResultDelegate {
    func getResult(data: [BookModel], totalItems: Int)
    func getNextResult(data: [BookModel])
}

struct SearchViewModel {
    
    var delegate: SearchResultDelegate?
        
    func getSearchResult(query: String, maxResult: Int = 20, startIndex: Int = 0) {
        
        var books = [BookModel]()
        var title: String?
        var authors = [String]()
        var thumbnail: String?
        var desc: String?
        
        AF.request(BASE_URL + query + "&maxResults=" + "\(maxResult)", method: .get, encoding: JSONEncoding.default).response { (response) in
                        
            switch response.result {
                case .success(let data):
                    if data != nil {
                        let jsonData = JSON(data!)
                        let totalItems = jsonData["totalItems"].intValue
                        let items = jsonData["items"].arrayValue
                        for item in items {
                            title = item["volumeInfo"]["title"].stringValue
                            let authorsArr = item["volumeInfo"]["authors"].arrayValue
                            for author in authorsArr { authors.append(author.string ?? "") }
                            thumbnail = item["volumeInfo"]["imageLinks"]["thumbnail"].string
                            desc = item["volumeInfo"]["description"].string
                            
                            let bookModel = BookModel(thumbnail: thumbnail, title: title, authors: authors, description: desc)
                            books.append(bookModel)
                        }
                        if startIndex == 0 {
                            delegate?.getResult(data: books, totalItems: totalItems)
                        } else {
                            delegate?.getNextResult(data: books)
                        }
                        
                    }
            case .failure(let error):
                print("Fetch data Error: ", error.localizedDescription)
            
            }
        }
        
    }
        
}

