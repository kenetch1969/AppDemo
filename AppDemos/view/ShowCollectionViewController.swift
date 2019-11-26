//
//  ShowCollectionViewController.swift
//  AppDemos
//
//  Created by Juan Gerardo Cruz on 11/21/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
// https://benoitpasquier.com/optimise-uicollectionview-swift/
// https://www.raywenderlich.com/3987-custom-collection-view-layout/lessons/2
// https://medium.com/@superpeteblaze/ios-scaling-carousel-component-in-swift-8f263b1e391

import UIKit

struct MemeModel {
    let image: UIImage
    let name: String
}

class MemeCell: UICollectionViewCell {

    @IBOutlet var image: UIImageView!
    @IBOutlet var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with model: MemeModel) {
        image.image = model.image
        name.text = model.name
    }
}


private let reuseIdentifier = "MemeCell"

class ShowCollectionViewController: UICollectionViewController {
    
    
    
    let data: [MemeModel] = [MemeModel(image: #imageLiteral(resourceName: "car01") , name: "Car01"),
                             MemeModel(image: #imageLiteral(resourceName: "car02"), name: "Car02"),
    MemeModel(image: #imageLiteral(resourceName: "car03"), name: "Car03"),
    MemeModel(image: #imageLiteral(resourceName: "car04"), name: "Car04"),
    MemeModel(image: #imageLiteral(resourceName: "car05"), name: "Car05")]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UINib.init(nibName: "MemeCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 179, height: 182)
            layout.minimumInteritemSpacing = 5
            layout.minimumLineSpacing = 5
            layout.headerReferenceSize = CGSize(width: 0, height: 40)
            layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            self.collectionView.collectionViewLayout = layout
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 100, height: 100)
//        layout.minimumInteritemSpacing = 8
//        layout.minimumLineSpacing = 8
//        layout.headerReferenceSize = CGSize(width: 0, height: 40)
//        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
//        self.collectionView.collectionViewLayout = layout
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return data.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeCell
    
        // Configure the cell
        cell.configure(with: data[indexPath.row])
    
        return cell
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


//extension ShowCollectionViewController: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = (self.view.frame.size.width - 20) / 3 //some width
//        let height = width * 1.5 //ratio
//        return CGSize(width: width, height: height)
//    }
//}
