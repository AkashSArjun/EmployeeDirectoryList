//
//  EmployeeDirectoryResources.swift
//  WhiteRabbitIOSMachineTest
//
//  Created by AkashSArjun on 20/06/22.
//

import Foundation
import UIKit

struct EmployeeDirectoryResources {
    
    func employeeDirectoryData(viewController: UIViewController, completionHandler: @escaping (_ result: [EmployeeDirectoryData]?) -> ()) {
        
        var employeeDirectory = [EmployeeDirectoryData]()
                        
        let url = "http://www.mocky.io/v2/5d565297300000680030a986"
        
        NetworkHandler.sharedNetworkInstance.networkCall(url, method: .get, params: nil, controller: viewController) { [self] responseData, isSuccess, responseMessage in
            if isSuccess {
                
                if let respData = responseData {
                    
                    do {
                        let decoder = JSONDecoder()
                        employeeDirectory = [try decoder.decode(EmployeeDirectoryData.self, from: respData)]
                        print(employeeDirectory)
                        
                        completionHandler(employeeDirectory)
                        
                    } catch let err {
                        completionHandler(nil)
                        print(err)
                    }
                }
                
            } else {
                completionHandler(nil)
                print("Failed")
            }
        }
    }
}
