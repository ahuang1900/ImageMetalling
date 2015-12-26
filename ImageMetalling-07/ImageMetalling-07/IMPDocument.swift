//
//  IMPDocument.swift
//  ImageMetalling-07
//
//  Created by denis svinarchuk on 15.12.15.
//  Copyright © 2015 IMetalling. All rights reserved.
//

import Cocoa
import IMProcessing

enum IMPDocumentType{
    case Image
}

typealias IMPDocumentObserver = ((file:String, type:IMPDocumentType) -> Void)

class IMPDocument: NSObject {
    
    private override init() {}
    private var didUpdateDocumnetHandlers = [IMPDocumentObserver]()
    
    static let sharedInstance = IMPDocument()
    
    var currentFile:String?{
        didSet{
            for o in self.didUpdateDocumnetHandlers{
                o(file: currentFile!, type: .Image)
            }
        }
    }
        
    func addDocumentObserver(observer:IMPDocumentObserver){
        didUpdateDocumnetHandlers.append(observer)
    }
    
    
    var currentImageProvider:IMPImageProvider?
    
    func saveCurrent(filename:String){
        if let provider = currentImageProvider{
            let image = IMPImage(provider: provider)
            image.saveAsJpeg(fileName:filename)
            NSLog(" save tooo : %@ \(IMPDocument.sharedInstance.currentImageProvider)", filename)
        }
    }
    
}

