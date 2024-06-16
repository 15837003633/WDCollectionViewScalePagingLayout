//
//  CustomCell.swift
//  CollectionViewDemo
//
//  Created by scott on 2024/6/16.
//

import UIKit

class CustomCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .gray
        contentView.addSubview(self.name_label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public lazy var name_label: UILabel = {
        let label = UILabel()
        label.frame = CGRectMake(10, 10, 50, 30)
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
}
