//
//  HomeVC.swift
//  Mindteck
//
//  Created by HYTML00001 on 28/02/24.
//

import UIKit

class HomeVC: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var tableview: UITableView!
    lazy var searchBar:UISearchBar = UISearchBar()
    var dataConstants = DataConstants()
    var fliterArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.sectionHeaderHeight = 0
        tableview.sectionFooterHeight = 0
        
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        dataConstants.updatedListElements.removeAll()
        fliterArray.removeAll()
        dataConstants.updatedListElements = dataConstants.responseElements[0]
        fliterArray = dataConstants.responseElements[0]
        print(fliterArray)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let results = fliterArray.filter({ $0.hasPrefix(searchText)})
        print("searchText...", "\(results)")
        dataConstants.updatedListElements.removeAll()
        dataConstants.updatedListElements = results
        self.tableview.reloadData()
    }
 
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : dataConstants.updatedListElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeVCTBVCell", for: indexPath as IndexPath) as! HomeVCTBVCell
            cell.delgate = self
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath as IndexPath) as! ListTableViewCell
            cell.listImge.image =  UIImage(named: self.dataConstants.updatedListElements[indexPath.row])
            cell.nameLbl.text = self.dataConstants.updatedListElements[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 250 : 60
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if  section == 0 {
            return 0
        }else{
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            return nil
        }
        let sectionV = UIView.init(frame: CGRect(x: 0, y: -20, width: tableView.frame.width, height: 80) )
        searchBar.frame.origin.x = sectionV.frame.origin.x
        searchBar.frame = sectionV.frame
        sectionV.addSubview(searchBar)
        sectionV.bringSubviewToFront(searchBar)
        return sectionV
    }
    
}

extension HomeVC: updteArrayElementsDelegate{
    func realoadTableView(index: Int) {
        dataConstants.updatedListElements.removeAll()
        fliterArray = dataConstants.responseElements[index]
        dataConstants.updatedListElements = dataConstants.responseElements[index]
        self.tableview.reloadData()
    }
}

