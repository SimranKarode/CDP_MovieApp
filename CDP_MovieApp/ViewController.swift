//
//  ViewController.swift
//  CDP_MovieApp
//
//  Created by Simran Rajendra Bhavsar on 8/1/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mTable : UITableView!
    var dataList = [Result]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mTable.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=3a30e32a52a6f28ad4920973131cd31e&language=en-US&page=1")!)){ (data,req,error) in
            
            do{
                let reslut = try JSONDecoder().decode(Movies.self, from: data!)
                DispatchQueue.main.async {
                    self.dataList = reslut.results
                    self.mTable.reloadData()
                }
            }catch{
                
            }
        }.resume()
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataList.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
    cell.onBind(data: dataList[indexPath.row])
    return cell
}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let details : DetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
    navigationController?.pushViewController(details, animated: true)
    
    URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://image.tmdb.org/t/p/w500\(dataList[indexPath.row].posterPath)")!)){
        (data, req, error) in
        
        guard
            let data = data
        else { return }
        
        DispatchQueue.main.async {
            details.detailImg.image = UIImage(data: data)
        }
                
    }.resume()
    
    DispatchQueue.main.async {
        details.txtTitle.text = self.dataList[indexPath.row].title
        details.txtDate.text = self.dataList[indexPath.row].releaseDate
        details.txtOverview.text = self.dataList[indexPath.row].overview
    }
    }

}
