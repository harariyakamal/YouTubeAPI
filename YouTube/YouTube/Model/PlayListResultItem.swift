//
//  PlayListResultItem.swift
//  YouTube
//
//  Created by Kamal Harariya on 3/18/18.
//  Copyright © 2018 company. All rights reserved.
//

import Foundation

struct PlayListResultItem {
    
    /// Title of the channel. Default value is empty string.
    var title: String = ""
    
    /// Result kind. Default value is empty string.
    var kind: String = ""
    
    // Pubslish date. Default value is empty string.
    var publishDateString: String = ""
    
    /// Thumbnail image url.
    var imageUrlString: String?
    
    /// Channel Id. This shouldn't be nil but making it optional so that we can check for nil value.
    var playListId: String?
    
    /// Next Page token, this will help later when we implement search of channels.
    var nextPageToken: String?
    
    // Channel description. Default value is empty string.
    var listDescription: String = ""
    
    init(withResult result: Dictionary<String, Any>) {
        
        if let _kind = result["kind"] as? String {
            self.kind = _kind
        }
        
        if let _nextPageToken = result["nextPageToken"] as? String {
            self.nextPageToken = _nextPageToken
        }
        
        if let _id = result["id"] as? String {
            self.playListId = _id
        }
        
        if let _snippet = result["snippet"] as? Dictionary<String, Any> {
            
            if let _thumbnails = _snippet["thumbnails"] as? Dictionary<String, Any> {
                if let _standard = _thumbnails["standard"] as? Dictionary<String, Any>, let _urlString = _standard["url"] as? String {
                    self.imageUrlString = _urlString
                }
            }
            
            if let _title = _snippet["title"] as? String {
                self.title = _title
            }
            
            if let _description = _snippet["description"] as? String {
                self.listDescription = _description
            }
            
            if let _publishedAt = _snippet["publishedAt"] as? String {
                self.publishDateString = _publishedAt
            }
        }
    }
}
