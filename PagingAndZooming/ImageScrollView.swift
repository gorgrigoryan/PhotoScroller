//
//  ImageScrollView.swift
//  PagingAndZooming
//
//  Created by Gor Grigoryan on 10/24/19.
//  Copyright © 2019 Gor Grigoryan. All rights reserved.
//

import UIKit

class ImageScrollView: UIScrollView, UIScrollViewDelegate {
    var imageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        minimumZoomScale = 0.05
        maximumZoomScale = 10
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        addSubview(imageView)
        
        delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(tap:)))
        tap.numberOfTapsRequired = 2
        addGestureRecognizer(tap)
    }
    
    @objc func handleDoubleTap(tap:UITapGestureRecognizer){
        if zoomScale > minimumZoomScale {
            setZoomScale(minimumZoomScale, animated: true)
        } else {
            let location = tap.location(in: imageView)
            let rect = CGRect(x: location.x, y: location.y, width: 1, height: 1)
            zoom(to: rect, animated: true)
        }
    }
    
    func setImage(withName name: String) {
        imageView.image = UIImage(named: name)
        imageView.sizeToFit()
        contentSize = imageView.bounds.size
        zoomScale = frame.width / contentSize.width
    }
    
    func centerContent() {
        let imageViewSize = imageView.frame.size

        var vertical: CGFloat = 0, horizontal: CGFloat = 0
        if imageViewSize.width < bounds.size.width {
            vertical = (bounds.width - imageViewSize.width) / 2
        }

        if imageViewSize.height < bounds.size.height  {
            horizontal = (bounds.height - imageViewSize.height) / 2
        }

        contentInset = UIEdgeInsets(top: horizontal, left: vertical, bottom: horizontal,
                                              right: vertical)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerContent()
    }
}
