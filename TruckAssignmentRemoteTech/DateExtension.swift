//
//  DateExtension.swift
//  TruckAssignmentRemoteTech
//
//  Created by Yogesh on 18/10/21.
//

import Foundation
extension Date {
  func timeAgoSinceDateInt() -> String {
    // From Time
    let fromDate = self
    
    // To Time
    let toDate = Date()
    
    // Year
    if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0  {
      
      return "\(interval)"
    }
    
    // Month
    if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0  {
      
      return "\(interval)"
    }
    
    // Day
    if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0  {
      
      return "\(interval)"
    }
    
    // Hours
    if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {
      
      return "\(interval)"
    }
    
    // Minute
    if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {
      
      return "\(interval)"
    }
    
    return ""
  }
  
  func timeAgoSinceDate() -> String {
    // From Time
    let fromDate = self
    
    // To Time
    let toDate = Date()
    // Year
    if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0  {
      
      return interval == 1 ? "year ago" : "years ago"
    }
    
    // Month
    if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0  {
      
      return interval == 1 ? "month ago" : "months ago"
    }
    
    // Day
    if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0  {
      
      return interval == 1 ? "day ago" : "days ago"
    }
    
    // Hours
    if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {
      
      return interval == 1 ? "hour ago" : "hours ago"
    }
    
    // Minute
    if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {
      
      return interval == 1 ? "minute ago" : "minutes ago"
    }
    
    return "just now"
  }
  
  func timeAgoSinceDate2() -> String {
    
    // From Time
    let fromDate = self
    
    // To Time
    let toDate = Date()
    
    
    
    // Year
    if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0  {
      
      return interval == 1 ? "\(interval)" + " " + "year" : "\(interval)" + " " + "years"
    }
    
    // Month
    if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0  {
      
      return interval == 1 ? "\(interval)" + " " + "month" : "\(interval)" + " " + "months"
    }
    
    // Day
    if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0  {
      
      return interval == 1 ? "\(interval)" + " " + "day" : "\(interval)" + " " + "days"
    }
    
    // Hours
    if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {
      
      return interval == 1 ? "\(interval)" + " " + "hour" : "\(interval)" + " " + "hours"
    }
    
    // Minute
    if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {
      
      return interval == 1 ? "\(interval)" + " " + "minute" : "\(interval)" + " " + "minutes"
    }
    
    return "just now"
  }
}


extension Date {
  var millisecondsSince1970:Int64 {
    return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
  }
  
  init(milliseconds:Int64) {
    self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
  }
}
