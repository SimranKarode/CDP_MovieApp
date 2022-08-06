//
//  TableViewCell.swift
//  CDP_MovieApp
//
//  Created by Simran Rajendra Bhavsar on 8/1/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtRelease: UILabel!
    @IBOutlet weak var mImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        mImage.layer.cornerRadius = mImage.bounds.width / 8
        mImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func onBind(data:Result){
        txtName.text = data.title
        txtRelease.text = data.releaseDate
        
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://image.tmdb.org/t/p/w500\(data.posterPath)")!)){
            (data, req, error) in
            
            do{
                let datas = try data
                DispatchQueue.main.async {
                    self.mImage.image = UIImage(data: datas!)
                    
                }
            }catch{
                print("Error")
            }
        }.resume()
    }
    
}
