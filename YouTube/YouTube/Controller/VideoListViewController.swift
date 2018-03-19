//
//  VideoListViewController.swift
//  YouTube
//
//  Created by Kamal Harariya on 3/18/18.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit

let VideoCellIdentifier = "VideoCellIdentifier"

class VideoListViewController: UIViewController {
    
    /// Selected Item.
    var selectedItem: SearchedResultItem?
    
    /// Channel id. can be nil too.
    var playListId: String?

    /// List view that will show the results.
    @IBOutlet weak var videoListView: UITableView!

    var videoList: Array<VideoResultItem> = []
    
    /// Next Page Token.
    var nextPageToken: String?
    
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    /// An integer that will hold the last visible scrolled row index.
    private var lastScrolledRowIndex: Int = 0 {
        willSet {
            self.lastScrolledRowIndex = newValue
            
            if self.lastScrolledRowIndex >= self.videoList.count - 2 {
                if let _nextToken = self.nextPageToken {
                    // This is just to make sure that there is a request made for next set of response. We can make it better.
                    if !activityIndicatorView.isAnimating {
                        showIndicator()
                        guard let _playListId = playListId else { return }
                        
                        let urlString = "\(initialPartOfUrl)playlistItems?pageToken=\(_nextToken)&part=snippet&playlistId=\(_playListId)&maxResults=\(maxResult)&key=\(apiKey)"
                        getDataFromService(urlString)
                    }
                }
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Video list"
        
        guard let _playListId = playListId else { return }
        let urlString = "\(initialPartOfUrl)playlistItems?part=snippet&playlistId=%20\(_playListId)&maxResults=\(maxResult)&key=\(apiKey)"
        getDataFromService(urlString)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let _selectRows = videoListView.indexPathForSelectedRow {
            self.videoListView.deselectRow(at: _selectRows, animated: true)
        }
    }
    
    // MARK: - Show/Hide Activity indicator.
    private func showIndicator() {
        bottomLayoutConstraint.constant = 60.0
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
    }
    
    private func hideIndicator() {
        DispatchQueue.main.async {
            self.bottomLayoutConstraint.constant = 0.0
            self.activityIndicatorView.isHidden = true
            self.activityIndicatorView.stopAnimating()
        }
    }
}

extension VideoListViewController {

    func getDataFromService(_ urlString: String) {
        
        
        NetworkManager.shared.getdataFrom(urlString: urlString) {[weak self] (response, error) in
            // Handle errors/no response.
            guard let _response = response else { return }
            
            guard let strongSelf = self else { return }
            strongSelf.hideIndicator()

            if error == .noError {
                if let _nextToken = _response["nextPageToken"] as? String {
                    strongSelf.nextPageToken = _nextToken
                } else {
                    strongSelf.nextPageToken = nil
                }
                
                if let items = _response["items"] as? Array<Dictionary<String, Any>> {
                    var newItems = [VideoResultItem]()
                    for item in items {
                        let resultItem = VideoResultItem(withResult: item)
                        newItems.append(resultItem)
                    }
                    
                    strongSelf.updateListView(withItems: newItems)
                } else {
                    // Handle this case too.
                }
            } else {
                // Handle errors/no response.
            }
        }
    }
    
    func updateListView(withItems newItems: Array<VideoResultItem>) {
        DispatchQueue.main.async {
            var indexPaths = [IndexPath]()
            for item in newItems {
                self.videoList.append(item)
                let indexPath = IndexPath(row: self.videoList.count - 1, section: 0)
                indexPaths.append(indexPath)
            }
            
            self.videoListView.insertRows(at: indexPaths, with: .fade)
        }
    }
}

extension VideoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: UITableViewDatasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        lastScrolledRowIndex = indexPath.row
        let _currentItem = videoList[indexPath.row]
        if let videoCell = tableView.dequeueReusableCell(withIdentifier: VideoCellIdentifier, for: indexPath) as? VideoTableViewCell {
            
            videoCell.titleLabel.text = _currentItem.title
            videoCell.descriptionLabel.text = _currentItem.listDescription
            videoCell.publishLabel.text = _currentItem.publishDateString.longFormatDateString()
            
            NetworkManager.shared.downloadImage(fromUrl: _currentItem.imageUrlString, withHandler: { (data, error) in
                if let _imageData = data {
                    DispatchQueue.main.async {
                        videoCell.cellImageView.image = UIImage(data: _imageData)
                    }
                }
            })
            return videoCell
        }
        
        // Something went wrong, Returning empty cell.
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // I dont like showing empty header (without title and not sure what title to be shown here.)
        return 0.50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let _selectedItem = videoList[indexPath.row]
        let playerViewController = PlayerViewController()
        if let _resource = _selectedItem.resourceId, let _videoId = _resource["videoId"] as? String {
            playerViewController.videoIdentifier = _videoId
        }
        self.navigationController?.pushViewController(playerViewController, animated: true)
    }
}
