//
//  VideoViewController.swift
//  BottomTabBar
//
//  Created by UDLAP on 1/18/18.
//  Copyright © 2018 151211. All rights reserved.
//

import UIKit

class VideoViewController : UIViewController{
    
    
    @IBOutlet weak var webView: UIWebView!
    
    
    @IBOutlet weak var titulo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titulo.text = Model.videos[Model.indiceDelVideoActual].getTitulo()
        loadYouTubeVideo(urlString:Model.videos[Model.indiceDelVideoActual].getURLsString())
    }
    
    func loadYouTubeVideo(urlString:String){
        guard let youTubeURL = URL(string: urlString) else {
            return
        }
        webView.loadRequest(URLRequest(url:youTubeURL))
    }
}
