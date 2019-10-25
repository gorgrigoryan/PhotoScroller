//
//  ViewController.swift
//  PagingAndZooming
//
//  Created by Gor Grigoryan on 10/23/19.
//  Copyright © 2019 Gor Grigoryan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    var scrollView:UIScrollView!
    var pageControl:UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureScrollView()
        addSubviews()
        addPageControl()
    }
    
    func addSubviews() {
        let w = scrollView.frame.width
        let h = scrollView.frame.height
        
        for i in 1...10 {
            let imageScrollView = ImageScrollView(frame: CGRect(x: CGFloat(i - 1) * CGFloat(w), y: 0, width: w, height: h))
            imageScrollView.setImage(withName: "image\(i).jpg")
            
            scrollView.addSubview(imageScrollView)
        }
    }
    
    func configureScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height - 50.0))
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: 10.0 * scrollView.bounds.size.width, height: 0)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)
    }
    
    func addPageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: view.bounds.size.height - CGFloat(50),
                                    width: view.bounds.size.width, height: 50.0))
        pageControl.numberOfPages = 10
        pageControl.addTarget(self,
                              action: #selector(changePage(sender:)),
                              for: .valueChanged)
        pageControl.pageIndicatorTintColor = UIColor.red
        pageControl.currentPageIndicatorTintColor = UIColor.blue
        view.addSubview(pageControl)
    }

    @objc func changePage(sender:UIPageControl) {
        let offsetX = CGFloat(sender.currentPage) * CGFloat(scrollView.frame.size.width)
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        
        if pageControl.currentPage != Int(page) {
            if let subview = scrollView.subviews[pageControl.currentPage] as? ImageScrollView,
                let anotherSubview = scrollView.subviews[Int(page)] as? ImageScrollView {
                subview.setImage(withName: "image\(pageControl.currentPage + 1).jpg")
                
                subview.contentOffset = anotherSubview.contentOffset
            }
        }
        
        pageControl.currentPage = Int(page)
    }
}

