import Foundation
import Alamofire
import PayseraCommonSDK

public enum RecurringPaymentsApiRequestRouter: URLRequestConvertible {
    static var baseURLString = "https://recurring-payments.paysera.com/recurrence/rest/v1"
    
    // MARK: - GET
    case getRecurrence(id: Int)
    case getRecurrences(filter: RecurrenceFilter)
    case getRecurrenceTransfers(id: Int, filter: PSBaseFilter)
    
    // MARK: - POST
    case createRecurrence(recurrence: Recurrence)
    
    // MARK: - PUT
    case updateRecurrence(id: Int, recurrence: Recurrence)
    
    // MARK: - DELETE
    case cancelRecurrence(id: Int)
    
    private var method: HTTPMethod {
        switch self {
            case .getRecurrence(_):
                return .get
            case .getRecurrences(_):
                return .get
            case .getRecurrenceTransfers(_, _):
                return .get
            
            case .createRecurrence(_):
                return .post
            
            case .updateRecurrence(_, _):
                return .put
            
            case .cancelRecurrence(_):
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
            
            case .updateRecurrence(let id, _):
                return "/recurrences/\(id)"
            
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
