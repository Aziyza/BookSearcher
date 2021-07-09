//
//  DetailVC.swift
//  Book_Searcher
//
//  Created by Mac on 7/8/21.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var desc: UITextView!
    
    var book:BookModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if book.thumbnail != nil {
            self.image.load(urlString: book?.thumbnail)
        } else { self.image.image = #imageLiteral(resourceName: "thumbnail") }
        
        if book.title != nil {
            self.bookTitle.text = book?.title
        } else { self.bookTitle.text = "No title" }
        
        if !book.authors.isEmpty {
            self.author.text = book?.authors.joined(separator: ", ")
        } else { self.author.text = "No author" }
        
        if book.description != nil {
            self.desc.text = book?.description
        } else { self.desc.text = "No description" }
        
    }
   
}
