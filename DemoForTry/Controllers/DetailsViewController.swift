//
//  DetailsViewController.swift
//  DemoForTry
//
//  Created by Hagar Diab on 3/20/20.
//  Copyright © 2020 Hagar Diab. All rights reserved.
//

import UIKit
import Cosmos
import TinyConstraints

class DetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
//    var segmentedControl: UISegmentedControl{
//        let sc = UISegmentedControl(items: ["TrailersTableView","ReviewsTableView"])
//        return sc
//    }()
//
//    let tableView = UITableView(frame: .zero ,style: .plain)
    

    @IBOutlet weak var favImgBtn: UIButton!
    
 
    @IBOutlet var detailsController: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var posterImageView: UIImageView!
    // @IBOutlet weak var trailerCell: UITableViewCell!
    
    @IBAction func switchViewAction(_ sender: UISegmentedControl) {
        
        
        
        switch sender.selectedSegmentIndex{
        case 0:
            detailsController.bringSubviewToFront(tableView)
            //change tableview content
            break
        case 1:
            detailsController.bringSubviewToFront(tableView)
            //change table view content
            break
        default:
            break
        }
        
        
    }
    
    
    lazy var cosmosView:CosmosView = {
        var view = CosmosView()
        view.settings.updateOnTouch = false
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.settings.filledImage = UIImage(named: "RatingStarFilled")?.withRenderingMode(.alwaysOriginal)
        view.settings.emptyImage = UIImage(named: "RatingStarEmpty")?.withRenderingMode(.alwaysOriginal)
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        view.addSubview(cosmosView)
        setUpCosmosLayout()
        //cosmosView.
    }
    
    @IBAction func favBtn(_ sender: UIButton) {
         
     if favImgBtn.currentBackgroundImage == UIImage(named: "favorite-Empty.png"){
         
         favImgBtn.setBackgroundImage(UIImage(named: "favorite-Filled.png"), for: UIControl.State.normal)
         
     }else{
         favImgBtn.setBackgroundImage(UIImage(named: "favorite-Empty.png"), for: UIControl.State.normal)
         }
     
     }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
        //return moviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text="fixed text"
        
        
        return cell
        //return moviesArray.count
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func setUpCosmosLayout(){
        cosmosView.topAnchor.constraint(equalTo: view.topAnchor , constant: 100).isActive = true
        
        cosmosView.leftAnchor.constraint(equalTo: view.leftAnchor , constant: 200).isActive = true
    }

}
