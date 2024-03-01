//
//  HomeVCTBVCell.swift
//  Mindteck
//
//  Created by HYTML00001 on 28/02/24.
//

import UIKit

protocol updteArrayElementsDelegate {
    func realoadTableView(index :Int)
}
class HomeVCTBVCell: UITableViewCell {
    @IBOutlet var pageControlSwipe: UIPageControl!
    
    var dataConstants = DataConstants()
    var imagesArray = ["Cars","Bikes","Buildings"]
     var delgate: updteArrayElementsDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pageControlSwipe.currentPage = 0
        pageControlSwipe.numberOfPages =  imagesArray.count
        pageControlSwipe.currentPageIndicatorTintColor = .black
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension HomeVCTBVCell: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if imagesArray.count > 0{
            collectionView.reloadData()
            return imagesArray.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if imagesArray.count > 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageScrollCVCell", for: indexPath) as! ImageScrollCVCell
            cell.scrollImge.image =  UIImage(named: imagesArray[indexPath.row])

            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width - 5, height: 240)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 5
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let currentPage = Int((scrollView.contentOffset.x + pageWidth  / 2) / pageWidth)
        pageControlSwipe.currentPage = currentPage
        pageControlSwipe.currentPageIndicatorTintColor = .black
        
        print("currentPage--","\(currentPage)")
        dataConstants.updatedListElements.removeAll()
        dataConstants.updatedListElements = dataConstants.responseElements[currentPage]
        print(dataConstants.updatedListElements )
        delgate?.realoadTableView(index: currentPage)
    }
    
}
