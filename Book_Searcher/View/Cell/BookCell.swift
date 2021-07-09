//
//  BookCell.swift
//  Book_Searcher
//
//  Created by Mac on 7/8/21.
//

import UIKit
import Kingfisher

class BookCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configure(model: BookModel) {
        
        if model.thumbnail != nil {
            self.image.load(urlString: model.thumbnail)
        } else { self.image.image = #imageLiteral(resourceName: "thumbnail") }
        
        if model.title != nil {
            self.title.text = model.title
        } else { self.title.text = "No title" }
        
        if !model.authors.isEmpty {
            self.author.text = model.authors.joined(separator: ", ")
        } else { self.author.text = "No author" }
        
    }
    
}

//MARK: - Load image by urlString
extension UIImageView {
    func load(urlString: String?) {
        let imageUrl = URL(string: urlString ?? "")
        if imageUrl != nil {
            self.kf.indicatorType = .activity
            self.kf.setImage(with: imageUrl)
        }
    }
}
