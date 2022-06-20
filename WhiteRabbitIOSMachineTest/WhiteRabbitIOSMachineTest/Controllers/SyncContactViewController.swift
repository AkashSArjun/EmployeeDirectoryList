//
//  ViewController.swift
//  WhiteRabbitIOSMachineTest
//
//  Created by AkashSArjun on 20/06/22.
//

import UIKit
import CoreData

class SyncContactViewController: UIViewController {
    
    var employeeData = [EmployeeDirectoryData]()
    var employeeDataModel = [EmployeeDirectoryModel]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EmployeeDirectoryStorage")
        
        do {
            
            let context = Context.context
            let employeeData = try context.fetch(fetchRequest)
            
            if employeeData.count == 0 {
                
                employeeDirectory()
                
            } else {
                
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmployeeListViewController") as! EmployeeListViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        } catch let err {
            print(err)
        }
    }
    
    @IBAction func clickSyncData(_ sender: UIButton) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmployeeListViewController") as! EmployeeListViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Api call
extension SyncContactViewController {
    
    fileprivate func employeeDirectory() {
        
        let resource = EmployeeDirectoryResources()
        resource.employeeDirectoryData(viewController: self) { [self] result in
            
            if result != nil {
                employeeData = result!
                print(employeeData)
                
                for empData in employeeData[0] {
                    enterEmployeeData(employeeData: empData)
                }
            }
        }
    }
}

//MARK: - enter employee data
extension SyncContactViewController {
    
    private func enterEmployeeData(employeeData: EmployeeDirectoryDatum) {
        
        let context = Context.context
        let employeeDataEntity = NSEntityDescription.insertNewObject(forEntityName: "EmployeeDirectoryStorage", into: context)
        
            let name = employeeData.name
            let username = employeeData.username
            let email = employeeData.email
            let profileImage = employeeData.profileImage
            
            let fullAddress = "\(employeeData.address.street), \(employeeData.address.suite), \(employeeData.address.city), \(employeeData.address.zipcode)"
            let address = fullAddress
            let phone = employeeData.phone
            let website = employeeData.website
            
        let companyData = "\(employeeData.company?.name ?? ""), \(employeeData.company?.catchPhrase ?? ""), \(employeeData.company?.bs ?? "")"
            let company = companyData
            
            
            employeeDataEntity.setValue(name, forKey: "name")
            employeeDataEntity.setValue(username, forKey: "username")
            employeeDataEntity.setValue(email, forKey: "email")
            employeeDataEntity.setValue(profileImage, forKey: "profileImage")
            employeeDataEntity.setValue(address, forKey: "address")
            employeeDataEntity.setValue(phone, forKey: "phone")
            employeeDataEntity.setValue(website, forKey: "website")
            employeeDataEntity.setValue(company, forKey: "company")
            
            do {
                try context.save()
                
            } catch let err {
                print(err)
            }
        
        print(employeeDataEntity)
    }
}





