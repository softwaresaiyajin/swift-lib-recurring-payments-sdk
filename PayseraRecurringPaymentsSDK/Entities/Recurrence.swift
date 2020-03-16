import ObjectMapper
import PayseraCommonSDK
import PayseraAccountsSDK
 
public class Recurrence: Mappable {
    public var id: String!
    public var active: Bool!
    public var status: String!
    public var type: String!
    public var transferType: String!
    public var createdAt: Date!
    public var transfer: PSTransfer!
    public var dayOfWeek: Int?
    public var dayOfMonth: Int?
    
    public init() {}
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        id              <- map["hash"]
        active          <- map["active"]
        status          <- map["status"]
        type            <- map["recurrence_type"]
        transferType    <- map["transfer_type"]
        transfer        <- map["transfer_data"]
        createdAt       <- (map["created_at"], DateTransform())
        dayOfWeek       <- map["day_of_week"]
        dayOfMonth      <- map["day_of_month"]
    }
}

public enum RecurrenceType: CustomStringConvertible {
    case daily
    case weekly
    case monthly

    public var description: String {
        switch self {
        case .daily: return "daily"
        case .weekly: return "weekly"
        case .monthly: return "monthly"
        }
    }
}
