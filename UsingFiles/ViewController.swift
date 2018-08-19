//
//  ViewController.swift
//  UsingFiles
//
//  Created by Sukumar Anup Sukumaran on 19/08/18.
//  Copyright © 2018 TechTonic. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController {
    
    var pdfArray = [String]()
    
    @IBOutlet weak var tablePDF: UITableView!
    @IBOutlet weak var PDFCountLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }

    @IBAction func writeFiles(_ sender: Any) {
        print("writing..")
        let file = "\(UUID().uuidString).text"
        print("File = \(file)")
        
        let contents = "Texts that will be written to the doc"
        
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {print(" documentDirectory😩");return}
        
        let fileURL = dir.appendingPathComponent(file)
        
        do {
            try contents.write(to: fileURL, atomically: false, encoding: .utf8)
        } catch let error {
            print("\(error.localizedDescription)😩")
            return
        }
        print("Done writting")
    }
    
    @IBAction func importFiles(_ sender: Any) {

        
        clickFunction()

    }
    
    func clickFunction() {
        print("Menu")
        let importMenu = UIDocumentPickerViewController(documentTypes: [kUTTypePDF as String], in: .import)
        importMenu.delegate = self
        //importMenu.modalPresentationStyle = .formSheet
        importMenu.allowsMultipleSelection = true
        self.present(importMenu, animated: true, completion: nil)
    }


}


extension ViewController: UIDocumentPickerDelegate, UINavigationControllerDelegate {
    
    
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else {print("selectedFileURL😩");return}
        let pathComponent = selectedFileURL.lastPathComponent
        print("pathComponent = \(pathComponent)")
        
         guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {print(" documentDirectory😩");return}
        
        let sandboxFileURL = dir.appendingPathComponent(selectedFileURL.lastPathComponent)
        print("sandboxFileURL = \(sandboxFileURL)")
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            print("Already exists! Do nothing")
        } else {
            do{
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                print("file copied")
                pdfArray.append(sandboxFileURL.lastPathComponent)
                print("pdfArray.count = \(pdfArray.count)")
                self.PDFCountLabel.text = String(pdfArray.count)
                self.tablePDF.reloadData()
            }catch let error{
                print("errorWhileCopying = \(error.localizedDescription)")
                return
            }
        }
    }
    
    

    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true) {
            self.tablePDF.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pdfArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pdfTableViewCell", for: indexPath) as! pdfTableViewCell
        
        cell.config(pdfName: pdfArray[indexPath.row])
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
          guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {print(" documentDirectory😩");return}
        
       
        
         let index = tablePDF.indexPathForSelectedRow
        print("index = \(index!)")
        let vc = segue.destination as! PDFViewerViewController
        let pdfPath = pdfArray[index!.row]
        let pdfFileURL = dir.appendingPathComponent(pdfPath)
        print("pdfFileURL = \(pdfFileURL)")
        vc.pdfString = pdfFileURL
    }
}
