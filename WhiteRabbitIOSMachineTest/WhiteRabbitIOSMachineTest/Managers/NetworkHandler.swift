//
//  NetworkHandler.swift
//  WhiteRabbitIOSMachineTest
//
//  Created by AkashSArjun on 20/06/22.
//

import Foundation
import Alamofire

class NetworkHandler {
    static let sharedNetworkInstance = NetworkHandler()
    
    enum RequestMethod {
        case post, get
    }
    
    func networkCall(_ url: String, method: RequestMethod, params: [String:Any]?, controller: UIViewController, completionHandler: @escaping (_ result: Data?, _ status: Bool, _ message: String) -> ()) {
        
        
        let url = URL(string: url)!
        var status = Bool()
        var message = String()
        var httpMethod: HTTPMethod?
        
        switch method {
        case .post:
            httpMethod = .post
        case .get:
            httpMethod = .get
        default:
            break
        }
    
        AF.request(url, method: httpMethod!, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            print(response.value as Any)
            
            switch response.result {
            case .success(let responseData):
                print(responseData)
                
                completionHandler(response.data, true, "Success")
                
            case .failure(let networkErr):
                switch networkErr {
                case .responseSerializationFailed(reason: _):
                    message = "Something went wrong"
                case .sessionTaskFailed(error: let err):
                    message = err.localizedDescription
                default:
                    message = "Something went wrong"
                }
                completionHandler(nil, false, message)

                break
            }
        }
    }
}
