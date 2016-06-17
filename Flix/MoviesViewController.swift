//
//  MoviesViewController.swift
//  Flix
//
//  Created by Juan Luis Herrero Estrada on 6/15/16.
//  Copyright © 2016 Juan Luis Herrero Estrada. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    
    // ----- global variables -----------
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var movies: [NSDictionary]?
    var endpoint: String!
    var filteredData: [NSDictionary]?
    

    // --- viewDidLoad function ------------
override func viewDidLoad() {
    
    super.viewDidLoad()
    let refreshControl = UIRefreshControl()
    
    
    refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
    
    tableView.insertSubview(refreshControl, atIndex: 0)
    
    tableView.dataSource = self
    tableView.delegate = self
    searchBar.delegate = self
    
    let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    let url = NSURL(string: "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")
    let request = NSURLRequest(
        URL: url!,
        cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
        timeoutInterval: 10)
    
    let session = NSURLSession(
        configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
        delegate: nil,
        delegateQueue: NSOperationQueue.mainQueue()
    )
    MBProgressHUD.showHUDAddedTo(self.view, animated: true)
    let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,completionHandler: { (dataOrNil, response, error) in
                                         if let data = dataOrNil {
                                            if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                                                data, options:[]) as? NSDictionary {
                                                print("response: \(responseDictionary)")
                                                
                            self.movies = responseDictionary["results"] as? [NSDictionary]
                            self.filteredData = self.movies
                            self.tableView.reloadData()
                                                                        }
                                                                }
        MBProgressHUD.hideHUDForView(self.view, animated: true)
    })
    task.resume()
}
    
    
    // this function is in charge of refreshing the table
    func refreshControlAction(refreshControl: UIRefreshControl) {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        
        let myRequest = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(myRequest,
                                        completionHandler: { (data, response, error) in
                                // ... Use the new data to update the data source ...
                                // Reload the tableView now that there is new data
                                        self.tableView.reloadData()
                                // Tell the refreshControl to stop spinning
                                       refreshControl.endRefreshing()
        });
        task.resume()
        }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if let filteredData = filteredData{
         return filteredData.count
        } else {
         return 0
        }
    
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        
        let movie = filteredData![indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        
         cell.titleLabel.text = title
         cell.overviewLabel.text = overview
        
        if let posterPath = movie["poster_path"] as? String {
            let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
            let posterUrl = NSURL(string: posterBaseUrl + posterPath)
            cell.posterView.setImageWithURL(posterUrl!)
        }
        else {
            // No poster image. Can either set to nil (no image) or a default movie poster image
            // that you include as an asset
            cell.posterView.image = nil
        }
            return cell
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let movie = movies![indexPath!.row]
        let detailViewController = segue.destinationViewController as! DetailViewController
        detailViewController.movie = movie
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    // --------------- Search Bar Method ---------------------------------
    // This method updates filteredData based on the text in the Search Box
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            filteredData = movies
        } else {
            // The user has entered text into the search box
            // Use the filter method to iterate over all items in the data array
            // For each item, return true if the item should be included and false if the
            // item should NOT be included
            filteredData = movies!.filter({(dataItem: NSDictionary) -> Bool in
                let title = dataItem["title"] as! String
                
                if title.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil {
                    return true
                } else {
                    return false
                }
            })
        }
        tableView.reloadData()
    } // end of searchBar method

}
