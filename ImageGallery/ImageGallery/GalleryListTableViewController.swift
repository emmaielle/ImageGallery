//
//  GalleryListTableViewController.swift
//  ImageGallery
//
//  Created by Owner on 1/22/19.
//  Copyright © 2019 LittlePanda. All rights reserved.
//

import UIKit

class GalleryListTableViewController: UITableViewController {



    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GalleryName", for: indexPath)

        // Configure the cell...
        switch(Int(indexPath.row)%4)
        {
        case 0:
            cell.textLabel?.text = "Moii"
            cell.detailTextLabel?.text = "Likes fernet before noon"
        case 1:
            cell.textLabel?.text = "Kevin"
            cell.detailTextLabel?.text = "Loves peacock pants any time of day"
        case 2:
            cell.textLabel?.text = "Kim"
            cell.detailTextLabel?.text = "Usualy needs to pee"
        case 3:
            cell.textLabel?.text = "Stanley"
            cell.detailTextLabel?.text = "Is missed by all"
        default:
            break
        }

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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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


    //MARK: - Navigation

    //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         //Get the new view controller using segue.destination.
         //Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            switch identifier {
            case "CollectionSegue":
                if let cell = sender as? UITableViewCell,
                    //let indexPath = tableView.indexPath(for: cell),
                    let imageGalleryVC = segue.destination as? ImageGalleryViewController {
                        let text = cell.detailTextLabel?.text ?? "no value"
                        imageGalleryVC.collectionLabelText = text
                        print("yes! \(text)")
                }
            default:
                break
            }
        }
    }


}
