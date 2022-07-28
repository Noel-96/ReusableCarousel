//
//  ViewController.swift
//  ReusableCarousel
//
//  Created by Noel Obaseki on 23/07/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var customXib: ApartmentPopupView!
    
    var maintenancePhotos = ["https://live-core-image-service.vivialplatform.net/images/220282/1920x480/busted_pipes_11392563_s-2015_cropped.oCIFw1-lGx.jpg.webp",
                            "https://mccarysplumbingrepair.com/wp-content/uploads/2011/01/How-to-Fix-a-Leaky-Pipe.jpg","https://sp-ao.shortpixel.ai/client/to_webp,q_lossless,ret_img/https://texasbulldoglaw.com/wp-content/uploads/2021/03/iStock-530427525-scaled.jpg"]
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        CustomizeCarousel(photoData: maintenancePhotos, title: "Maintenance Request", issue: "Leaking Pipes", cost: "$1200", room: "kitchen", appliance: "sink", estate: "lekki estate")
    }
    
  
    func CustomizeCarousel (photoData: [String], title: String, issue:String, cost: String, room: String, appliance:String, estate:String) {
        customXib.demoPhotosUrls = photoData
        customXib.customTitle.text = title
        customXib.customIssue.text = issue
        customXib.manitenaceCostAmount.text = cost
        customXib.customRoom.text = room
        customXib.applianceAffected.text = appliance
        customXib.customEstate.text = estate
    }
 

}

