//
//  HomeViewController.swift
//  YouTube
//
//  Created by Kamal Harariya on 3/15/18.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit

let ChannelCellIdentifier       = "ChannelCellIdentifier"
let SearchListIdentifier        = "SearchListIdentifier"

let apiKey = "AIzaSyBItlwR5qfUj2NGbgPchD8L1OwLYXtfySU"
let initialPartOfUrl = "https://www.googleapis.com/youtube/v3/"
let maxResult = 10
let rowHeight: CGFloat = 175.0


class HomeViewController: UIViewController {

    /// Holds the list of search results.
    var channelList: Array<ChannelResultItem> = []
    
    /// Collection View.
    @IBOutlet weak var videoCollectionView: UICollectionView!
    
    /// Activity Indicator view.
    @IBOutlet weak var indicatorView: UIActivityIndicatorView! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoCollectionView.backgroundColor = UIColor.homeBackgroundViewColor
        
        /// Make service call to get the default search list.
        getChannelResponse()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension HomeViewController {
    
    func getChannelResponse() {
        let channels = ["Apple", "Microsoft", "yahoo", "UberWorldwide"]
        for _channel in channels {
            getListOfChannels(_channel)
        }
    }
    func getListOfChannels(_ channelName: String) {
        let urlString = "\(initialPartOfUrl)channels?part=contentDetails,snippet&forUsername=\(channelName)&maxResults=\(maxResult)&key=\(apiKey)"
        
        // Create url for default search list.
        indicatorView.startAnimating()
        
        NetworkManager.shared.getdataFrom(urlString: urlString) {[weak self] (response, error) in
            guard let strongSelf = self else { return }
            
            strongSelf.hideIndicator()
            
            guard let _response = response else {
                // Handle errors/no response.
                return
            }

            if error == .noError {
                if let items = _response["items"] as? Array<Dictionary<String, Any>> {
                    var newItems = [ChannelResultItem]()
                    for item in items {
                        let resultItem = ChannelResultItem(withResult: item)
                        newItems.append(resultItem)
                    }
                    
                    strongSelf.insertItems(newItems)
                }
            } else {
                // Handle errors/no response.
            }
        }
    }
    
    func insertItems(_ newItems: Array<ChannelResultItem>) {
        DispatchQueue.main.async {
            var indexPaths = [IndexPath]()
            for item in newItems {
                self.channelList.append(item)
                let indexPath = IndexPath(row: self.channelList.count - 1, section: 0)
                indexPaths.append(indexPath)
            }
            self.videoCollectionView.insertItems(at: indexPaths)
        }
    }
    
    func hideIndicator() {
        DispatchQueue.main.async {
            self.indicatorView.stopAnimating()
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: rowHeight)
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return channelList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let _searchedItem = channelList[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChannelCellIdentifier, for: indexPath) as? ChannelListTableViewCell {
            cell.titleLabel.text = _searchedItem.title.capitalized
            cell.descriptionLabel.text = _searchedItem.channelDescription
            cell.publishDateLabel.text = _searchedItem.publishDate.longFormatDateString()
            cell.backgroundColor = UIColor.white
            
            // Get the image data at background.
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
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Push the page view controller.
        if let searchedListController = self.storyboard?.instantiateViewController(withIdentifier: SearchListIdentifier) as? PlayListViewController {
            let selectedItem = channelList[indexPath.row]
            searchedListController.channelId = selectedItem.id
            self.navigationController?.pushViewController(searchedListController, animated: true)
        }
    }
}


