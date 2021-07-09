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
        self.title.text = model.title
        self.author.text = model.authors.joined(separator: ", ")
        self.image.load(urlString: model.thumbnail)
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
