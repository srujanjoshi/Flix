//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by Srujan Joshi on 3/4/22.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    var movie : [String:Any]?

    @IBAction func tappedPoster(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "goToVideoPage", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = movie?["title"] as? String
        synopsisLabel.text = movie?["overview"] as? String
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie?["poster_path"] as! String
        let posterUrl = URL(string:baseUrl + posterPath)
        posterView.af.setImage(withURL: posterUrl!)
        
        let backdropPath = movie?["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath )
        backdropView.af.setImage(withURL: backdropUrl!)

        // Do any additional setup after loading the view.
    }
    



    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let trailerVideoViewController = segue.destination as! TrailerVideoViewController
        let movie_id = movie!["id"] as! Int
        print(movie_id)
        trailerVideoViewController.movie_id = movie_id
    }


}
