//
//  EventsViewController.swift
//  EventPass
//
//  Created by Carlos Marcelo Tonisso Junior on 3/29/19.
//  Copyright © 2019 Carlos Marcelo Tonisso Junior. All rights reserved.
//

import UIKit
import Cartography
import FirebaseDatabase
import CoreLocation

class EventsViewController: UIViewController {
    
    lazy var viewModel = EventsViewModel(self.navigationController)
    
    var locationManager: CLLocationManager?
    
    var currentLocation: CLLocation?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerWithClass(EventsTableViewCell.self)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        fetchAllEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = false
    }
    
    func setupInitialState() {
        self.view.backgroundColor = .white
        setupLocationManager()
        setupTableView()
    }
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager?.pausesLocationUpdatesAutomatically = true
        startLocationService()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        constrain(tableView) { tableView in
            guard let superview = tableView.superview else { return }
            tableView.edges == inset(superview.edges, -42, 0, 0, 0)
        }
    }
    
    func startLocationService() {
        if CLLocationManager.authorizationStatus() == .authorizedAlways ||
            CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            activateLocationServices()
            
        } else {
            locationManager?.requestWhenInUseAuthorization()
        }
    }
    
    func activateLocationServices() {
        locationManager?.startUpdatingLocation()
    }
    
    func fetchEvents(_ updatedLocation: CLLocation) {
        currentLocation = updatedLocation
        viewModel.getEventsForUserLocation(location: updatedLocation) { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
    }
    
    func fetchAllEvents() {
        viewModel.getEventsBy(name: "") { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
    }

}

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfEvents()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EventsTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configureFor(viewModel.eventAt(indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
}

extension EventsViewController: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if (status == .authorizedAlways) || (status == .authorizedWhenInUse) {
            activateLocationServices()
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("Location Error:\(error.localizedDescription)")
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let updatedLocation: CLLocation = locations.first!
        
        if currentLocation == nil {
            fetchEvents(updatedLocation)
        } else if currentLocation != updatedLocation {
            fetchEvents(updatedLocation)
        }
        
    }
}
