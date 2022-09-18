//
//  LibraryPlaylistsViewController.swift
//  SampleD
//
//  Created by Demetrice Sims on 9/6/22.
//  Copyright © 2022 Demetrice Sims. All rights reserved.
//

import UIKit

class LibraryPlaylistsViewController: UIViewController {

    var playlists = [Playlist]()
    
    private let noPlaylistsView = ActionLabelView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(noPlaylistsView)
     
        setUpNoPlaylistsView()
        fetchData()
        }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noPlaylistsView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        noPlaylistsView.center = view.center
    }
    private func setUpNoPlaylistsView(){
        view.addSubview(noPlaylistsView)
        noPlaylistsView.delegate = self
        noPlaylistsView.configure(
            with: ActionLabelViewViewModel(
                text: "You don't have any playlists yet.",
                actionTitle: "Create"
            )
        )
        
    }
    private func fetchData(){
        APICaller.shared.getCurrentUserPlaylists { [weak self]result in
            DispatchQueue.main.async {
                switch result {
                case.success(let playlists):
                    self?.playlists = playlists
                    self?.updateUI()
                case.failure(let error):
                print(error.localizedDescription)
                }
            }
        }
    }
    private func updateUI(){
        if playlists.isEmpty{
            //show label
            noPlaylistsView.isHidden = false
        }
        else {
            // show table
            
            }
        }
    }
    
extension LibraryPlaylistsViewController: ActionLabelViewDelegate{
    func actionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        //Show Creation UI
        let alert = UIAlertController(
            title: "New Playlists",
            message: "Enter Playlist name.",
            preferredStyle: .alert
        )
        alert.addTextField { textField in
            textField.placeholder = "Playlist..."
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: {_ in
            guard let field = alert.textFields?.first,
                  let text = field.text,
                  !text.trimmingCharacters(in: .whitespaces).isEmpty else{
                return
            }
            
            APICaller.shared.createPlaylist(with: text) { success in
                if success {
                    //Refresh list of playlists
                }
                else{
                    print("failed to create playlist")
                }
            }
        }))

        present(alert, animated: true)
    }
}
