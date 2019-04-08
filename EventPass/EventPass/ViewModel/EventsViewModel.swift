//
//  EventsViewModel.swift
//  EventPass
//
//  Created by Carlos Marcelo Tonisso Junior on 3/29/19.
//  Copyright © 2019 Carlos Marcelo Tonisso Junior. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import CodableFirebase
import GeoFire

class EventsViewModel: ViewModel {
    
    let firebaseRef: DatabaseReference
    let geoFire: GeoFire
    
    var events: [Event] = []
    
    override init(_ navigationController: UINavigationController?) {
        firebaseRef = Database.database().reference()
        geoFire = GeoFire(firebaseRef: firebaseRef)
        super.init(navigationController)
    }
    
    func getEventsForUserLocation(location: CLLocation, completion: @escaping (Bool) -> Void) {
        self.events.removeAll()
        let query = geoFire.query(at: location, withRadius: 20)
        
        query.observe(.keyEntered, with: { (key: String!, location: CLLocation!) in
            self.firebaseRef.child("events").observeSingleEvent(of: .value, with: { (snapshot) in
                guard let value = snapshot.value else { return }
                do {
                    let event = try FirebaseDecoder().decode(Event.self, from: value)
                    self.events.append(event)
                    completion(true)
                } catch let error {
                    print(error)
                }
            })
        })
    }
    
    func getEventsBy(name: String, completion: @escaping (Bool) -> Void) {
        self.events.removeAll()
        
        let recentPostsQuery = (firebaseRef.child("events").queryStarting(atValue: name).queryLimited(toFirst: 10))
        recentPostsQuery.observe(.value) { (snapshot) in
            guard let value = snapshot.value else { return }
            do {
                self.events = try FirebaseDecoder().decode([Event].self, from: value)
//                self.events.append(event)
                completion(true)
            } catch let error {
                print(error)
            }
        }
    }
    
    func eventAt(_ indexPath: IndexPath) -> Event {
        return events[indexPath.row]
    }
    
    func numberOfEvents() -> Int {
        return events.count
    }
    
}
    

