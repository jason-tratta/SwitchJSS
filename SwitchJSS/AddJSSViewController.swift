//
//  AddJSSViewController.swift
//  SwitchJSS
//
//  Created by Tratta, Jason A on 9/3/15.
//
//  The MIT License (MIT)
//
//Copyright (c) 2015 Jason Tratta
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

import Cocoa
import CoreData

class AddViewController: NSViewController  {



    @IBOutlet weak var jssNameTextField: NSTextField!
    @IBOutlet weak var jssAddressTextField: NSTextField!
    @IBOutlet weak var allowUntrusedButton: NSButton!


    @IBAction func addJSS(_ sender: AnyObject) {
    
    let theDoc = NSDocumentController.shared().currentDocument as! NSPersistentDocument
    let managedObjectContext = theDoc.managedObjectContext
     
    let jssObject = NSEntityDescription.insertNewObject(forEntityName: "JSSInfo", into: managedObjectContext!) as! JSSInfo
    
        jssObject.setValue(jssNameTextField.stringValue, forKey: "labelName")
        jssObject.setValue(jssAddressTextField.stringValue, forKey: "jssAddress")
        
        if allowUntrusedButton.state == 1 {
            
           jssObject.setValue(true, forKey: "allowInvalidCert")
            
        } else {
            
            jssObject.setValue(false, forKey: "allowInvalidCert")
        }

        self.dismiss(self)
        
    }



    @IBAction func cancelButton(_ sender: AnyObject) {
        
        
        self.dismiss(self)
        
    }
    
 


  

}
