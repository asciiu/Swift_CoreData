//
//  CoreDataViewController.swift
//  Tutorial_CoreData
//
//  Created by LV426 on 7/7/14.
//  Copyright (c) 2014 Indiow LLC. All rights reserved.
//

import UIKit
import CoreData

class CoreDataViewController: UIViewController {

    @IBOutlet var name: UITextField
    @IBOutlet var address: UITextField
    @IBOutlet var phone: UITextField
    @IBOutlet var status: UILabel
    
    @IBAction func saveData(sender: AnyObject) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        let context: NSManagedObjectContext = appDelegate.managedObjectContext
        let newContact: NSManagedObject = NSEntityDescription.insertNewObjectForEntityForName("Contacts", inManagedObjectContext: context) as NSManagedObject
        
        newContact.setValue(self.name.text, forKey: "name")
        newContact.setValue(self.address.text, forKey: "address")
        newContact.setValue(self.phone.text, forKey: "phone")
        
        self.name.text = ""
        self.address.text = ""
        self.phone.text = ""
        
        var error: NSError?
        context.save(&error)
        
        self.status.text = "Contact saved"
    }
    
    @IBAction func findContact(sender: AnyObject) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        let context: NSManagedObjectContext = appDelegate.managedObjectContext
        
        let entityDesc: NSEntityDescription = NSEntityDescription.entityForName("Contacts", inManagedObjectContext: context)
        
        let request: NSFetchRequest = NSFetchRequest()
        request.entity = entityDesc
        
        let pred: NSPredicate = NSPredicate(format:"(name = %@)", self.name.text)
        request.predicate = pred
        
        var matches: NSManagedObject?
        var error: NSError?

        let objects: AnyObject[] = context.executeFetchRequest(request, error: &error)
        
        if objects.count == 0 {
            self.status.text = "No matches"
        } else {
            matches = objects[0] as? NSManagedObject
            self.address.text = matches!.valueForKey("address") as String
            self.phone.text = matches!.valueForKey("phone") as String
            self.status.text  = String(objects.count) + " matches found"
        }
    }
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
