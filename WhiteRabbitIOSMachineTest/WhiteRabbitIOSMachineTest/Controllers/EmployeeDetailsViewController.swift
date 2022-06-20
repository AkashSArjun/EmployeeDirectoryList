//
//  EmployeeDetailsViewController.swift
//  WhiteRabbitIOSMachineTest
//
//  Created by AkashSArjun on 20/06/22.
//

import UIKit
import Kingfisher

class EmployeeDetailsViewController: UIViewController {
    
    var employeeDataModel: EmployeeDirectoryModel?
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblWeb: UILabel!
    @IBOutlet weak var lblCompany: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let imageURL = URL(string: employeeDataModel?.profileImage ?? "")
        imgProfile.kf.setImage(with: imageURL)
        lblName.text = employeeDataModel?.name ?? ""
        lblUserName.text = employeeDataModel?.username ?? ""
        lblEmail.text = employeeDataModel?.email ?? ""
        lblAddress.text = employeeDataModel?.address ?? ""
        lblPhone.text = employeeDataModel?.phone ?? ""
        lblWeb.text = employeeDataModel?.website ?? ""
        lblCompany.text = employeeDataModel?.company ?? ""
        uiDecoration()
    }
    
    private func uiDecoration() {
        imgProfile.layer.cornerRadius = imgProfile.frame.height / 2
    }
}
