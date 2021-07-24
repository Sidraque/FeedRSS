//
//  FeedTableViewController.swift
//  FeedRSS
//
//  Created by Sidraque on 23/07/21.
//

import UIKit

class FeedTableViewController: UITableViewController, MWFeedParserDelegate{

    
    var feedItems = [MWFeedItem]()
    
    func request(){
        let url = URL(string: "https://g1.globo.com/rss/g1/carros/")
        let feedParser = MWFeedParser(feedURL: url)
        feedParser?.delegate = self
        feedParser?.parse()
    
    }
    
    
    // MARK: - FEED PARSER DELEGATE
    
    func feedParserDidStart(_ parser: MWFeedParser!) {
        feedItems = [MWFeedItem]()
    }
    
    func feedParserDidFinish(_ parser: MWFeedParser!) {
        self.tableView.reloadData()
    }
    
    func feedParser(_ parser: MWFeedParser!, didParseFeedInfo info: MWFeedInfo!) {
        print(info!)
        self.title = info.title
    }
    
    func feedParser(_ parser: MWFeedParser!, didParseFeedItem item: MWFeedItem!) {
        feedItems.append(item)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        request()
    }
    
    

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return the number of rows
        return feedItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        
        let item = feedItems[indexPath.row] as MWFeedItem
        
        cell.textLabel?.text = item.title

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = feedItems[indexPath.row] as MWFeedItem
        
        let webBrowser = KINWebBrowserViewController()
        let url = URL(string: item.link)
    
        
        webBrowser.load(url)
        
        
        self.navigationController?.pushViewController(webBrowser, animated: true)
    }

}
