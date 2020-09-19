//
//  LoginViewController.swift
//  NIBM COVID19
//
//  Created by mulitha on 9/14/20.
//  Copyright © 2020 mulitha. All rights reserved.
//

import UIKit
import Firebase
import MapKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    private let locationManager = LocationHandler.shared.locationManager

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        enableLocationServices()
        
        
//        let leftButton =  UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(self.dismissAction))
//        navigationItem.leftBarButtonItem = leftButton
        
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        
        guard let email = emailText.text else{return}
        guard let pwd = passwordText.text else{return}

        Auth.auth().signIn(withEmail: email, password: pwd) { (result, error) in
            if let error = error {
                print("Faild to register user with error \(error)")
                return
            }
            LocationHandler.shared.syncUserLocation()
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    
    
    
    @IBAction func onSignUp(_ sender: Any) {
                
        let mianStorybord = UIStoryboard(name:"Main", bundle: Bundle.main)
        guard let signUpVC = mianStorybord.instantiateViewController(withIdentifier: "SignUpViewController") as?
            SignUpViewController else{
                return
        }
//        let navigation = UINavigationController(pushView: mainNavigationVC)
//        navigation.modalPresentationStyle = .fullScreen
//        self.present(navigation, animated: true, completion: nil)

       self.navigationController!.pushViewController(signUpVC, animated: true)
        
    }
    
    
    
    
     @objc func dismissAction(){
         self.dismiss(animated: true, completion: nil)
     }
    
}



extension LoginViewController {

func enableLocationServices() {
    
    switch CLLocationManager.authorizationStatus() {
    case .notDetermined:
        locationManager?.requestWhenInUseAuthorization()
    case .restricted, .denied:
        break
    case .authorizedWhenInUse:
        locationManager?.requestAlwaysAuthorization()
    case .authorizedAlways:
        locationManager?.startUpdatingLocation()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
    default:
        break
    }
}
}
