//
//  DetailViewController.swift
//  CDP_MovieApp
//
//  Created by Simran Rajendra Bhavsar on 8/2/22.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImg: UIImageView!
    @IBOutlet weak var txtOverview: UITextView!
    @IBOutlet weak var txtDate: UILabel!
    @IBOutlet weak var txtTitle: UILabel!
    
    var movie : Result?
    override func viewDidLoad() {
        super.viewDidLoad()
        txtTitle.text = movie?.title
        txtDate.text = movie?.releaseDate
        txtOverview.text = movie?.overview
        // Do any additional setup after loading the view.
    }

}
