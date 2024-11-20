//
//  extensions.swift
//  e-commerce
//
//  Created by KhaleD HuSsien on 26/01/2024.
//

import UIKit

// MARK: - UiView Extension
extension UIView{
    func makeViewCircle(){
        self.layer.cornerRadius = self.frame.height/2
    }
    func setUpLayers(){
        self.layer.cornerRadius = 20
        self.layer.shadowColor = UIColor.systemOrange.cgColor
        self.layer.shadowRadius = 7
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    func setCustomLayerForView(raduis:CGFloat,color: CGColor){
        self.layer.cornerRadius = raduis
        self.layer.shadowColor = color
        self.layer.shadowRadius = 7
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    func setUpLayerForCell(color: CGColor = UIColor.systemOrange.cgColor){
        self.layer.cornerRadius = 10
        self.layer.shadowColor = color
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    // MARK: -  rounded corner
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11,*){
            var cornerMask = CACornerMask()
            if corners.contains(.topLeft){
                cornerMask.insert(.layerMinXMinYCorner)
            }
            if corners.contains(.topRight){
                cornerMask.insert(.layerMaxXMinYCorner)
            }
            if corners.contains(.bottomLeft){
                cornerMask.insert(.layerMinXMaxYCorner)
            }
            
            if corners.contains(.bottomRight){
                cornerMask.insert(.layerMaxXMaxYCorner)
            }
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = cornerMask
        }else{
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            
            self.layer.mask = maskLayer
        }
        
    }
    // MARK: - corners only
    func setCorners(corner: CGFloat = 15){
        self.layer.cornerRadius = corner
    }
    // MARK: - make shadow
    func setUpShadoww(shadowColor: CGColor = UIColor.systemYellow.cgColor){
        self.layer.cornerRadius = 0
        self.layer.shadowColor = shadowColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.backgroundColor = .white
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.3
        let shadowSize: CGFloat = 10
                let height = self.bounds.height
                let width = self.bounds.width
                let contactRect = CGRect(x: -shadowSize,
                                         y: height - (shadowSize * 0.4),
                                         width: width + shadowSize * 2,
                                         height: shadowSize)

                self.layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
    }
    // load view from nib
    func loadViewFromNib(nibName: String)-> UIView?{
        let nib = UINib(nibName: nibName, bundle: Bundle(for: type(of: self)))
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
}

