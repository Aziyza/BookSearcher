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
    func getResult(data: [BookModel])
}

struct SearchViewModel {
    
    var delegate: SearchResultDelegate?
    
    func getSearchResult(query: String, maxResult: Int = 20) {
        
        AF.request(BASE_URL + query + "&maxResults=" + "\(maxResult)", method: .get, encoding: JSONEncoding.default).response { (response) in
            
//            debugPrint(response)
            
            switch response.result {
                case .success(let data):
                    if data != nil {
                        let jsonData = JSON(data!)
                        let items = jsonData["items"].arrayValue
                        for item in items {
                            let title = item["volumeInfo"]["title"].string
                            let authors = item["volumeInfo"]["authors"].arrayValue
                            
                            
                        }
//                        delegate?.getResult(data: <#T##[BookModel]#>)
//                        print(jsonData)
                    }
            case .failure(let error):
                print("Fetch data Error: ", error.localizedDescription)
            
            }
        }
        
    }
    
}
