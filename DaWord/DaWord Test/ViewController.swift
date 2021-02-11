//
//  ViewController.swift
//  DaWord Test
//
//  Created by Ivin Benjamin on 2020-11-12.
//

import UIKit
import AVFoundation
import CoreLocation



class ViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var backgroundGradientView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var GPS: UILabel!
    
    
   
    
    var audioPlayer = AVAudioPlayer()
    var savedMusicTimer : TimeInterval?
    var HumanList : Question?
    var AnimalList : Question?
    var CitiesList : Question?
    var manager = CLLocationManager()
    var lastLocation: CLLocation?
    var location:String?
    var nameText = ""
    
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTextField.delegate = self
        nameTextField.returnKeyType = .done

        // Gradient Colors
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).cgColor, UIColor(red: 252/255, green: 238/255, blue: 33/255, alpha: 1).cgColor]
        gradientLayer.shouldRasterize = true
        backgroundGradientView.layer.insertSublayer(gradientLayer, at: 0)

   
        
        // Music Player
        
        let url = Bundle.main.url(forResource: "AvengerSong", withExtension: "mp3")

        guard url != nil else {
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
            audioPlayer.prepareToPlay()
        } catch{
            print(error)
        }

    }

    //GPS Location
    override func viewDidAppear(_ animated: Bool){
            super.viewDidAppear(animated)

            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        HumanList = loadJsonList(jsonlist: "HumanFist")
        AnimalList = loadJsonList(jsonlist: "animalsList")
        CitiesList = loadJsonList(jsonlist: "CitiesList")
       
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations Locations: [CLLocation]){
        
    
        guard let first =  Locations.first else{
            return
        }
        lastLocation = first
        let geocoder = CLGeocoder()
        manager.stopUpdatingLocation()
        // Look up the location and pass it to the completion handler
        geocoder.reverseGeocodeLocation(first, completionHandler: { (placemarks, error) in
            if error == nil {
                let firstLocation = placemarks?[0]
                self.location = firstLocation?.country
                self.GPS.text = firstLocation?.country
                self.GPS.textColor = UIColor.white
            }
        })
    }
    
    // Music Player
    @IBAction func  Play(_ sender: Any){
        audioPlayer.numberOfLoops = 0
            if audioPlayer.isPlaying{
                savedMusicTimer = audioPlayer.currentTime
                audioPlayer.pause()
            }else{
                
                audioPlayer.play()
            }
    }
    // set the input name as nameText
    @IBAction func done(_ sender:Any){
        self.nameText = nameTextField.text!
    }
    
    // send Username to the game menu
    func textFieldShouldReturn(_ nameTextField: UITextField) -> Bool {
           self.view.endEditing(true)
           return false
       }

    
    
    private func loadJsonList(jsonlist: String) -> Question?{
        var structQuestion: Question?
            do{
                guard let url = Bundle.main.url(forResource:  jsonlist, withExtension: "json") else {
                    return structQuestion
                }
                guard let data = try? Data(contentsOf: url) else{
                    return structQuestion
                }

                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                structQuestion = try decoder.decode(Question.self, from: data)
        }
        catch{
            print(error)
         
        }
        return structQuestion

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let vc = segue.destination as? GameView else{
            return
        }
        vc.roundContent.finalName = self.nameText
        vc.roundContent.AnimalList = AnimalList
        vc.roundContent.HumanList = HumanList
        vc.roundContent.CitiesList = CitiesList
        vc.roundContent.location = location ?? ""
        
    }
    
    
    
    
    
    
    
    
 
}
    




