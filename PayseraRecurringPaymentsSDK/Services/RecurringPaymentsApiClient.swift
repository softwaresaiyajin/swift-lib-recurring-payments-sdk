import Foundation
import Alamofire
import PromiseKit
import ObjectMapper
import PayseraCommonSDK
import PayseraAccountsSDK

public class RecurringPaymentsApiClient: PSBaseApiClient {
    public func getRecurrence(id: Int) -> Promise<Recurrence> {
        return doRequest(requestRouter: RecurringPaymentsApiRequestRouter.getRecurrence(id: id))
    }
    
    public func getRecurrences(filter: RecurrenceFilter) -> Promise<PSMetadataAwareResponse<Recurrence>> {
        return doRequest(requestRouter: RecurringPaymentsApiRequestRouter.getRecurrences(filter: filter))
    }
    
    public func createRecurrence(_ recurrence: Recurrence) -> Promise<Recurrence> {
        return doRequest(requestRouter: RecurringPaymentsApiRequestRouter.createRecurrence(recurrence: recurrence))
    }
    
    public func updateRecurrence(id: Int, recurrence: Recurrence) -> Promise<Recurrence> {
        return doRequest(requestRouter: RecurringPaymentsApiRequestRouter.updateRecurrence(id: id, recurrence: recurrence))
    }
    
    public func getRecurrenceTransfers(id: Int, filter: RecurrenceFilter) -> Promise<PSMetadataAwareResponse<PSTransfer>> {
        return doRequest(requestRouter: RecurringPaymentsApiRequestRouter.getRecurrenceTransfers(id: id, filter: filter))
    }
    
    public func cancelRecurrence(id: Int) -> Promise<Void> {
        return doRequest(requestRouter: RecurringPaymentsApiRequestRouter.cancelRecurrence(id: id))
    }
}
