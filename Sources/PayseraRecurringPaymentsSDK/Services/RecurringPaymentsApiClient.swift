import Foundation
import Alamofire
import PromiseKit
import ObjectMapper
import PayseraCommonSDK
import PayseraAccountsSDK

public class RecurringPaymentsApiClient: PSBaseApiClient {
    public func getRecurrence(id: String) -> Promise<Recurrence> {
        return doRequest(requestRouter: RecurringPaymentsApiRequestRouter.getRecurrence(id: id))
    }
    
    public func getRecurrences(filter: RecurrenceFilter) -> Promise<PSMetadataAwareResponse<Recurrence>> {
        return doRequest(requestRouter: RecurringPaymentsApiRequestRouter.getRecurrences(filter: filter))
    }
    
    public func createRecurrence(_ recurrence: Recurrence) -> Promise<Recurrence> {
        return doRequest(requestRouter: RecurringPaymentsApiRequestRouter.createRecurrence(recurrence: recurrence))
    }
    
    public func updateRecurrence(id: String, recurrence: Recurrence) -> Promise<Recurrence> {
        return doRequest(requestRouter: RecurringPaymentsApiRequestRouter.updateRecurrence(id: id, recurrence: recurrence))
    }
    
    public func getRecurrenceTransfers(id: String, filter: RecurrenceFilter) -> Promise<PSMetadataAwareResponse<PSTransfer>> {
        return doRequest(requestRouter: RecurringPaymentsApiRequestRouter.getRecurrenceTransfers(id: id, filter: filter))
    }
    
    public func cancelRecurrence(id: String) -> Promise<Void> {
        return doRequest(requestRouter: RecurringPaymentsApiRequestRouter.cancelRecurrence(id: id))
    }
    
    public func repeatRecurrenceTransfer(recurrenceId: String, transferId: String) -> Promise<Void> {
        doRequest(requestRouter: RecurringPaymentsApiRequestRouter.repeatRecurrenceTransfer(recurrenceId: recurrenceId, transferId: transferId))
    }
    
    public func activateRecurrence(id: String) -> Promise<Void> {
        doRequest(requestRouter: RecurringPaymentsApiRequestRouter.activateRecurrence(id: id))
    }
    
    public func deactivateRecurrence(id: String) -> Promise<Void> {
        doRequest(requestRouter: RecurringPaymentsApiRequestRouter.deactivateRecurrence(id: id))
    }
}
