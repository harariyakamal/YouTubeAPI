//
//  VideoTableViewCell.swift
//  YouTube
//
//  Created by Kamal Harariya on 3/18/18.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubViews()
    }
    
    /// Thumbnail image view
    var cellImageView: UIImageView = {
        let _cellImageView = UIImageView()
        _cellImageView.contentMode = .scaleAspectFill
        _cellImageView.layer.masksToBounds = true
        return _cellImageView
    }()
    
    var footerView: UIView = {
        let _footerView = UIView()
        _footerView.backgroundColor = UIColor.white
        return _footerView
    }()
    
    static func buttonForTitle(_title: String, withImage _imageName: String? = nil) -> UIButton {
        let _button = UIButton()
        _button.setTitle(_title, for: .normal)
        if let _buttonImageName = _imageName {
            let _image = UIImage(named: _buttonImageName)?.withRenderingMode(.alwaysTemplate)
            _button.setImage(_image, for: .normal)
            _button .tintColor = UIColor.bottomButtonColor
            _button.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 12.0, bottom: 0.0, right: 0.0)
        }
        
        _button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12.0)
        _button.setTitleColor(UIColor.bottomButtonColor, for: .normal)
        return _button
    }
    
    let likeButton = buttonForTitle(_title: "Like", withImage: "Like")
    let commentButton = buttonForTitle(_title: "Comment", withImage: "Comment")
    let shareButton = buttonForTitle(_title: "Share", withImage: "Share")

    var titleLabel: UILabel = {
        let _titleLabel = UILabel()
        _titleLabel.numberOfLines = 0
        _titleLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        _titleLabel.backgroundColor = UIColor.clear
        return _titleLabel
    }()
    
    var publishLabel: UILabel = {
        let _publishLabel = UILabel()
        _publishLabel.backgroundColor = UIColor.clear
        _publishLabel.textColor = UIColor.subLineColor
        _publishLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        return _publishLabel
    }()
    
    var descriptionLabel: UILabel = {
        let _descriptionLabel = UILabel()
        _descriptionLabel.numberOfLines = 0
        _descriptionLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        _descriptionLabel.backgroundColor = UIColor.clear
        return _descriptionLabel
    }()
    
    var channelLabel: UILabel = {
        let _channelLabel = UILabel()
        _channelLabel.numberOfLines = 1
        _channelLabel.backgroundColor = UIColor.random
        return _channelLabel
    }()
    
    // Subviews.
    private func setupSubViews() {
        addSubview(cellImageView)
        addSubview(footerView)
        addSubview(titleLabel)
        addSubview(publishLabel)
        addSubview(channelLabel)
        addSubview(descriptionLabel)
        
        footerView.addSubview(likeButton)
        footerView.addSubview(commentButton)
        footerView.addSubview(shareButton)
        
        addConstraintsWithFormat("H:|-8-[v0(210)]-4-[v1]-8-|", cellImageView, titleLabel)
        addConstraintsWithFormat("H:|-8-[v0(210)]-4-[v1]-8-|", cellImageView, publishLabel)
        addConstraintsWithFormat("H:|-8-[v0(210)]-4-[v1]-8-|", cellImageView, descriptionLabel)
        
        addConstraintsWithFormat("V:|-8-[v0(140)]", cellImageView)
        addConstraintsWithFormat("V:|-8-[v0(44)]", titleLabel)
        addConstraintsWithFormat("V:|-8-[v0]-4-[v1(20)]-4-[v2(72)]", titleLabel, publishLabel, descriptionLabel)
        
        addConstraintsWithFormat("H:|-8-[v0]-8-|", footerView)
        
        addConstraintsWithFormat("V:|-8-[v0(140)]-4-[v1(40)]-8-|", cellImageView, footerView)

        footerView.addConstraintsWithFormat("H:|[v0(v2)][v1(v2)][v2]|", likeButton, commentButton, shareButton)
        footerView.addConstraintsWithFormat("V:|-4-[v0]-4-|", likeButton)
        footerView.addConstraintsWithFormat("V:|-4-[v0]-4-|", commentButton)
        footerView.addConstraintsWithFormat("V:|-4-[v0]-4-|", shareButton)
    }
}
