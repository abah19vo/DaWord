//
//  GameView.swift
//  DaWord Test
//
//  Created by Ivin Benjamin on 2020-11-16.
//

import UIKit
import AudioToolbox
import CoreData


class GameView: UIViewController {

    @IBOutlet weak var backgroundGradientView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var wordInput: UITextField!
    @IBOutlet weak var letterLable: UILabel!
    @IBOutlet weak var categoryLable: UILabel!
    @IBOutlet weak var PointCounter: UILabel!

    var roundContent = Round()
     
    override func  viewWillAppear(_ animated: Bool) {
        if roundContent.category == 0{
            categoryLable.text = "|  Human:"
  
        }else if roundContent.category == 1{
            categoryLable.text = "|  Animal:"
            
        }else{
            categoryLable.text = "|  Cities"
            
        }
        
        letterLable.text = roundContent.letter[roundContent.letterNumber]
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = roundContent.finalName
        wordInput.delegate = self
        PointCounter.text = "\(String(describing: roundContent.points))P"
      
        
        self.navigationController?.isNavigationBarHidden = true
        
        wordInput.becomeFirstResponder()
        
        roundContent.savedTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(UIMenuController.update), userInfo: nil, repeats: true)
        
    }
    
    override func viewDidDisappear(_ animated: Bool){
        roundContent.savedTimer?.invalidate()
    }
    
    
    
    @IBAction func goToMainMenu(_ sender:Any){
        navigationController?.popToRootViewController(animated: true)
    }
    

    
    //The Count Down
    @objc func update(){
        if (roundContent.count > 0){
            roundContent.count -= 1
            counterLabel.text = String(roundContent.count)
        }
        
        if (roundContent.count == 0){
            if roundContent.points > 0{
            saveResult()
            }
            roundContent.savedTimer?.invalidate()
            performSegue(withIdentifier: "goToHighScore", sender: nil)
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
            
        }
        if (roundContent.count == 10){
            counterLabel.textColor = UIColor.black
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        }
        
        
        
    //Gradient Colors
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = view.bounds
    gradientLayer.colors = [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).cgColor, UIColor(red: 252/255, green: 238/255, blue: 33/255, alpha: 1).cgColor]
    backgroundGradientView.layer.insertSublayer(gradientLayer, at: 0)
    }

    
        
    private func saveResult(){
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let managedOBjectContext = appdelegate.persistentContainer.viewContext
        
        if let result = NSEntityDescription.insertNewObject(forEntityName: "PlayerScore", into: managedOBjectContext) as? PlayerScore {
            result.location = roundContent.location
            result.name = roundContent.finalName
            result.score = Int32(roundContent.points)
            appdelegate.saveContext()
        }
    }
    
    private func checkIfContainsIN(Category : Question? ,letter : String ,theInput : String){
            guard roundContent.usedWord.contains(theInput) == false else {
               //warn the user about its used
               wordInput.backgroundColor = UIColor.red
               AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
               return
           }
           
           guard let list = Category?[letter] as? [String] else{
               return
           }
       
           if list.contains(theInput) {
               
               haveWon(theInput: theInput)
           }else{
               wordInput.backgroundColor = UIColor.red
               AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
           }
           
       }
       
   private func haveWon(theInput: String){
        roundContent.points += 5
        if roundContent.points == 250{
            roundContent.finalName = "🔥\(roundContent.finalName)🔥"
        }
        if roundContent.points == 500{
            roundContent.finalName =  "🚀\(roundContent.finalName)🚀"
        }
        if roundContent.points == 1000{
            roundContent.finalName =  "🏅\(roundContent.finalName)🏅"
        }
    
        if roundContent.category == 2{
            if roundContent.letterNumber == 25 {
                roundContent.letterNumber = 0
               
           }else{
            roundContent.letterNumber += 1
           }
       }
    
        if roundContent.category == 0{
            roundContent.category = 1
        }else if roundContent.category == 1{
            roundContent.category = 2
       }else{
            roundContent.category = 0
       }
        roundContent.usedWord.append(theInput)
       wordInput.backgroundColor = UIColor.systemGreen
       guard let nextGameView = storyboard?.instantiateViewController(withIdentifier: "GameView") as? GameView else {
           return
       }
        nextGameView.roundContent = roundContent
        nextGameView.roundContent.count = 40
        
       
       navigationController?.pushViewController(nextGameView, animated: true)
       
   }
   
}

   extension GameView: UITextFieldDelegate {
       
       func textFieldDidEndEditing(_ textField: UITextField){
           guard let answer = textField.text else{
               return
           }
           
        if roundContent.category == 0{
            checkIfContainsIN(Category : roundContent.HumanList, letter: roundContent.letter[roundContent.letterNumber], theInput: answer)
               
        }else if roundContent.category == 1{
            checkIfContainsIN(Category : roundContent.AnimalList, letter: roundContent.letter[roundContent.letterNumber], theInput: answer)
               
           }else {
            checkIfContainsIN(Category : roundContent.CitiesList, letter: roundContent.letter[roundContent.letterNumber], theInput: answer)
        
           }
        }
       
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder()
           return true
       }
       
       
   }
