//
//  ViewController.swift
//  RestaurantsApp
//
//  Created by Field Employee on 4/18/21.
//

import UIKit

class ViewController: UIViewController {
    
    private var tableView: UITableView!
    let networkManager = NetworkManager()
    var restaurants: [Restaurant] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchRestaurants()
        setupTableView()
    }
    
    func fetchRestaurants() {
        networkManager.fetchLunch { [weak self] result in

            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.restaurants = data.restaurants
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func setupTableView() {
        let barHeight: CGFloat = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height

        self.tableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(tableView)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = restaurants[indexPath.row].name
        content.secondaryText = restaurants[indexPath.row].category
        
        content.textProperties.color = .white
        content.textProperties.font = .boldSystemFont(ofSize: 20)
        content.textProperties.numberOfLines = 0
        
        content.secondaryTextProperties.color = .white
        content.secondaryTextProperties.font = .boldSystemFont(ofSize: 14)
        content.secondaryTextProperties.numberOfLines = 0
        
        cell.contentConfiguration = content
        cell.selectionStyle = .none

        let imageView = UIImageView(frame: CGRect(x: 0, y: 10, width: cell.frame.width, height: cell.frame.height - 20))
        imageView.downloaded(from: restaurants[indexPath.row].backgroundImageURL, contentMode: .scaleAspectFill)
        cell.backgroundView = UIView()
        cell.backgroundView!.addSubview(imageView)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DetailsViewController()
        let restaurant = restaurants[indexPath.row]
//        vc.lng = restaurant.location.lng
//        vc.lat = restaurant.location.lat
//        vc.address = restaurant.location.address
//        vc.number = restaurant.contact?.phone
        vc.setupVC(restaurant)
        self.present(vc, animated: false, completion: nil)
    }
}

