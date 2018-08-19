//
//  PDFViewerViewController.swift
//  UsingFiles
//
//  Created by Sukumar Anup Sukumaran on 19/08/18.
//  Copyright © 2018 TechTonic. All rights reserved.
//

import UIKit
import WebKit

class PDFViewerViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!

    var pdfString: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       print("pdfPath = \(pdfString!)")
        loadWebUrl()
    }
    
    

    func loadWebUrl() {
        
        
        print("loadWebUrl")
        
        
        
        let url = pdfString
        print("url = \(url!)")
        var request = URLRequest(url: url!)
        
        request.cachePolicy = .returnCacheDataElseLoad
        
        webView.load(request)
        
    }

   

}

extension PDFViewerViewController: WKNavigationDelegate {
    
}
