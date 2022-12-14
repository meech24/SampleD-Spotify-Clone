//
//  LibraryViewController.swift
//  SampleD
//
//  Created by Demetrice Sims on 6/8/21.
//  Copyright © 2021 Demetrice Sims. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController {
    private let playlistsVC = LibraryPlaylistsViewController()
    private let albumsVC = LibraryAlbumsViewController()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    private let toggleView = LibraryToggleView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        scrollView.delegate = self
        toggleView.delegate = self
        view.addSubview(scrollView)
        view.addSubview(toggleView)
        scrollView.contentSize = CGSize(width: view.width*2, height: scrollView.height)
        addChildren()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = CGRect(x: 0,
            y: view.safeAreaInsets.top+55,
            width: view.width,
            height: view.height-view.safeAreaInsets.top-view.safeAreaInsets.bottom-55
        )
        toggleView.frame = CGRect(x: 0, y: view.safeAreaInsets.top,
                                  width: 200,
                                  height: 55)
    }
    
    private func addChildren(){
        addChild(playlistsVC)
        scrollView.addSubview(playlistsVC.view)
        playlistsVC.view.frame = CGRect(x: 0, y: 0, width: scrollView.width, height: scrollView.height)
        playlistsVC.didMove(toParent: self)
        
        addChild(albumsVC)
        scrollView.addSubview(albumsVC.view)
        albumsVC.view.frame = CGRect(x: view.width, y: 0, width: scrollView.width, height: scrollView.height)
        albumsVC.didMove(toParent: self)
    }

}

extension LibraryViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x >= (view.width-100){
            toggleView.update(for: .album)
        }
        else {
            toggleView.update(for: .playlist)
        }
    }
}

extension LibraryViewController: LibraryToggleViewDelegate {
    func LibraryToggleViewDidTapPlaylists(_toggleView: LibraryToggleView) {
        scrollView.setContentOffset(.zero, animated: true)
    }
    func LibraryToggleViewDidTapAlbums(_toggleView: LibraryToggleView) {
        scrollView.setContentOffset(CGPoint(x: view.width, y: 0), animated: true)

    }
    
        
}

