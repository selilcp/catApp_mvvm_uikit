//
//  CatsListingController.swift
//  CatsApp
//
//  Created by Selil on 18/06/2024.
//

import UIKit

class CatsListingController: UIViewController, Storyboarded {
    
    var coordinator: MainCoordinator?
    var viewModel:CatListViewModel?
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CatsApp"
        tableView.dataSource = self
        tableView.delegate = self
        registerCakeListCell(tableView: tableView)
        viewModel = CatListViewModel(service: DefaultCatsListingService())
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func registerCakeListCell(tableView:UITableView){
        let nib = UINib(nibName: "CatsListingTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CatsListingTableViewCell")
    }
    
    func fetchData(){
        viewModel?.fetchCatList(complitionHandler: { error in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
}

extension CatsListingController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension CatsListingController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel?.catsCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatsListingTableViewCell") as! CatsListingTableViewCell
        if let cat = viewModel?.getCatWithPosition(pos: indexPath.item){
            cell.updateUI(cat:cat)
        }
        return cell
    }
}
