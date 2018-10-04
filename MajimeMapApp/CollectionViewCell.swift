//
//  CollectionViewCell.swift
//  MajimeMapApp
//
//  Created by CaoQian on 2018/09/22.
//  Copyright © 2018 CaoQian. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    //let photos = ["1x.jpg", "2x.jpg","3x.png","4x.jpg","5x.png","6x.png","7x.jpg","8x"]
    var cell = UIImage()
    
    @IBOutlet weak var image: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
  }
