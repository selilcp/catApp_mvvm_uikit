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
    private var pullControl:UIRefreshControl?
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CatsApp"
        tableView.dataSource = self
        tableView.delegate = self
        registerCakeListCell(tableView: tableView)
        viewModel = CatListViewModel(service: DefaultCatsListingService())
        fetchData()
        addPullToRefreshList(tableView: tableView)
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
        guard let viewModel = viewModel,
              let selectedCat = viewModel.getCatWithPosition(pos: indexPath.item)
        else { return }
        let isFavourite = viewModel.isFavourite(cat: selectedCat)
        let detailViewModel = CatDetailViewModel(detailsService: DefaultCatDetailsService(),
                                          cat: selectedCat,
                                          isFavourite: isFavourite)
        coordinator?.gotoDetails(detailViewModel: detailViewModel)
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
        cell.delegate = self
        if let cat = viewModel?.getCatWithPosition(pos: indexPath.item){
            let isFavourite = viewModel?.isFavourite(cat: cat) ?? false
            cell.updateUI(cat:cat,
                          favourite: isFavourite)
        }
        return cell
    }
}

extension CatsListingController: CatsListingTableViewCellDelegate {
    func favouriteClick(cat: Cat) {
        guard let viewModel = viewModel else { return }
        if viewModel.isFavourite(cat: cat){
            viewModel.removeFromFavourite(cat: cat)
        }else{
            viewModel.setFavourite(cat: cat)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension CatsListingController{

    func addPullToRefreshList(tableView:UITableView){
        pullControl = UIRefreshControl()
        pullControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        pullControl?.addTarget(self, action: #selector(refreshListData(_:)), for: .valueChanged)
        tableView.refreshControl = pullControl
    }
    @objc private func refreshListData(_ sender: Any) {
        pullControl?.endRefreshing()
        fetchData()
    }
}
