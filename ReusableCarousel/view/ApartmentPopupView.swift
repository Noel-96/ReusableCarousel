//
//  ApartmentPopupView.swift
//  ReusableCarousel
//
//  Created by Noel Obaseki on 23/07/2022.
//

import Foundation
import UIKit

struct Apartment : Codable {
    
    let title: String
    let  room : String
    let imageUrls: [String]
}


class ApartmentPopupView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let customReuseIdentifier = "apartmentPhotoCell"
    
    private let apartmentViewModel = ApartmentViewModel()
    
    var placeHolderImage = UIImage() {
        didSet {
            if let _image = UIImage(named:"placeholder") {
                placeHolderImage = _image
            }
        }
    }
    
    
    var demoPhotosUrls: [String]  = 
    [
        "https://i.picsum.photos/id/45/1000/500.jpg?hmac=46CV7w7uFg2Z9X5B-mp9-MaAKs_CXqjc6nBgAbqVVW8",
        "https://i.picsum.photos/id/1037/1000/500.jpg?hmac=SZvfGkkgKB5QxEx_YJpK3DPMJc338vtCrtfxsGxPcn8",
        "https://i.picsum.photos/id/803/1000/500.jpg?hmac=CO5Zbn-O065gi_tSZv4nOx33dPqW8-zWHpgdta43e3Y" ]




    @IBOutlet weak var customTitle: UILabel!
    @IBOutlet weak var customRoom: UILabel!
    @IBOutlet weak var applianceAffected: UILabel!
    @IBOutlet weak var customIssue: UILabel!
    @IBOutlet weak var customEstate: UILabel!
    @IBOutlet weak var manitenaceCostAmount: UILabel!
    
    @IBOutlet weak var maintenancePhotos: UICollectionView!
    
    @IBOutlet weak var applicationInviteImage: UIImageView!
    @IBOutlet weak var applicationPopupPageNumber: UILabel!
    @IBOutlet weak var applicationPhotoDots: UIPageControl!
    @IBOutlet weak var startApplicationButton: UIButton!
    
    
    @IBAction func startApplicationTapped(_ sender: Any) {
        print("startApplicationTapped")
    }
    
    
    @IBAction func dismissApplicationTapped(_ sender: Any) {
        print("dismissApplicationTapped")
    }

    let nibName = "ApartmentPopupView"

    //functions for initializing this nib

    //required init function
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit(maintenancePhotosUrls: apartmentViewModel.demoPhotoUrls
                    demoPhotosUrls)
        //set the collection delegate and datasource of the photos to self(update collection view when Apartment Popup view data updates)
        maintenancePhotos.delegate = self
        maintenancePhotos.dataSource = self
        maintenancePhotos.register(UINib(nibName: "ApplicationApartmentPhotoCell", bundle: nil), forCellWithReuseIdentifier: customReuseIdentifier)
    }
    
    
    //override the default initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        //run custom initializer
        commonInit(maintenancePhotosUrls: demoPhotosUrls)
    }

    //custom initializer
    func commonInit(demoPhotosUrls: [String]) {
        self.demoPhotosUrls = maintenancePhotosUrls
        
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        maintenancePhotos.reloadData()
    }
    
    
    //load view from nib named ApartmentPopupView
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    
    //function for handling when user has scrolled in the scrollview, update the UI to let user know what photo they are on
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //if the scrollview is application popup photos (no other scrollview is available)
        if scrollView == maintenancePhotos {
            //get page number of cell in view
            let pageNumber = Int((maintenancePhotos.contentOffset.x / maintenancePhotos.frame.width).rounded(.toNearestOrAwayFromZero))
            applicationPhotoDots.currentPage = pageNumber
            // set page number
            applicationPopupPageNumber.text = "\(pageNumber + 1) of \(demoPhotosUrls.count)"

        }
    }
    
    
    // Set size of collection view items
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //if the collection view is application popup photos (no other collection view is available)
        if collectionView == maintenancePhotos {
            // Set up CollectionView
            let width = collectionView.frame.width
            let height = collectionView.frame.height
            //Set size of collection view item to size of collectionView to take entire space
            return CGSize(width: width, height: height)
        }
        //Set default size
        return CGSize(width: 0, height: 0)
    }
    
    
    
    // Determine how many sections there are in collectionView, in this case 1
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //application popup photos has 1 section
        return 1
    }
    
    
    // Determine how many items there are in collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //if the collection view is application popup photos (no other collection view is available)
        if collectionView == maintenancePhotos {
            //set the number of items equal to the number of photos
            applicationPhotoDots.numberOfPages = demoPhotosUrls.count
            return demoPhotosUrls.count
        }
        return 0
    }
    
    
    
    // Determine what kind of cell is in collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //if the collection view is application popup photos (no other collection view is available)
        if collectionView == maintenancePhotos {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customReuseIdentifier, for: indexPath) as! ApplicationApartmentPhotoCell
            let imageUrl: String = self.demoPhotosUrls[indexPath.row]

            cell.imageView.loadImage(imageUrl: imageUrl, Placeholder: placeHolderImage)
            return cell
        }
        return collectionView.dequeueReusableCell(withReuseIdentifier: customReuseIdentifier, for: indexPath) as! ApplicationApartmentPhotoCell
    }
    //made some changes to this project chinaza commts
    

    //When a collection view item is clicked
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //do nothing because we dont need anything to be done when an apartment photo is clicked
        return
    }


}
