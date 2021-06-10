//
//  ViewController.swift
//  TabBarLayout
//
//  Created by softech on 01/06/2021.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var indicator: UIView!
    @IBOutlet weak var tab2: UIButton!
    @IBOutlet weak var tab1: UIButton!
    @IBOutlet var collectionViewCity : UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    private var halfScreenSize : CGFloat?
    
    
    override func viewDidLoad() {
        
        self.collectionViewCity.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        
        self.collectionViewCity.register(UINib.init(nibName: "CollectionViewCell2", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell2")
        
        let screenSize = UIScreen.main.bounds
        halfScreenSize = screenSize.width / 2
    }
    
    
    
    @IBAction func tab1(_ sender: Any) {
       
        collectionViewCity.scrollToItem(at: IndexPath(item: 0, section: 0),
                                        at: .left, animated: true)
        
        moveIndicatorLeft()
    }
    @IBAction func tab2(_ sender: UIButton) {
        
        self.collectionViewCity.isPagingEnabled = false
        collectionViewCity.scrollToItem(at: IndexPath(item: 1, section: 0),
                                        at: .right, animated: true)
        self.collectionViewCity.isPagingEnabled = true
        
        moveIndicatorRight()
        
    }
    
    func moveIndicatorRight() {
        
        tab2.setTitleColor(.systemPurple, for: .normal)
        tab1.setTitleColor(.black, for: .normal)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.indicator.frame.origin = CGPoint(x:self.halfScreenSize! , y: self.indicator.frame.origin.y)
            
        }, completion: { (value: Bool) in
            
        })
    }
    
    func moveIndicatorLeft() {
        
        tab2.setTitleColor(.black, for: .normal)
        tab1.setTitleColor(.systemPurple, for: .normal)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.indicator.frame.origin = CGPoint(x:0 , y: self.indicator.frame.origin.y)
            
        }, completion: { (value: Bool) in
            
        })
    }
    
}


extension ViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cellContacts = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as!  CollectionViewCell
            
            
            return cellContacts
        }
        else if indexPath.row == 1 {
            let cellContacts = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell2", for: indexPath) as!  CollectionViewCell2
            
            
            return cellContacts
        }
        else{
            let cellNews = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            
            return cellNews
        }
        
    }
    
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            
            pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
            
            if(pageControl.currentPage == 0){
                
                moveIndicatorLeft()
            }
            else{
                
                moveIndicatorRight()
            }
        
    }
    
    
}
