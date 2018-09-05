//
//  PhotoCollectionViewCell.swift
//  FlickerSearch
//
//  Created by Fabricio Rodriguez on 9/5/18.
//  Copyright © 2018 Fabricio Rodriguez. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureWith(photo: Photo) {
        if let url = URL(string: photo.url) {
            image.kf.setImage(with: url)
        }
    }
}
