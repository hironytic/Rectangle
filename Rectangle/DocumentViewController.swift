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
    
    @IBOutlet weak var widthSlider: UISlider!
    @IBOutlet weak var heightSlider: UISlider!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Access the document
        document?.open(completionHandler: { (success) in
            if success {
                // Display the content of the document, e.g.:
                self.navigationItem.title = self.document?.fileURL.lastPathComponent
                self.widthSlider.value = self.document?.rectangle.width ?? 0.0
                self.heightSlider.value = self.document?.rectangle.height ?? 0.0
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
        self.document?.rectangle.width = self.widthSlider.value
        self.document?.updateChangeCount(.done)
    }
    @IBAction func heightSliderValueChanged(_ sender: Any) {
        self.document?.rectangle.height = self.heightSlider.value
        self.document?.updateChangeCount(.done)
    }
}
