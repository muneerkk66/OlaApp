//
//  TaxiListVC.swift
//  OlaApp
//
//  Created by Muneer KK on 22/11/19.
//  Copyright © 2019 Muneer KK. All rights reserved.
//

import UIKit
private typealias TaxiListVCTableViewMethods = TaxiListVC
private typealias Constants = TaxiListVC
class TaxiListVC: UIViewController {
    @IBOutlet weak var taxiListTableView: UITableView!
    var taxiListVM = TaxiListVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK:- Loading saved data from Coredata
        showLoadedTaxiDetails()
        
        //MARK:- Fetch the latest taxi details from Server using API calls
        loadAllTaxiDetails()
        
        
        
    }
    //MARK:- This will load the Taxi details from Coredata
    fileprivate func showLoadedTaxiDetails() {
        taxiListVM.taxiList = taxiListVM.loadTaxiList()
    }
     //MARK:- API CALL to fetch the latest Taxi details
    fileprivate func loadAllTaxiDetails(){
        taxiListVM.fetchTaxiDetails(onCompletion: { [weak self](errorObject) -> () in
            guard let weakSelf = self else {
                return
            }
            if let _ = errorObject {
                // Show the default Error Alert here.
            }
            else {
                weakSelf.showLoadedTaxiDetails()
            }
        })
    }


}

//MARK: - Tableview Methods
extension TaxiListVCTableViewMethods:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taxiCell =  taxiListTableView.dequeueReusableCell(withIdentifier:TableViewCellIdentifier.taxiCellID.rawValue) as! TaxiTableViewCell
        taxiCell.configureCell(taxiListVM.taxiList[indexPath.row])
        return taxiCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.rowHeight
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return taxiListVM.taxiList.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
      
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
}
//MARK: - Tableview Constants
extension Constants {
    struct Constants {
        static let rowHeight:CGFloat = 60.0
    }
}
