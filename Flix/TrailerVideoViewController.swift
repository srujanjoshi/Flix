//
//  TrailerVideoView.swift
//  Flix
//
//  Created by Srujan Joshi on 3/5/22.
//

import UIKit
import WebKit

class TrailerVideoViewController: UIViewController {
    
    var movie_id: Int?

    let webView = WKWebView()
    
    var videos = [[String:Any]]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie_id ?? 510)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                    self.videos = dataDictionary["results"] as! [[String:Any]]
                    print(self.videos)
                    // TODO: Reload your table view data
                    self.view.addSubview(self.webView)

                    guard let video_url = URL(string: "https://www.youtube.com/embed/\(self.videos[0]["key"] ?? "dQw4w9WgXcQ")") else {
                        return
                    }
                    self.webView.load(URLRequest(url:video_url))
                    //self.collectionView.reloadData()
             }
        }
        task.resume()
        

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        webView.frame = view.bounds
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
