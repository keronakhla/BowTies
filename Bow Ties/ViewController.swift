//
//  ViewController.swift
//  Bow Ties
//
//  Created by Pietro Rea on 7/12/15.
//  Copyright © 2015 Razeware. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
  
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var timesWornLabel: UILabel!
  @IBOutlet weak var lastWornLabel: UILabel!
  @IBOutlet weak var favoriteLabel: UILabel!

  var managedContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //1
        insertSampleData()
        
        //2 
        let request = NSFetchRequest(entityName: "Bowtie")
        let firstTitle = segmentedControl.titleForSegmentAtIndex(0)
        
        request.predicate = NSPredicate(format: "SearchKey == %@", firstTitle!)
        
        do {
            let results = try managedContext.executeFetchRequest(request) as! [Bowtie]
            //4
            populate(results.first!)
        } catch let error as NSError {
            print("Could not fetch\(error), \(error.userInfo)")
        }
    }
    
    
  
    // Insert sample data

    func insertSampleData() {
        let fetchRequest = NSFetchRequest(entityName: "Bowtie")
        
        fetchRequest.predicate = NSPredicate(format: "SearchKey != nil")
        
        let count = managedContext.countForFetchRequest(fetchRequest, error: nil)
        
    if count > 0 {return}
    
    let path = NSBundle.mainBundle().pathForResource("SampleData", ofType: "plist")
    let dataArray = NSArray(contentsOfFile: path!)!
    
    for dict: AnyObject in dataArray {
        let entity = NSEntityDescription.entityForName("Bowtie", inManagedObjectContext: managedContext)
        let bowtie = Bowtie(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        let btDict = dict as! NSDictionary
        
        bowtie.name = btDict["name"] as? String
        bowtie.searchKey = btDict["searchKey"] as? String
        bowtie.rating = btDict["rating"] as? NSNumber
        let tintColorDict = btDict["tintColor"] as? NSDictionary
        bowtie.tintColor = colorFromDict(tintColorDict!)
        
        let imageName = btDict["imageName"] as? String
        let image = UIImage(named:imageName!)
        let photoData = UIImagePNGRepresentation(image!)
        bowtie.photoData = photoData
        
        bowtie.lastWorn = btDict["lastWorn"] as? NSDate
        bowtie.timesWorn = btDict["timesWorn"] as? NSNumber
        bowtie.isFavorite = btDict["isFavorite"] as? NSNumber
    }
    
    }
    
    func colorFromDict(dict: NSDictionary) -> UIColor{
        let red = dict["red"] as! NSNumber
        let green = dict["green"] as! NSNumber
        let blue = dict["blue"] as! NSNumber
        
        let color = UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/225.0, blue: CGFloat(blue)/225.0, alpha: 1)
        
        return color
    }
    
    
  
  @IBAction func segmentedControl(control: UISegmentedControl) {
    
  }
  
  @IBAction func wear(sender: AnyObject) {
    
  }
  
  @IBAction func rate(sender: AnyObject) {
    
  }
}

