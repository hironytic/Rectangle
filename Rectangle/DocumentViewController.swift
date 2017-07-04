//
//  DocumentViewController.swift
//  Rectangle
//
//  Created by ichi on 2017/07/02.
//  Copyright © 2017 Hironytic. All rights reserved.
//

import UIKit

class DocumentViewController: UIViewController {
    
    var document: Document?
    
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var widthSlider: UISlider!
    @IBOutlet weak var heightSlider: UISlider!
    
    override func viewDidLoad() {
        previewView.layer.borderColor = UIColor.black.cgColor
        previewView.layer.borderWidth = 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Access the document
        document?.open(completionHandler: { (success) in
            if success {
                // Display the content of the document, e.g.:
                self.navigationItem.title = self.document?.fileURL.lastPathComponent
                
                let width = self.document?.rectangle.width ?? 0
                let height = self.document?.rectangle.height ?? 0
                self.widthSlider.value = width
                self.heightSlider.value = height
                self.previewView.bounds = CGRect(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height))
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        })
    }
    
    @IBAction func dismissDocumentViewController() {
        dismiss(animated: true) {
            self.document?.close(completionHandler: nil)
        }
    }
    @IBAction func widthSliderValueChanged(_ sender: Any) {
        let width = self.widthSlider.value
        document?.rectangle.width = width
        previewView.bounds = CGRect(x: 0, y: 0, width: CGFloat(width), height: previewView.bounds.size.height)
        document?.updateChangeCount(.done)
    }
    @IBAction func heightSliderValueChanged(_ sender: Any) {
        let height = self.heightSlider.value
        document?.rectangle.height = height
        previewView.bounds = CGRect(x: 0, y: 0, width: previewView.bounds.size.width, height: CGFloat(height))
        document?.updateChangeCount(.done)
    }
}
