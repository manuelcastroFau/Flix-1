//
//  ViewController.swift
//  Flix
//
//  Created by manuel  castro  on 9/5/22.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) ->
    Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = UITableViewCell()
        //cell.textLabel?.text = "row: \(indexPath.row)"
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        let movie =  movies[indexPath.row]
        let title =  movie["title"] as! String
        
        let synopsis = movie["overview"] as! String
        let releaseDate =  movie["release_date"] as! String
        
        
        
        //cell.textLabel?.text = title
        cell.titleLabel.text = title
        cell.synopsisLabel.text = synopsis
        
        
        
        cell.yearLabel.text = "Released: " + releaseDate
        //https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg
        
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseURL+posterPath)
        
        cell.posterView.af.setImage(withURL: posterUrl!)
        
        return cell
    }
    
    
    
    //To create a dictionary
    var movies  = [[String:Any]]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        print("hello")
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 
                 print(dataDictionary)
                 self.movies  =  dataDictionary["results"] as! [[String:Any]]
                 
                 self.tableView.reloadData()
                 
                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data

             }
        }
        task.resume()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // get new view controller using segue.destination
        // Pass the selected object to the new view controller
        print("Loading the detail screen here")
        
        //find the selecte movie
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        
        let moview =  movies[indexPath.row]
        
        //pass the selected movie to the details view controller
        let detailsViewcontroller =  segue.destination as! MovieDetailsViewController
        detailsViewcontroller.movie = moview
        
        tableView.deselectRow(at: indexPath, animated: true)
    }


}

