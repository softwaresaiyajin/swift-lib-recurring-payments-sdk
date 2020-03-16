import Foundation
import Alamofire
import PayseraCommonSDK

public enum RecurringPaymentsApiRequestRouter: URLRequestConvertible {
    static var baseURLString = "https://recurring-payments.paysera.com/recurrence/rest/v1"
    
    // MARK: - GET
    case getRecurrence(id: String)
    case getRecurrences(filter: RecurrenceFilter)
    case getRecurrenceTransfers(id: String, filter: PSBaseFilter)
    
    // MARK: - POST
    case createRecurrence(recurrence: Recurrence)
    case repeatRecurrenceTransfer(recurrenceId: String, transferId: String)
    
    // MARK: - PUT
    case updateRecurrence(id: String, recurrence: Recurrence)
    case activateRecurrence(id: String)
    case deactivateRecurrence(id: String)
    
    // MARK: - DELETE
    case cancelRecurrence(id: String)
    
    private var method: HTTPMethod {
        switch self {
            case .getRecurrence,
                 .getRecurrences,
                 .getRecurrenceTransfers:
                return .get
            
            case .createRecurrence,
                 .repeatRecurrenceTransfer:
                return .post
            
            case .updateRecurrence,
                 .activateRecurrence,
                 .deactivateRecurrence:
                return .put
            
            case .cancelRecurrence:
                return .delete
        }
    }
    
    private var path: String {
        switch self {
            case .getRecurrence(let id):
                return "/recurrences/\(id)"
         
            case .getRecurrences(_):
                return "/recurrences"
            
            case .getRecurrenceTransfers(let id, _):
                return "/recurrences/\(id)/transfers"
            
            case .createRecurrence(_):
                return "/recurrences"
            
            case let .repeatRecurrenceTransfer(recurrenceId, transferId):
                return "/recurrences/\(recurrenceId)/transfers/\(transferId)/repeat"
            
            case .updateRecurrence(let id, _):
                return "/recurrences/\(id)"
            
            case .activateRecurrence(let id):
                return "/recurrences/\(id)/activate"
            
            case .deactivateRecurrence(id: let id):
                return "/recurrences/\(id)/deactivate"
            
            case .cancelRecurrence(let id):
                return "/recurrences/\(id)"
        }
    }
    
    private var parameters: Parameters? {
        switch self {
            case .getRecurrences(let filter):
                return filter.toJSON()
            
            case .getRecurrenceTransfers(_, let filter):
                return filter.toJSON()
            
            case .createRecurrence(let recurrence):
                return recurrence.toJSON()
            
            case .updateRecurrence(_, let recurrence):
                return recurrence.toJSON()
            
            default:
                return nil
        }
    }
    
    // MARK: - Method
    public func asURLRequest() throws -> URLRequest {
        let url = try! RecurringPaymentsApiRequestRouter.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
            case (_) where method == .get:
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            
            case (_) where method == .post:
                urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            
            case (_) where method == .put:
                urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            
            default:
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
