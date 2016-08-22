//
//  CollectionViewController.swift
//  MemeMe
//
//  Created by JING ZHANG on 8/19/16.
//  Copyright © 2016 JING ZHANG. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]!
    
     override func viewWillAppear(animated: Bool) {
       super.viewWillAppear(animated)
        
        tabBarController?.tabBar.hidden = false
        
        //Retrieve memes object from App Delegate
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
        
        //Reload collection view
        collectionView!.reloadData()
        
        adjustFlowLayout(self.view.frame.size)
}
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator:UIViewControllerTransitionCoordinator) {
        adjustFlowLayout(size)
    }
    
    //Colleciton flow Layout
    func adjustFlowLayout(size:CGSize){
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }

    // Show Meme Editor Screen
    @IBAction func showEditorView(sender: AnyObject) {
        
        let editorView = self.storyboard!.instantiateViewControllerWithIdentifier("EditorViewController") as! EditorViewController
        navigationController!.pushViewController(editorView, animated: true)
        
    }
    // MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // Dequeue collection cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ColletionViewCell", forIndexPath: indexPath) as! CollectionViewCell
        let meme = memes[indexPath.row]
        
        //set the image
        cell.memeImageView?.image = meme.memedImage
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // Instantiate meme detail view controller
        let memeDetailView = storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        // Pass the selected meme information
        memeDetailView.selectedMeme = memes[indexPath.row]
        memeDetailView.selectedIndex = indexPath.row
        // Display meme detail view
        navigationController!.pushViewController(memeDetailView, animated: true)
    }
    
}
