//  ViewController.swift
//  genicMap
//  Created by okumura reo on 2018/06/04.
//  Copyright © 2018年 reo. All rights reserved.
import UIKit

class ListViewController: UIViewController, UICollectionViewDataSource {
  @IBOutlet weak var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    return (appDelegate.instagramData?.data.filter { d in
      switch d.location {
      case .some: return true
      case .none: return false
      }
      }.count)!
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell:UICollectionViewCell =
      collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                         for: indexPath)
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let imageView = cell.contentView.viewWithTag(1) as! UIImageView
    if let data = try? Data(contentsOf: URL(string:(appDelegate.instagramData?.data[indexPath.row].images.standard_resolution.url)!)!
      ) {
      imageView.image = UIImage(data: data)
    }
    return cell
  }
  
  

  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
