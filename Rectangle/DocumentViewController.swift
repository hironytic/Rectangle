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
    
    @IBOutlet weak var previewAreaView: UIView!
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var widthSlider: UISlider!
    @IBOutlet weak var heightSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        previewView.layer.borderColor = UIColor.black.cgColor
        previewView.layer.borderWidth = 1
    }
    
    func setDocument(_ document: Document, completion: @escaping (Bool) -> Void) {
        document.open { (success) in
            if success {
                self.document = document
                self.loadViewIfNeeded()
                
                self.navigationItem.title = document.fileURL.lastPathComponent
                
                let width = document.rectangle.width
                let height = document.rectangle.height
                self.widthSlider.value = width
                self.heightSlider.value = height
            }
            completion(success)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let doc = document {
            let width = doc.rectangle.width
            let height = doc.rectangle.height
            previewView.bounds = CGRect(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height))
        }
        
        super.viewDidAppear(animated)
    }
    
    @IBAction func dismissDocumentViewController() {
        if let doc = document {
            doc.close { (success) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        } else {
            dismiss(animated: true, completion: nil)
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
