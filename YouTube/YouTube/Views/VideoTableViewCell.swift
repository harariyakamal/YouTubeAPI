//
//  VideoTableViewCell.swift
//  YouTube
//
//  Created by Kamal Harariya on 3/18/18.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit

protocol VideoCellDelegate: NSObjectProtocol {
    func videoCellActionButtonClicked(_ actionButton: UIButton)
}

class VideoTableViewCell: UITableViewCell {
    
    /** A delegate. */
    weak var cellDelegate: VideoCellDelegate?
    
    
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
    
    var likeLabel: UILabel = {
        let _likeLabel = UILabel()
        _likeLabel.textAlignment = .center
        _likeLabel.text = "55 Likes"
        _likeLabel.textColor = UIColor.subLineColor
        _likeLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        _likeLabel.backgroundColor = UIColor.clear
        return _likeLabel
    }()
    
    var commentLabel: UILabel = {
        let _commentLabel = UILabel()
        _commentLabel.textAlignment = .center
        _commentLabel.text = "505 Comments"
        _commentLabel.textColor = UIColor.subLineColor
        _commentLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        _commentLabel.backgroundColor = UIColor.clear
        return _commentLabel
    }()
    
    // Subviews.
    private func setupSubViews() {
        addSubview(cellImageView)
        addSubview(footerView)
        addSubview(titleLabel)
        addSubview(publishLabel)
        addSubview(channelLabel)
        addSubview(descriptionLabel)
        addSubview(likeLabel)
        addSubview(commentLabel)
        
        likeButton.addTarget(self, action: #selector(likeButtonClicked(_:)), for: .touchUpInside)
        footerView.addSubview(likeButton)
        
        commentButton.addTarget(self, action: #selector(commentsButtonClicked(_:)), for: .touchUpInside)
        footerView.addSubview(commentButton)
        
        shareButton.addTarget(self, action: #selector(actionButtonClicked(_:)), for: .touchUpInside)
        footerView.addSubview(shareButton)
        
        addConstraintsWithFormat("H:|-8-[v0(210)]-4-[v1]-8-|", cellImageView, titleLabel)
        addConstraintsWithFormat("H:|-8-[v0(210)]-4-[v1]-8-|", cellImageView, publishLabel)
        addConstraintsWithFormat("H:|-8-[v0(210)]-4-[v1]-8-|", cellImageView, descriptionLabel)
        
        addConstraintsWithFormat("V:|-8-[v0(140)]-4-[v1(26)]-4-[v2(40)]-8-|", cellImageView, likeLabel, footerView)
        addConstraintsWithFormat("V:|-8-[v0(140)]-4-[v1(26)]-4-[v2(40)]-8-|", cellImageView, commentLabel, footerView)
        
        addConstraintsWithFormat("V:|-8-[v0(44)]", titleLabel)
        addConstraintsWithFormat("V:|-8-[v0]-4-[v1(20)]-4-[v2(72)]", titleLabel, publishLabel, descriptionLabel)
        
        addConstraintsWithFormat("H:|-8-[v0]-8-|", footerView)
            
        addConstraintsWithFormat("H:|-8-[v0(v1)][v1]-8-|", likeLabel, commentLabel)

        footerView.addConstraintsWithFormat("H:|[v0(v2)][v1(v2)][v2]|", likeButton, commentButton, shareButton)
        footerView.addConstraintsWithFormat("V:|-4-[v0]-4-|", likeButton)
        footerView.addConstraintsWithFormat("V:|-4-[v0]-4-|", commentButton)
        footerView.addConstraintsWithFormat("V:|-4-[v0]-4-|", shareButton)
    }
    
    // Actions.
    @objc func actionButtonClicked(_ sender: UIButton) {
        cellDelegate?.videoCellActionButtonClicked(sender)
    }
    
    /// This is testing, get this data from server and use that.
    @objc func likeButtonClicked(_ sender: UIButton) {
        if let _text = likeLabel.text {
            let numericSet = "0123456789"
            let filteredCharacters = _text.filter { return numericSet.contains(String($0)) }
            if var numb = Int(filteredCharacters) {
                numb += 1
                
                UIView.transition(with: likeLabel, duration: 0.50, options: .transitionCrossDissolve, animations: {
                    self.likeLabel.textColor = .red
                    self.likeLabel.text = "\(numb) Likes"
                }) { (completed) in
                    if completed {
                        self.likeLabel.textColor = UIColor.subLineColor
                    }
                }
            }
        }
    }
    
    /// This is testing, get this data from server and use that.
    @objc func commentsButtonClicked(_ sender: UIButton) {
        if let _text = commentLabel.text {
            let numericSet = "0123456789"
            let filteredCharacters = _text.filter { return numericSet.contains(String($0)) }
            if var numb = Int(filteredCharacters) {
                numb += 1
                
                UIView.transition(with: commentLabel, duration: 0.50, options: .transitionCrossDissolve, animations: {
                    self.commentLabel.textColor = .red
                    self.commentLabel.text = "\(numb) Comments"
                }) { (completed) in
                    if completed {
                        self.commentLabel.textColor = UIColor.subLineColor
                    }
                }
            }
        }
    }
}
