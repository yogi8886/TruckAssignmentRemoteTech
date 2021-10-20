//
//  TrucksModel.swift
//  TruckAssignmentRemoteTech
//
//  Created by Yogesh on 17/10/21.
//

import Foundation

// MARK: - TrucksModel
class TrucksModel: Codable {
  let responseCode: ResponseCode
  let data: [truckData]
  
  init(responseCode: ResponseCode, data: [truckData]) {
    self.responseCode = responseCode
    self.data = data
  }
}

// MARK: - Datum
class truckData: Codable {
  let id, companyID, truckTypeID, truckSizeID: Int?
  let truckNumber: String?
  let transporterID, trackerType: Int?
  let imeiNumber, simNumber: String?
  let name: String?
  let password: String?
  let createTime: Int?
  let deactivated, breakdown: Bool?
  let lastWaypoint: LastWaypoint?
  let lastRunningState: LastRunningState?
  let durationInsideSite: Int?
  let fuelSensorInstalled, externalTruck: Bool?
  
  enum CodingKeys: String, CodingKey {
    case id
    case companyID = "companyId"
    case truckTypeID = "truckTypeId"
    case truckSizeID = "truckSizeId"
    case truckNumber
    case transporterID = "transporterId"
    case trackerType, imeiNumber, simNumber, name, password, createTime, deactivated, breakdown, lastWaypoint, lastRunningState, durationInsideSite, fuelSensorInstalled, externalTruck
  }
  
  init(id: Int?, companyID: Int?, truckTypeID: Int?, truckSizeID: Int?, truckNumber: String?, transporterID: Int?, trackerType: Int?, imeiNumber: String?, simNumber: String?, name: String?, password: String?, createTime: Int?, deactivated: Bool?, breakdown: Bool?, lastWaypoint: LastWaypoint, lastRunningState: LastRunningState, durationInsideSite: Int, fuelSensorInstalled: Bool, externalTruck: Bool) {
    self.id = id
    self.companyID = companyID
    self.truckTypeID = truckTypeID
    self.truckSizeID = truckSizeID
    self.truckNumber = truckNumber
    self.transporterID = transporterID
    self.trackerType = trackerType
    self.imeiNumber = imeiNumber
    self.simNumber = simNumber
    self.name = name
    self.password = password
    self.createTime = createTime
    self.deactivated = deactivated
    self.breakdown = breakdown
    self.lastWaypoint = lastWaypoint
    self.lastRunningState = lastRunningState
    self.durationInsideSite = durationInsideSite
    self.fuelSensorInstalled = fuelSensorInstalled
    self.externalTruck = externalTruck
  }
}

// MARK: - LastRunningState
class LastRunningState: Codable {
  let truckID, stopStartTime, truckRunningState: Int?
  let lat, lng: Double?
  let stopNotficationSent: Int?
  
  enum CodingKeys: String, CodingKey {
    case truckID = "truckId"
    case stopStartTime, truckRunningState, lat, lng, stopNotficationSent
  }
  
  init(truckID: Int?, stopStartTime: Int?, truckRunningState: Int?, lat: Double?, lng: Double?, stopNotficationSent: Int?) {
    self.truckID = truckID
    self.stopStartTime = stopStartTime
    self.truckRunningState = truckRunningState
    self.lat = lat
    self.lng = lng
    self.stopNotficationSent = stopNotficationSent
  }
}

// MARK: - LastWaypoint
class LastWaypoint: Codable {
  let id: Int?
  let lat, lng: Double?
  let createTime, accuracy, bearing, truckID: Int?
  let speed: Double?
  let updateTime: Int?
  let ignitionOn: Bool?
  let odometerReading: Double?
  let batteryPower: Bool?
  let fuelLevel, batteryLevel: Int?
  
  enum CodingKeys: String, CodingKey {
    case id, lat, lng, createTime, accuracy, bearing
    case truckID = "truckId"
    case speed, updateTime, ignitionOn, odometerReading, batteryPower, fuelLevel, batteryLevel
  }
  
  init(id: Int?, lat: Double?, lng: Double?, createTime: Int?, accuracy: Int?, bearing: Int?, truckID: Int?, speed: Double?, updateTime: Int?, ignitionOn: Bool?, odometerReading: Double?, batteryPower: Bool?, fuelLevel: Int?, batteryLevel: Int?) {
    self.id = id
    self.lat = lat
    self.lng = lng
    self.createTime = createTime
    self.accuracy = accuracy
    self.bearing = bearing
    self.truckID = truckID
    self.speed = speed
    self.updateTime = updateTime
    self.ignitionOn = ignitionOn
    self.odometerReading = odometerReading
    self.batteryPower = batteryPower
    self.fuelLevel = fuelLevel
    self.batteryLevel = batteryLevel
  }
}

// MARK: - ResponseCode
class ResponseCode: Codable {
  let responseCode: Int
  let message: String
  
  init(responseCode: Int, message: String) {
    self.responseCode = responseCode
    self.message = message
  }
}
