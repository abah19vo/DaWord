
//
//  HighScoreViewController.swift
//  DaWord Test
//
//  Created by Ahmad Adnan Abdullah on 2020-12-07.
//

import UIKit
import CoreData

class HighScoreViewController: UITableViewController {
    @IBOutlet weak var backgroundGradientView: UIView!
    var fetchResultsController: NSFetchedResultsController<PlayerScore>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "highscoreIdentifier")
        setupFetchedResultsController()

    }
    
    // MARK: - Table view data source
    private func setupFetchedResultsController(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<PlayerScore>(entityName: "PlayerScore")
        let scoreSort = NSSortDescriptor(key: "score", ascending: false)
        request.sortDescriptors = [scoreSort]
        fetchResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        do{
            try fetchResultsController.performFetch()
        }catch{
            fatalError("failed to initialize fetchResultsController")
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return fetchResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetchResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    
    @IBAction func goToMainMenu(_ sender:Any){
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "highscoreIdentifier", for: indexPath)

        // Configure the cell...
        let gameResult = fetchResultsController.object(at: indexPath)
        var player = gameResult.name ?? "Player"
        var location = gameResult.location ?? "Unknown Location"
        if location.count == 0{
            location = "Unknown Location"
        }
        if gameResult.name?.count == 0{
            player = "Player"
        }
        
        cell.textLabel?.text = "     \(player)     |     \(gameResult.score)P     |     \(location)"
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
