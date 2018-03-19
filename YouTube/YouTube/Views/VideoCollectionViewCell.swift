//
//  VideoCollectionViewCell.swift
//  YouTube
//
//  Created by Kamal Harariya on 3/15/18.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubViews()
    }
    
    /// Thumbnail image view
    var thumbnailImageView: UIImageView = {
        let _thumbnailImageView = UIImageView()
        _thumbnailImageView.contentMode = .scaleAspectFit
        _thumbnailImageView.layer.masksToBounds = true
        return _thumbnailImageView
    }()

    /// Seperator view.
    var seperatorView: UIView = {
        let _seperatorView = UIView()
        _seperatorView.backgroundColor = UIColor.seperatorColor
        return _seperatorView
    }()
    
    var nameLabel: UILabel = {
        let _nameLabel = UILabel()
        _nameLabel.numberOfLines = 1
        _nameLabel.backgroundColor = UIColor.clear
        return _nameLabel
    }()
    
    var descriptionLabel: UILabel = {
        let _descriptionLabel = UILabel()
        _descriptionLabel.numberOfLines = 0
        _descriptionLabel.font = UIFont(name: "Helvetica", size: 14.0)
        _descriptionLabel.backgroundColor = UIColor.clear
        return _descriptionLabel
    }()

    
    /// Setup subviews for this cell.
    private func setupSubViews() {
        addSubview(thumbnailImageView)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(seperatorView)
        
        addConstraintsWithFormat("H:|-8-[v0(150)]-8-[v1]-8-|", thumbnailImageView, nameLabel)
        addConstraintsWithFormat("H:|-8-[v0(150)]-8-[v1]-8-|", thumbnailImageView, descriptionLabel)
        addConstraintsWithFormat("V:|-8-[v0(40)]-4-[v1]-17-|", nameLabel, descriptionLabel)
        addConstraintsWithFormat("H:|-8-[v0]-8-|", seperatorView)
        addConstraintsWithFormat("V:|-8-[v0(150)]-8-[v1(1)]-8-|", thumbnailImageView, seperatorView)
    }
}
