//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by manuel  castro  on 9/12/22.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var releaseDatelabel: UILabel!
    
    var movie: [String:Any]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //print(movie["title"])
        
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        synopsisLabel.text =  movie["overview"] as? String
        synopsisLabel.sizeToFit()
        let releaseDate =  movie["release_date"] as! String
        releaseDatelabel.text = "Released: " + releaseDate
        releaseDatelabel.sizeToFit()
        
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseURL+posterPath)
        
        posterView.af.setImage(withURL: posterUrl!)
        
        let baseURLbackdrop = "https://image.tmdb.org/t/p/w1280"
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: baseURLbackdrop+backdropPath)
        
        backdropView.af.setImage(withURL: backdropUrl!)
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
