//
//  DetailViewController.swift
//  MemeMe
//
//  Created by JING ZHANG on 8/20/16.
//  Copyright © 2016 JING ZHANG. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var memeUIImageView: UIImageView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    var selectedMeme: Meme!
    var selectedIndex: Int!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        memeUIImageView.image = selectedMeme.memedImage
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
    
    //Action when edit button is tapped
    @IBAction func editAction(sender: AnyObject) {
        
        // Instantiate meme editor view
        let editorView = storyboard!.instantiateViewControllerWithIdentifier("EditorViewController") as! EditorViewController
        
        // Pass parameter
        editorView.editMeme = selectedMeme
        editorView.memeIndex = selectedIndex
        
        // Show meme editor
        tabBarController?.tabBar.hidden = false
        navigationController?.pushViewController(editorView, animated: true)
    }
    
    // Action when delete button is tapped
    @IBAction func deleteAction(sender: AnyObject) {
        
        // Delete the memes for the selected index from app delegate
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.removeAtIndex(selectedIndex)
        
        // Navigate back to previous view
    navigationController?.popViewControllerAnimated(true)
    
    }

}
