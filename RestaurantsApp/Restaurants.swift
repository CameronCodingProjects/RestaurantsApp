//
//  Restaurants.swift
//  RestaurantsApp
//
//  Created by Field Employee on 4/18/21.
//

import Foundation

// MARK: - Welcome
struct Restaurants: Codable {
    let restaurants: [Restaurant]
}

// MARK: - Restaurant
struct Restaurant: Codable {
    let name: String
    let backgroundImageURL: String
    let category: String
    let contact: Contact?
    let location: Location
}

// MARK: - Contact
struct Contact: Codable {
    let phone, formattedPhone: String
    let twitter, facebook, facebookUsername, facebookName: String?
}

// MARK: - Location
struct Location: Codable {
    let address: String
    let crossStreet: String?
    let lat, lng: Double
    let postalCode: String?
    let cc: Cc
    let city: City
    let state: State
    let country: Country
    let formattedAddress: [String]
}

enum Cc: String, Codable {
    case us = "US"
}

enum City: String, Codable {
    case addison = "Addison"
    case dallas = "Dallas"
}

enum Country: String, Codable {
    case unitedStates = "United States"
}

enum State: String, Codable {
    case tx = "TX"
}
