//
//  SearchedResultItem.swift
//  YouTube
//
//  Created by Kamal Harariya on 3/17/18.
//  Copyright © 2018 company. All rights reserved.
//

import Foundation

struct SearchedResultItem {
    
    /// Result.
    var searchedResult: Dictionary<String, Any>?
    
    /// Result kind.
    var kind: String = ""
    
    /// Id.
    var id: String?
    
    /// Next Page token
    var nextPageToken: String?
    
    /// Resource id, this can be nil.
    var resourceId: Dictionary<String, Any>?
    
    /// Thumbnail image url.
    var thumbnailUrlString: String?
    
    /// Title
    var title: String = ""
    
    var itemDescription: String = ""
    
    var publishDate: String?
    
    init(withResult result: Dictionary<String, Any>) {
        searchedResult = result
        
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
            if let _resouceId = _snippet["resourceId"] as? Dictionary<String, Any> {
                self.resourceId = _resouceId
            }
            
            if let _thumbnails = _snippet["thumbnails"] as? Dictionary<String, Any> {
                if let _high = _thumbnails["high"] as? Dictionary<String, Any>, let _urlString = _high["url"] as? String {
                    self.thumbnailUrlString = _urlString
                }
            }
            
            if let _title = _snippet["title"] as? String {
                self.title = _title
            }
            
            if let _description = _snippet["description"] as? String {
                self.itemDescription = _description
            }
            
            if let _publishedAt = _snippet["publishedAt"] as? String {
                self.publishDate = _publishedAt
            }
        }
    }
    
    init() {
        
    }
}
