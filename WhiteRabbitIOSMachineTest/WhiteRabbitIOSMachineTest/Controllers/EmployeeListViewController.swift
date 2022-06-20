//
//  EmployeeListViewController.swift
//  WhiteRabbitIOSMachineTest
//
//  Created by AkashSArjun on 20/06/22.
//

import UIKit
import CoreData
import Kingfisher

class EmployeeListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblEmployeeList: UITableView!
    
    var employeeDataModel = [EmployeeDirectoryModel]()
    var filterData = [EmployeeDirectoryModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchEmployeeData()
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension EmployeeListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(employeeDataModel.count)
//        return employeeDataModel.count
        return filterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TblEmployeeListCell", for: indexPath) as! TblEmployeeListCell
    
//        let imageURL = URL(string: employeeDataModel[indexPath.row].profileImage) ?? nil
//        cell.imgProfile.kf.setImage(with: imageURL)
//        cell.lblName.text = employeeDataModel[indexPath.row].name
//        cell.lblCompanyName.text = employeeDataModel[indexPath.row].company
//        return cell
        
        let imageURL = URL(string: filterData[indexPath.row].profileImage) ?? nil
        cell.imgProfile.kf.setImage(with: imageURL)
        cell.lblName.text = filterData[indexPath.row].name
        cell.lblCompanyName.text = filterData[indexPath.row].company
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TblEmployeeListCell", for: indexPath) as! TblEmployeeListCell
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmployeeDetailsViewController") as! EmployeeDetailsViewController
        vc.employeeDataModel = employeeDataModel[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

//MARK: - UISearchBarDelegate
extension EmployeeListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filterData = []
        
        if searchText == ""
        {
            filterData = employeeDataModel
        }
        
        for word in employeeDataModel {
            
            if word.name.uppercased().contains(searchText.uppercased()) || word.email.uppercased().contains(searchText.uppercased()) {
                filterData.append(word)
            }
        }
        self.tblEmployeeList.reloadData()
    }
}


//MARK: - Cell Class
class TblEmployeeListCell: UITableViewCell {
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCompanyName: UILabel!
}

//MARK: - CoreData
extension EmployeeListViewController {
    
    private func fetchEmployeeData() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EmployeeDirectoryStorage")
        
        do {
            
            let context = Context.context
            let employeeData = try context.fetch(fetchRequest)
            employeeDataModel.removeAll()
            
            for data in employeeData {
                
                let fetchedData = data as! EmployeeDirectoryStorage
                
                employeeDataModel.append(
                    EmployeeDirectoryModel(name: fetchedData.name ?? "",
                                           username: fetchedData.username ?? "",
                                           email: fetchedData.email ?? "",
                                           profileImage: fetchedData.profileImage ?? "",
                                           address: fetchedData.address ?? "",
                                           phone: fetchedData.phone ?? "",
                                           website: fetchedData.website ?? "",
                                           company: fetchedData.company ?? "")
                )
            }
            
            filterData = employeeDataModel
            tblEmployeeList.delegate = self
            tblEmployeeList.dataSource = self
            tblEmployeeList.reloadData()
            
        } catch let err {
            print(err)
        }
    }
}





