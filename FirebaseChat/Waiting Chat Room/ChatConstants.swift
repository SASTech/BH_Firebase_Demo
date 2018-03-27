

import UIKit

struct Constants {
 struct MessageFields {
    static let sender_name = "sender_name"
    static let message = "message"
    static let message_type = "message_type"
    static let sender_id = "sender_id"
    static let timestamp = "date"
    static let status = "status"
    static let downloadProgress = "downloadProgress"
  }
}

class ChatDateFormatter{
    
   func findDateOrTime(dateTimeString:Date,dateRequired:Bool,dateFormatForChat:String) -> String{
    
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = dateFormatForChat
        dateformatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        
        let convertedToDate = dateTimeString
        dateformatter.dateFormat = dateFormatForChat
        dateformatter.timeZone = NSTimeZone.local
        
        let convertedToRequiredString = dateformatter.string(from: convertedToDate)

         return convertedToRequiredString
    }
    
    
 }


