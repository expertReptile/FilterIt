//
//  CollectionViewController.swift
//  FilterIt
//
//  Created by Pearce on 12/20/16.
//  Copyright © 2016 Angel soriano. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
    let pic = UIImage()
    var filterArr = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 1...10 {
            let aRand = CGFloat(arc4random_uniform(191) + 5)
            let radRand = (aRand / 100.0) * CGFloat.pi
            let tempImg = CIImage(image: pic)
            let tempFilter = CIFilter(name: "CIHueAdjust")
            tempFilter?.setDefaults()
            tempFilter?.setValue(tempImg, forKey: "inputImage")
            tempFilter?.setValue(CGFloat(radRand), forKey: "inputAngle")
            let filteredImg = tempFilter?.value(forKey: "outputImage") as! CIImage
            let filteredUIImage = UIImage(cgImage: CIContext(options: nil).createCGImage(filteredImg, from: filteredImg.extent)!)
            filterArr.append(filteredUIImage)
         }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {return 1}


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {return 10}

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FilterCell
        cell.imageCell?.image = pic
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "fullView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fullView" {
            let indexPaths = self.collectionView!.indexPathsForSelectedItems!
            let indexPath = indexPaths[0] as IndexPath
            let vc = segue.destination as! FilteredController
            vc.filteredImage.image = self.filterArr[indexPath.row]
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}