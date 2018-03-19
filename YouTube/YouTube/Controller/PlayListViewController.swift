//
//  PlayListViewController.swift
//  YouTube
//
//  Created by Kamal Harariya on 3/17/18.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit

let SearchedListIdentifier = "SearchedListIdentifier"
let SearchedListCellIdentifier  = "SearchedListCellIdentifier"

let PlayListCellIdentifier = "PlayListCellIdentifier"

class PlayListViewController: UIViewController {
    
    var playList: Array<PlayListResultItem> = []
    
    /// Selected Item.
    var selectedItem: SearchedResultItem?
    
    /// Channel id. can be nil too.
    var channelId: String?
    
    /// Next Page Token.
    var nextPageToken: String?
    
    /// List view that will show the results.
    @IBOutlet weak var searchedListView: UITableView!
    
    /// Activity indicator view
    var indicatorViewHeight: CGFloat = 40.0
    
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    /// An integer that will hold the last visible scrolled row index.
    private var lastScrolledRowIndex: Int = 0 {
        willSet {
            self.lastScrolledRowIndex = newValue
            
            if self.lastScrolledRowIndex >= self.playList.count - 2 {
                if !activityIndicatorView.isAnimating {
                    if let _nextToken = self.nextPageToken {
                        guard let _channelId = channelId else { return }
                        showIndicator()
                        let urlString = "\(initialPartOfUrl)playlists?pageToken=\(_nextToken)&part=snippet&channelId=\(_channelId)&maxResults=\(maxResult)&key=\(apiKey)"
                        getDataFromService(withUrl: urlString)
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.homeBackgroundViewColor
        self.navigationItem.title = "Play List"
        getDataFromServer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let _selectRows = searchedListView.indexPathForSelectedRow {
            self.searchedListView.deselectRow(at: _selectRows, animated: true)
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

extension PlayListViewController {
    func getDataFromServer() {
        
        showIndicator()
        
        guard let _channelId = channelId else { return }

        let urlString = "\(initialPartOfUrl)playlists?part=snippet&channelId=\(_channelId)&maxResults=\(maxResult)&key=\(apiKey)"
        getDataFromService(withUrl: urlString)
    }
    
    func getDataFromService(withUrl urlString: String) {

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
                    var newItems = [PlayListResultItem]()
                    for item in items {
                        let resultItem = PlayListResultItem(withResult: item)
                        newItems.append(resultItem)
                    }
                    
                    strongSelf.updateListView(withItems: newItems)
                }
            } else {
                // Handle errors/no response.
            }
        }
    }
    
    func updateListView(withItems newItems: Array<PlayListResultItem>) {
        DispatchQueue.main.async {
            var indexPaths = [IndexPath]()
            for item in newItems {
                self.playList.append(item)
                let indexPath = IndexPath(row: self.playList.count - 1, section: 0)
                indexPaths.append(indexPath)
            }
            
            self.searchedListView.insertRows(at: indexPaths, with: .none)
        }
    }
}

extension PlayListViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: UITableViewDatasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let _searchedItem = playList[indexPath.row]
        lastScrolledRowIndex = indexPath.row
        if let cell = tableView.dequeueReusableCell(withIdentifier: PlayListCellIdentifier, for: indexPath) as? PlayListTableViewCell {
            cell.titleLabel.text = _searchedItem.title
            cell.publishDateLabel.text = _searchedItem.publishDateString.longFormatDateString()
            
            NetworkManager.shared.downloadImage(fromUrl: _searchedItem.imageUrlString, withHandler: { (data, error) in
                if let _imageData = data {
                    DispatchQueue.main.async {
                        cell.thumbnailImageView.image = UIImage(data: _imageData)
                    }
                }
            })
            return cell
        }
        
        // This should never get executed.
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
        return 150.0    // Change it in some way that will return height based on cell.
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let _selectedItem = playList[indexPath.row]
        if let videoListVC = self.storyboard?.instantiateViewController(withIdentifier: "VideoListVCIdentifier") as? VideoListViewController {
            videoListVC.playListId = _selectedItem.playListId
            self.navigationController?.pushViewController(videoListVC, animated: true)
        }
    }
}


