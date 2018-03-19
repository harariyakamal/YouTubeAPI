//
//  ChannelResultItem.swift
//  YouTube
//
//  Created by Kamal Harariya on 3/18/18.
//  Copyright © 2018 company. All rights reserved.
//

struct ChannelResultItem {
    
    /// Title of the channel. Default value is empty string.
    var title: String = ""
    
    // Country code. Default value is empty string.
    var countryCode: String = ""
    
    /// Result kind. Default value is empty string.
    var kind: String = ""
    
    // Pubslish date. Default value is empty string.
    var publishDate: String = ""
    
    /// Thumbnail image url.
    var imageUrlString: String?
    
    /// Channel Id. This shouldn't be nil but making it optional so that we can check for nil value.
    var id: String?
    
    /// Next Page token, this will help later when we implement search of channels.
    var nextPageToken: String?
 
    // Channel description. Default value is empty string.
    var channelDescription: String = ""
    
    init(withResult result: Dictionary<String, Any>) {
        
        if let _kind = result["kind"] as? String {
            self.kind = _kind
        }
        
        if let _nextPageToken = result["nextPageToken"] as? String {
            self.nextPageToken = _nextPageToken
        }
        
        if let _id = result["id"] as? String {
            self.id = _id
        }
        
        if let _snippet = result["snippet"] as? Dictionary<String, Any> {
            
            if let _thumbnails = _snippet["thumbnails"] as? Dictionary<String, Any> {
                if let _high = _thumbnails["high"] as? Dictionary<String, Any>, let _urlString = _high["url"] as? String {
                    self.imageUrlString = _urlString
                }
            }
            
            if let _title = _snippet["title"] as? String {
                self.title = _title
            }
            
            if let _countryCode = _snippet["country"] as? String {
                self.countryCode = _countryCode
            }
            
            if let _description = _snippet["description"] as? String {
                self.channelDescription = _description
            }
            
            if let _publishedAt = _snippet["publishedAt"] as? String {
                self.publishDate = _publishedAt
            }
        }
    }
}
