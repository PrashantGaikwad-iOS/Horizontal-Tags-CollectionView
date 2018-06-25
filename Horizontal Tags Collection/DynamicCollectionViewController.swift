//
//  DynamicCollectionViewController.swift
//  TestYourCodeHere
//
//  Created by Prashant G on 6/22/18.
//  Copyright © 2018 Left Right Mind. All rights reserved.
//

import UIKit

class DynamicCollectionViewController: UIViewController {
    
    @IBOutlet weak var arrowButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var bottomViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomView: UIView!
    
    var isArtsCollectionExpanded = false
    
    var selectedIndex = 0
    
    var tagNamesArray = [
        "animals",
        "birds",
        "food",
        "drink"
    ]
    
    var birdsArtsArray = [
        "bird",
        "bird2",
        "dove",
        "parrot",
        "bee"
    ]
    
    var foodArtsArray = [
        "apple",
        "carrot",
        "groceries",
        "hamburger",
        "orange",
        "strawberry",
        "tomato",
        "watermelon"
    ]
    
    var drinkArtsArray = [
        "can",
        "cocktail",
        "glass",
        "pint"
    ]
    
    
    var animalArtsArray = [
        "bear",
        "dog",
        "fox",
        "monkey",
        "penguin",
        "pig",
        "rat",
        "tiger",
        "whale"
    ]
    
    @IBOutlet weak var artsCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    fileprivate func closeOuterCollectionView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.arrowButton.setTitle(">", for: .normal)
            self.isArtsCollectionExpanded = false
            self.bottomViewWidthConstraint.constant = 193
            self.bottomView.updateConstraintsIfNeeded()
            self.collectionView.updateConstraintsIfNeeded()
            self.view.layoutIfNeeded()
        })
        
    }
    
    fileprivate func openOuterCOllectionView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.arrowButton.setTitle("<", for: .normal)
            self.isArtsCollectionExpanded = true
            self.bottomViewWidthConstraint.constant = self.view.frame.size.width - 200
            self.bottomView.updateConstraintsIfNeeded()
            self.collectionView.updateConstraintsIfNeeded()
            self.view.layoutIfNeeded()
        })
        
    }
    
    @IBAction func expandCollapseArtsCollectionAction(_ sender: Any) {
        if self.isArtsCollectionExpanded {
            self.closeOuterCollectionView()
        }
        else{
            self.openOuterCOllectionView()
        }
    }
    
    
    
    
}


//MARK:-
extension DynamicCollectionViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 101 {
            return tagNamesArray.count
        }
        else if collectionView.tag == 102 {
            
            if tagNamesArray[0] == "animals" {
                return animalArtsArray.count
            }
            else if tagNamesArray[0] == "birds" {
                return birdsArtsArray.count
            }
            else if tagNamesArray[0] == "food" {
                return foodArtsArray.count
            }
            else if tagNamesArray[0] == "drink" {
                return drinkArtsArray.count
            }
            else {
                return 0
            }
            
//            switch tagNamesArray[selectedIndex]  {
//            case "animals" : return animalArtsArray.count
//
//            case "birds" : return birdsArtsArray.count
//
//            case "food" : return foodArtsArray.count
//
//            case "drink" : return drinkArtsArray.count
//
//            default:
//                return 0
//            }
        }
        else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 101 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TagsCollectionViewCell
            cell.tagNameLabel.text = tagNamesArray[indexPath.row]
            return cell
        }
        else if collectionView.tag == 102 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "artsCell", for: indexPath) as! ArtsCollectionViewCell
            
            if tagNamesArray[0] == "animals" {
                cell.artsImageView.image = UIImage(named: animalArtsArray[indexPath.row])
            }
            else if tagNamesArray[0] == "birds" {
                cell.artsImageView.image = UIImage(named: birdsArtsArray[indexPath.row])
            }
            else if tagNamesArray[0] == "food" {
                cell.artsImageView.image = UIImage(named: foodArtsArray[indexPath.row])
            }
            else if tagNamesArray[0] == "drink" {
                cell.artsImageView.image = UIImage(named: drinkArtsArray[indexPath.row])
            }
            
            
//            switch tagNamesArray[selectedIndex] {
//            case "animals" :  cell.artsImageView.image = UIImage(named: animalArtsArray[indexPath.row])
//
//            case "birds" :  cell.artsImageView.image = UIImage(named: birdsArtsArray[indexPath.row])
//
//            case "food" :  cell.artsImageView.image = UIImage(named: foodArtsArray[indexPath.row])
//
//            case "drink" :  cell.artsImageView.image = UIImage(named: drinkArtsArray[indexPath.row])
//
//            default:
//                cell.artsImageView.image = UIImage(named: animalArtsArray[indexPath.row])
//            }
            
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TagsCollectionViewCell
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.tag == 101 {
            
            self.closeOuterCollectionView()
            
            //Swipe the first index value
            let tempValue = tagNamesArray[0]
            tagNamesArray[0] = tagNamesArray[indexPath.row]
            tagNamesArray[indexPath.row] = tempValue
            
            selectedIndex = indexPath.row
            
            artsCollectionView.reloadData()
            
            collectionView.reloadData()
            
            let indexPath = IndexPath(row: 0, section: 0)
            
            collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.left, animated: true)
            
            
        }
    }
    
}


















