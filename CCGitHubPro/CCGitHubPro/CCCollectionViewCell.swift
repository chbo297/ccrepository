//
//  CCCollectionViewCell.swift
//  CCGitHubPro
//
//  Created by bo on 20/12/2016.
//  Copyright © 2016 bo. All rights reserved.
//

import UIKit
import SnapKit

class CCCollectionViewCell: UICollectionViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imageView : UIImageView = {
        var imv = UIImageView()
        imv.contentMode = UIViewContentMode.scaleAspectFill
        imv.clipsToBounds = true
        return imv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.blue
        self.commonInit()
    }
    
    func commonInit() {
        self.contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
    }
    
    
}
