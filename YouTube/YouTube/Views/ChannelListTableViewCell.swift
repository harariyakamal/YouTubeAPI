//
//  ChannelListTableViewCell.swift
//  YouTube
//
//  Created by Kamal Harariya on 3/18/18.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit

class ChannelListTableViewCell: UICollectionViewCell{
    
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
        _titleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        _titleLabel.backgroundColor = UIColor.clear
        return _titleLabel
    }()
    
    var descriptionLabel: UILabel = {
        let _descriptionLabel = UILabel()
        _descriptionLabel.numberOfLines = 0
        _descriptionLabel.font = UIFont(name: "Helvetica", size: 16.0)
        _descriptionLabel.backgroundColor = UIColor.clear
        return _descriptionLabel
    }()
    
    var publishDateLabel: UILabel = {
        let _publishLabel = UILabel()
        _publishLabel.font = UIFont.boldSystemFont(ofSize: 12)
        _publishLabel.textColor = UIColor.subLineColor
        _publishLabel.backgroundColor = UIColor.clear
        _publishLabel.text = "asda "
        return _publishLabel
    }()
    
    var statusLabel: UILabel = {
        let _status = UILabel()
        _status.font = UIFont.boldSystemFont(ofSize: 12)
        _status.textColor = UIColor.subLineColor
        _status.backgroundColor = UIColor.clear
        _status.text = "5.66K subscribers"  /// This is hard coded string, we can get this information and render the UI accordingly. 
        return _status
    }()
    
    /// Setup subviews for this cell.
    private func setupSubViews() {
        addSubview(thumbnailImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(publishDateLabel)
        addSubview(seperatorView)
        addSubview(statusLabel)
        
        addConstraintsWithFormat("H:|-8-[v0(150)]-8-[v1]-8-|", thumbnailImageView, titleLabel)
        addConstraintsWithFormat("H:|-8-[v0(150)]-8-[v1]-8-|", thumbnailImageView, descriptionLabel)
        addConstraintsWithFormat("H:[v0(v1)]-8-|", publishDateLabel, titleLabel)
        addConstraintsWithFormat("H:[v0(v1)]-8-|", statusLabel, titleLabel)
        addConstraintsWithFormat("V:|-8-[v0(28)]-4-[v1(20)]-4-[v2(70)]-4-[v3(24)]", titleLabel, publishDateLabel, descriptionLabel, statusLabel)
        addConstraintsWithFormat("H:|-8-[v0]-8-|", seperatorView)
        addConstraintsWithFormat("V:|-8-[v0(150)]-8-[v1(0.5)]-8.5-|", thumbnailImageView, seperatorView)
    }
}
