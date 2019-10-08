import Foundation
import PayseraCommonSDK
import ObjectMapper

public class RecurrenceFilter: PSBaseFilter {
    public var id: Int?
    public var recurrenceType: String?
    public var transferType: String?
    public var dayOfWeek: Int?
    public var dayOfMonth: Int?
    public var senderCovenanteeId: Int?
    public var senderAccountNumber: String?
    
    override open func mapping(map: Map) {
        super.mapping(map: map)
        
        id                  <- map["id"]
        recurrenceType      <- map["recurrence_type"]
        transferType        <- map["transfer_type"]
        dayOfWeek           <- map["day_of_week"]
        dayOfMonth          <- map["day_of_month"]
        senderCovenanteeId  <- map["sender_covenantee_id"]
        senderAccountNumber <- map["sender_account_number"]
    }

}
