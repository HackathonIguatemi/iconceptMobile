//
//  ViewController.swift
//  iconcept
//
//  Created by Carlos Doki on 22/09/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {

    @IBOutlet weak var tituloLbl: UILabel!
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var activityIV: UIActivityIndicatorView!
    @IBOutlet weak var activityV: UIView!
    
    var collectionItem = [Preferencias]()
    var slides:[Slide] = [];
    var idPromocoes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIV.startAnimating()
        activityV.isHidden = false
        
        let user = Auth.auth().currentUser
        tituloLbl.text = "Novidades da semana\npara você, \(user!.displayName as!String)."
        
        // Do any additional setup after loading the view, typically from a nib.
        collection.dataSource = self
        collection.delegate = self
        scrollView.delegate = self
        
        createSlides()
        
        DataService.ds.REF_PREFERENCIAS.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
//                    print("DOKI: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Preferencias(postKey: key, postData: postDict)
                        self.collectionItem.append(post)
                    }
                }
            }
            self.collection!.reloadData()
            self.activityIV.stopAnimating()
            self.activityV.isHidden = true
        })
        
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? collectionCell {
            cell.configureCell(collectionItem[indexPath.row])
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 171, height: 144)
    }
    
    
    func setupSlideScrollView(slides : [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    func createSlides() {
      
        DataService.ds.REF_PROMOCAO.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                self.slides = []
                for snap in snapshot {
//                    print("DOKI: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        self.idPromocoes.append(key)
                        let post = Promocoes(postKey: key, postData: postDict)

                        let tempSlide:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
                        if let img = post.URL as? String {
                            if let data = NSData(contentsOf: NSURL(string: img) as! URL) {
                                tempSlide.imageView.image  = UIImage(data: data as Data)
                            }
                        }
                        tempSlide.labelTitle.text = "\(post.nome)"
                        self.slides.append(tempSlide)
                    }
                }
            }
            self.setupSlideScrollView(slides: self.slides)
            self.pageControl.numberOfPages = self.slides.count
            self.pageControl.currentPage = 0
            self.view.bringSubviewToFront(self.pageControl)
        })

    }
    
    @IBAction func Teste(_ sender: Any) {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "detalhesEventoVC") as! detalhesEvento
        
        controller.eventoID = idPromocoes[pageControl.currentPage] as! String
        self.present(controller, animated: true, completion: nil)
    }
    @IBAction func pageClicked(_ sender: UIPageControl) {
        self.performSegue(withIdentifier: "detalhesEvento", sender: nil)
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
        
        /*
         * below code changes the background color of view on paging the scrollview
         */
        //        self.scrollView(scrollView, didScrollToPercentageOffset: percentageHorizontalOffset)
        
        
        /*
         * below code scales the imageview on paging the scrollview
         */
        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        
        if(percentOffset.x > 0 && percentOffset.x <= 0.25) {
            
            slides[0].imageView.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
            slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
            
//        } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
//            slides[1].imageView.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
//            slides[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
//            
//        } else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
//            slides[2].imageView.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
//            slides[3].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
//            
//        } else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
//            slides[3].imageView.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
//            slides[4].imageView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
        }
    }
}

