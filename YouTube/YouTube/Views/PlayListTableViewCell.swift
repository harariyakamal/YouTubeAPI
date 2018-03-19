//
//  PlayListTableViewCell.swift
//  YouTube
//
//  Created by Kamal Harariya on 3/18/18.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit

class PlayListTableViewCell: UITableViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubViews()
    }
    
    /// Thumbnail image view
    var thumbnailImageView: UIImageView = {
        let _thumbnailImageView = UIImageView()
        _thumbnailImageView.contentMode = .scaleAspectFill
        _thumbnailImageView.layer.masksToBounds = true
        return _thumbnailImageView
    }()
    
    var titleLabel: UILabel = {
        let _titleLabel = UILabel()
        _titleLabel.numberOfLines = 2
        _titleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        _titleLabel.backgroundColor = UIColor.clear
        return _titleLabel
    }()
    
    var publishDateLabel: UILabel = {
        let _publishLabel = UILabel()
        _publishLabel.font = UIFont.boldSystemFont(ofSize: 12)
        _publishLabel.textColor = UIColor.subLineColor
        _publishLabel.backgroundColor = UIColor.clear
        return _publishLabel
    }()
    
    /// Setup subviews for this cell.
    private func setupSubViews() {
        addSubview(thumbnailImageView)
        addSubview(titleLabel)
        addSubview(publishDateLabel)
        
        addConstraintsWithFormat("H:|-8-[v0(150)]-8-[v1]-8-|", thumbnailImageView, titleLabel)
        addConstraintsWithFormat("V:|-8-[v0(134)]-8-|", thumbnailImageView)
        addConstraintsWithFormat("V:|-8-[v0(46)]-4-[v1(20)]", titleLabel, publishDateLabel)
        
        addConstraintsWithFormat("H:[v0(v1)]-8-|", publishDateLabel, titleLabel)

    }
}
