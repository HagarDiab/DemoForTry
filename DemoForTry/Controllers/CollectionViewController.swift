//
//  CollectionViewController.swift
//  DemoForTry
//
//  Created by Hagar Diab on 3/19/20.
//  Copyright © 2020 Hagar Diab. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

protocol CustomLayoutDelegate: class {
  func collectionView(_ collectionView: UICollectionView, sizeOfPhotoAtIndexPath indexPath: IndexPath) -> CGSize
}


private let reuseIdentifier = "Cell"
private let segue = "viewMovieDetailsSegue"

class CollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout{
    
//    private let leftAndRightPadding: CGFloat = 8.0
//    private let numberOfItemsPerRow: CGFloat = 2.0
//    private let heightAdjsment: CGFloat = 30.0
    
    
    weak var delegate: CustomLayoutDelegate!

    var moviesArray:[Movies]=Array()

     override func viewDidLoad() {
         super.viewDidLoad()
        

        
         getMovies(sortby: "")
     }


     override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
         return 1
     }
     func collectionView(_ collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                         sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfColumns: CGFloat = 2
        let width = collectionView.frame.size.width
        let xInsets: CGFloat = 10
        let cellSpacing: CGFloat = 5
        
        
             return CGSize(width: (width / numberOfColumns) - (xInsets + cellSpacing), height: (width / numberOfColumns) - (xInsets + cellSpacing))
         
     }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let clickedImage = moviesArray[indexPath.row].image
        
        performSegue(withIdentifier: segue , sender: clickedImage)
    }
    
    func setUpCollectionView() {
        
        collectionView.delegate=self
        collectionView.dataSource=self
    }
    
    



     override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return moviesArray.count
     }
    
//    override func prepare(for segue: UIStoryboaredSegue , sender: Any?){
//        let image= sender as! moviesArray
//        
//        if segue.identifier == ViewSegue{
//            
//        }
//    }

     override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCell
        
     let imgView:UIImageView = cell.viewWithTag(100) as! UIImageView
        
    imgView.sd_setImage(with: URL(string: moviesArray[indexPath.row].image!
          ), placeholderImage: UIImage(named: "img.jpg"))

         return cell
     }
    
    /*
     override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! GalleryCollectionViewCell

         cell.galleryImage.image = images[indexPath.row]

         return cell
     }
     */

     func getMovies(sortby:String) {
         var url:URL?=nil
         if sortby == ""{
              url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=b1b4dff13bd7f4d3012c38dab715678c")
             
         }else{
            url = URL(string: "https://api.themoviedb.org/3/movie/\(sortby)?api_key=b1b4dff13bd7f4d3012c38dab715678c")
             
         }
         
         
         
         var  movArr:[Movies] = Array()
            var dict:Dictionary<String,Any>?
         AF.request(url!).validate().responseJSON { response in
           print(response)
               
            let x = response.value
               if(response.response!.statusCode != 200){
               }
               print(x!)
               
               dict=x as? Dictionary<String,Any>
               
             if let result:NSArray = dict?["results"] as? NSArray{
               
               for item in result{
               
             if let d:Dictionary<String, Any> = item as? Dictionary<String, Any>{
                 let id = d["id"] as! Int
                 print("test ID \(id)")
             let title=d["title"] as? String ?? ""
             var poster_url:String = "https://image.tmdb.org/t/p/w500//"
              poster_url.append(d["poster_path"] as? String ?? "")
              print(poster_url)
               let reating=d["vote_average"] as? Float ?? 0.0
                 let relase_Year=d["release_date"] as? String ?? "Date unavailable"
                 print(relase_Year)
               let overview=d["overview"] as? String ?? "unavailable"
                                      
               
            movArr.append(Movies(Id: String(id), Title: title, Image: poster_url, Rating: reating, ReleaseDate: relase_Year,  Overview: overview))
                 
                 print("Appended")
                 
                 }
               
               
                               }
             }

             self.moviesArray=movArr
             self.collectionView.reloadData()
             
         }
     }
}


