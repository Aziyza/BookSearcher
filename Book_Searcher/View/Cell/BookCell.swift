//
//  BookCell.swift
//  Book_Searcher
//
//  Created by Mac on 7/8/21.
//

import UIKit

class BookCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configure(model: BookModel) {
        self.title.text = model.title
        self.author.text = model.authors.joined(separator: ", ")
    }
    
}
