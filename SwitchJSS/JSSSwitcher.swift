//
//  JSSSwitcher.swift
//  SwitchJSS
//
//  Created by Tratta, Jason A on 9/30/15.
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

class JSSSwitcher  {
    

 var jssDictionary = NSMutableDictionary()
 var reconDictionary = NSMutableDictionary()


func readJss() {

    let thePath = "~~/Library/Preferences/com.jamfsoftware.jss.plist"
    let theData = FileManager.default.contents(atPath: thePath)
    
    do {
   try jssDictionary = PropertyListSerialization.propertyList(from: theData!, options: .mutableContainersAndLeaves, format:nil) as! NSMutableDictionary
    } catch {
        
        debugPrint("Property List Data Serialization Failed")
    }
    

    let casperString = jssDictionary.object(forKey: "url")
    debugPrint("JSSSwitcher:" + (casperString as! String))

    //Lets Get Recon for completeness. Recon portion is not working as expected
    /*
    let reconPath = "~~/Library/Preferences/com.jamfsoftware.Recon.plist"
    let reconData = NSFileManager.defaultManager().contentsAtPath(reconPath)

    do {
        try reconDictionary = NSPropertyListSerialization.propertyListWithData(reconData!, options: .MutableContainersAndLeaves, format:nil) as! NSMutableDictionary
    } catch {
        
        debugPrint("Property List Data Serialization Failed")
    }
    
    
    let reconString = reconDictionary.objectForKey("url")
    debugPrint("JSSSwitcher:" + (reconString as! String))
    */

    
}


    func setJssServer(_ server: String, allowInval: String) {


    let path = NSString(string: "~/Library/Preferences/com.jamfsoftware.jss.plist").expandingTildeInPath
    jssDictionary.setObject(server, forKey: "url" as NSCopying)
    jssDictionary.setObject(allowInval, forKey: "allowInvalidCertificate" as NSCopying)
    
    do {
        
    let saveData = try PropertyListSerialization.data(fromPropertyList: jssDictionary, format: .xml, options:0)
    try? saveData.write(to: URL(fileURLWithPath: path), options: [.atomic])
        
    } catch {
        
        debugPrint("Failed to Write JSS Location")
        
    }
        
    /* Recon portion is not working as expected
     let reconPath = NSString(string: "~/Library/Preferences/com.jamfsoftware.Recon.plist").stringByExpandingTildeInPath
     reconDictionary.setObject(server, forKey: "server")
        
        do {
            
            let saveData = try NSPropertyListSerialization.dataWithPropertyList(reconDictionary, format: .XMLFormat_v1_0, options:0)
            saveData.writeToFile(reconPath, atomically: true)
            
        } catch {
            
            debugPrint("Failed to Write JSS Location")
            
        }

        */
    
    }
    
//End of Class

    }
