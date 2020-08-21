//
//  Helper_Extentions.swift
//  virtualTourist
//
//  Created by A Abdullah on 8/09/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func showALert(title : String , message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.view.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{ (action) in
            
            alert.dismiss(animated: true, completion: nil)
            
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //This function help to update ui
   
}
