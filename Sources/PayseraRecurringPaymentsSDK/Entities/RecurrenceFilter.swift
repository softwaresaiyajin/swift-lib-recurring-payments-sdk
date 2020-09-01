import Foundation
import PayseraCommonSDK
import ObjectMapper

public class RecurrenceFilter: PSBaseFilter {
    public var id: String?
    public var recurrenceType: String?
    public var transferType: String?
    public var dayOfWeek: Int?
    public var dayOfMonth: Int?
    public var accountNumbers: [String] = []
    
    override open func mapping(map: Map) {
        super.mapping(map: map)
        
        id                  <- map["hash"]
        recurrenceType      <- map["recurrence_type"]
        transferType        <- map["transfer_type"]
        dayOfWeek           <- map["day_of_week"]
        dayOfMonth          <- map["day_of_month"]
        accountNumbers      <- map["account_numbers"]
    }

}
