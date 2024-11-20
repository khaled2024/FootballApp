//
//  AlertRepresenter.swift
//  NewsTask
//
//  Created by KhaleD HuSsien on 02/11/2024.
//

import UIKit
class AlertRepresenter: ObservableObject {
    static  func showAlert(with newTitlee : String,mess: String? = "",vc: UIViewController,action: @escaping (UIAlertAction)->Void){
        let alert = UIAlertController(title: newTitlee, message: mess, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: action))
        vc.present(alert, animated: true)
    }
}
