//
//  Extenstions+UiimageView.swift
//  NewsTask
//
//  Created by KhaleD HuSsien on 01/11/2024.
//


import UIKit

extension UIImageView{
    func makeCircle(){
        self.layer.cornerRadius = self.frame.height/2
    }
}
var imageCaches = NSCache<AnyObject,AnyObject>()
extension UIImageView{
    func loadDataUsingCacheWithUrlString(urlString: String){
        if let chachImage = imageCaches.object(forKey: urlString as NSString)as? UIImage{
            self.image = chachImage
            return
        }
        guard let url = NSURL(string: urlString) as? URL else{return}
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if error != nil{
                print(error?.localizedDescription ?? "error in fetch url image")
                return
            }
            DispatchQueue.main.async {
                if let downloadImage = UIImage(data: data!){
                    imageCaches.setObject(downloadImage, forKey: urlString as NSString)
                    self.image = downloadImage
                }
            }
        }.resume()
    }
}
