//
//  InfoView.swift
//  DaWord Test
//
//  Created by Ivin Benjamin on 2020-12-06.
//

import UIKit

class InfoView: UIViewController {
    
    @IBOutlet weak var backgroundGradientView: UIView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [#colorLiteral(red: 0.7626823783, green: 0.2160563469, blue: 0.3910846114, alpha: 1).cgColor, UIColor(red: 29/255, green: 38/255, blue: 113/255, alpha: 1).cgColor]
        gradientLayer.shouldRasterize = true
        backgroundGradientView.layer.insertSublayer(gradientLayer, at: 0)

        
        
        
    }
    
    @IBAction func goToMainMenu(_ sender:Any){
        navigationController?.popToRootViewController(animated: true)
    }

}
