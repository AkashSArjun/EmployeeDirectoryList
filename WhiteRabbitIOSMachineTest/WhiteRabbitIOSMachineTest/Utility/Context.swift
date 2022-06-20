//
//  Context.swift
//  WhiteRabbitIOSMachineTest
//
//  Created by AkashSArjun on 20/06/22.
//

import Foundation
import CoreData
import UIKit

class Context {
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}
