//
//  TableViewController.swift
//  MemeMe
//
//  Created by JING ZHANG on 8/20/16.
//  Copyright © 2016 JING ZHANG. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController{

    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    var cancelButton: UIBarButtonItem!
    
    var memes: [Meme]!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.hidden = false
        
        //// Retrieve memes data from App Delegate
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
        
        cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancelAction")
        
        tableView!.reloadData()
        
        if memes.count > 0 {
            // Enable edit button if meme exists
            editButton.enabled = true
        } else {
            // Disable edit button if no memes
            editButton.enabled = false
        }
        
    }
    
    //Show Editor View Controller
    @IBAction func showEditorView(sender: AnyObject) {
        
        let editorView = storyboard!.instantiateViewControllerWithIdentifier("EditorViewController") as! EditorViewController
        navigationController!.pushViewController(editorView, animated: true)
    }
    
    @IBAction func editAction(sender: AnyObject) {
        
        tableView.setEditing(true, animated: true)
        updateBarButtonState()
        
    }
    
    func cancelAction() {
        
        tableView.setEditing(false, animated: true)
        updateBarButtonState()
    }
    
    func updateBarButtonState() {
        // If in editing mode, show delete and cancel button
        if tableView.editing {
            navigationItem.leftBarButtonItem = cancelButton
            navigationItem.rightBarButtonItem = nil
        } else {
            navigationItem.rightBarButtonItem = addButton
            navigationItem.leftBarButtonItem = editButton
        }
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell") as! TableViewCell
        let meme = memes[indexPath.row]
        
        // Set the name and image
        cell.titleLabel?.text = "\(meme.topText) \(meme.bottomText)"
        cell.memeImage?.image = meme.memedImage
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Instantiate DetailViewController
        let memeDetailView = storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        
        // Pass selected meme
        memeDetailView.selectedMeme = memes[indexPath.row]
        memeDetailView.selectedIndex = indexPath.row
        
        // Show detail view controller
        navigationController!.pushViewController(memeDetailView, animated: true)
    }
   
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            // Remove the deleted meme from memes array
            memes.removeAtIndex(indexPath.row)
            
            // Update shared memes
            (UIApplication.sharedApplication().delegate as! AppDelegate).memes = memes
            
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        
    }

    override func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if memes.count == 0 {
            // End editing session if no more meme
            cancelAction()
        }

    }
}