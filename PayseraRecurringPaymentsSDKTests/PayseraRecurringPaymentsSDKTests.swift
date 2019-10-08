import XCTest
import JWTDecode
import PayseraCommonSDK
import PayseraAccountsSDK
import PromiseKit

@testable import PayseraRecurringPaymentsSDK

class PayseraRecurringPaymentsSDKTests: XCTestCase {
    private var apiClient: RecurringPaymentsApiClient!
    
    override func setUp() {
        super.setUp()
        
        let token = "insert_me"
        
        let credentials = PSApiJWTCredentials()
        credentials.token = try! decode(jwt: token)
        
        apiClient = RecurringPaymentsApiClientFactory.createApiClient(credentials: credentials)
    }
    
    func testGetRecurrence() {
        let expectation = XCTestExpectation(description: "")

        apiClient
            .getRecurrence(id: 7)
            .done { obj in
                print(obj)
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }

        wait(for: [expectation], timeout: 3.0)
    }
    
    func testGetRecurrences() {
        let expectation = XCTestExpectation(description: "")
        
        let filter = RecurrenceFilter()
        apiClient
            .getRecurrences(filter: filter)
            .done { obj in
                print(obj)
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }

        wait(for: [expectation], timeout: 3.0)
    }
    
    func testGetRecurrenceTransfers() {
        let expectation = XCTestExpectation(description: "")
               
        let filter = RecurrenceFilter()
        
        apiClient
            .getRecurrenceTransfers(id: 7, filter: filter)
            .done { obj in
                print(obj.items)
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }

        wait(for: [expectation], timeout: 3.0)
    }
    
    func testCreateRecurrence() {
        let expectation = XCTestExpectation(description: "")
        
        let transfer = PSTransfer()
        transfer.amount = PSMoney(amount: "0.01", currency: "EUR")
        
        transfer.payer = PSTransferPayer()
        transfer.payer.accountNumber = "EVPXX"
        
        transfer.beneficiary = PSTransferBeneficiary()
        transfer.beneficiary?.name = "Name Surname"
        transfer.beneficiary?.type = "bank"
        transfer.beneficiary?.beneficiaryBankAccount = PSTransferBeneficiaryBankAccount()
        transfer.beneficiary?.beneficiaryBankAccount?.iban = "LTXX"
        
        transfer.purpose = PSTransferPurpose()
        transfer.purpose?.details = "Top Up"
        
        let recurrence = Recurrence()
        recurrence.type = RecurrenceType.weekly.description
        recurrence.dayOfWeek = 3
        recurrence.transfer = transfer
            
        apiClient
            .createRecurrence(recurrence)
            .done { obj in
                print(obj)
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testUpdateRecurrence() {
        let expectation = XCTestExpectation(description: "")
            
        let transfer = PSTransfer()
        transfer.amount = PSMoney(amount: "0.02", currency: "EUR")
        
        transfer.payer = PSTransferPayer()
        transfer.payer.accountNumber = "EVPXX"
        
        transfer.beneficiary = PSTransferBeneficiary()
        transfer.beneficiary?.name = "Name Surname"
        transfer.beneficiary?.type = "bank"
        transfer.beneficiary?.beneficiaryBankAccount = PSTransferBeneficiaryBankAccount()
        transfer.beneficiary?.beneficiaryBankAccount?.iban = "LTXX"
        
        transfer.purpose = PSTransferPurpose()
        transfer.purpose?.details = "Top Up"
        
        let recurrence = Recurrence()
        recurrence.type = RecurrenceType.weekly.description
        recurrence.dayOfWeek = 3
        recurrence.transfer = transfer
        
        apiClient
            .updateRecurrence(id: 7, recurrence: recurrence)
            .done { obj in
                print(obj)
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testCancelRecurrence() {
        let expectation = XCTestExpectation(description: "")
            
        apiClient
            .cancelRecurrence(id: 10)
            .done { _ in
                print("Canceled")
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 3.0)
    }
}
