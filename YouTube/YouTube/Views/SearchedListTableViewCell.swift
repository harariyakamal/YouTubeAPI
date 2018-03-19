//
//  SearchedListTableViewCell.swift
//  YouTube
//
//  Created by Kamal Harariya on 3/17/18.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit

class SearchedListTableViewCell: UITableViewCell {

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
    
    var titleLabel: UILabel = {
        let _titleLabel = UILabel()
        _titleLabel.numberOfLines = 1
        _titleLabel.backgroundColor = UIColor.clear
        return _titleLabel
    }()
    
    var descriptionLabel: UILabel = {
        let _descriptionLabel = UILabel()
        _descriptionLabel.numberOfLines = 0
        _descriptionLabel.font = UIFont.boldSystemFont(ofSize: 12)
        _descriptionLabel.backgroundColor = UIColor.subLineColor
        return _descriptionLabel
    }()

    /// Setup subviews for this cell.
    private func setupSubViews() {
        addSubview(thumbnailImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(seperatorView)
        
        addConstraintsWithFormat("H:|-8-[v0(150)]-8-[v1]-8-|", thumbnailImageView, titleLabel)
        addConstraintsWithFormat("H:[v0(v1)]-8-|", descriptionLabel, titleLabel)
        addConstraintsWithFormat("V:|-8-[v0(32)]-4-[v1]", titleLabel, descriptionLabel)
        addConstraintsWithFormat("H:|-8-[v0]-8-|", seperatorView)
        addConstraintsWithFormat("V:|-8-[v0(150)]-8-[v1(1)]-8-|", thumbnailImageView, seperatorView)
    }

}
