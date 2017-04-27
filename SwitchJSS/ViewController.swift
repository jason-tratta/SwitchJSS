//
//  ViewController.swift
//  SwitchJSS
//
//  Created by Tratta, Jason A on 2/13/15.
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


var JSApplicationDidFinishLoading = "apploaded"

class ViewController: NSViewController {
    
    var statusBar = NSStatusBar.system()
    var statusBarItem : NSStatusItem = NSStatusItem()
    var theMenu:NSMenu = NSMenu()
    var theEditMenuItem : NSMenuItem = NSMenuItem(title: "Open", action: Selector(("editButton:")), keyEquivalent: "")
    
    
    var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    var theDocument = NSPersistentDocument()
 
    
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet var arrayController: NSArrayController!
    @IBOutlet var selectedLabel: NSTextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
  
      print("ViewDidLoad")
       



        //Add statusBarItem
        statusBarItem = statusBar.statusItem(withLength: -1)
        statusBarItem.menu = theMenu
        statusBarItem.title = "JSS"
        statusBarItem.target = self
        statusBarItem.action = #selector(ViewController.editButtton(_:))
        
        
        theEditMenuItem.target = self
        theEditMenuItem.action = #selector(ViewController.editButtton(_:))
        theMenu.addItem(theEditMenuItem)
        
    }
    
    
    override func viewWillAppear() {
        
        print("Will Appear")
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
            theDocument = representedObject as! NSPersistentDocument
            managedObjectContext = theDocument.managedObjectContext!
            arrayController.managedObjectContext = managedObjectContext
        

            print("DidSet")
            print(theDocument)
            
        }
    }
    
    
    
    
    
    func closeWindow() {
        
        view.window?.orderOut(self)
        
        
        
    }
    
    
    
    
    
    @IBAction func editButtton(_ sender: AnyObject) {
        
        
        
        view.window?.orderFront(self)
        view.window?.becomeFirstResponder()
        
        
    }
    
    
    @IBAction func selectJSSButton(_ sender: AnyObject) {
        
        
        let jssObject = tableView.selectedRow
        
        let allObjects = arrayController.arrangedObjects as! [JSSInfo]
        
        for aObject:JSSInfo in allObjects {
            
            aObject.selected = 0
            
        }
        
      
        let object = (arrayController.arrangedObjects as? AnyObject)?.object(at:jssObject) as! JSSInfo
        object.selected = 1
        let allowInval = object.allowInvalidCert
        var allowBoolString = ""
        
        if allowInval == 0 {
            
            allowBoolString = "false"
            print("false")
            
        } else  {
            
            allowBoolString = "true"
            print("true")
        }
        
        
        let jssSwitch = JSSSwitcher()
        jssSwitch.setJssServer(object.jssAddress!, allowInval: allowBoolString)
        selectedLabel.stringValue = object.labelName!
            
        
        
    }
    
    
    
    
    //End Class
    
}
