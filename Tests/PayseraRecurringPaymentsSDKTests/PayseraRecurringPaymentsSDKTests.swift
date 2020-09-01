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
        var object: Recurrence?
        let expectation = XCTestExpectation(description: "")

        apiClient
            .getRecurrence(id: "")
            .done { recurrence in
                object = recurrence
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }

        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testGetRecurrences() {
        var object: PSMetadataAwareResponse<Recurrence>?
        let expectation = XCTestExpectation(description: "")
        
        let filter = RecurrenceFilter()
        filter.accountNumbers = [""]
        apiClient
            .getRecurrences(filter: filter)
            .done { obj in
                object = obj
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }

        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testGetRecurrenceTransfers() {
        var object: PSMetadataAwareResponse<PSTransfer>?
        let expectation = XCTestExpectation(description: "")
        let filter = RecurrenceFilter()
        
        apiClient
            .getRecurrenceTransfers(id: "", filter: filter)
            .done { obj in
                object = obj
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }

        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testCreateRecurrence() {
        var object: Recurrence?
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
                object = obj
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testUpdateRecurrence() {
        var object: Recurrence?
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
            .updateRecurrence(id: "", recurrence: recurrence)
            .done { obj in
                object = obj
            }.catch { error in
                print(error)
            }.finally { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(object)
    }
    
    func testCancelRecurrence() {
        let expectation = XCTestExpectation(description: "")
            
        apiClient
            .cancelRecurrence(id: "")
            .done { _ in
                expectation.fulfill()
            }
            .catch { error in
                print(error)
            }
        
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testRepeatTransfer() {
        let expectation = XCTestExpectation(description: "")
        
        apiClient
            .repeatRecurrenceTransfer(recurrenceId: "", transferId: "")
            .done { _ in
                expectation.fulfill()
            }
            .catch { error in
                print(error)
            }
        
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testActivateRecurrence() {
        let expectation = XCTestExpectation(description: "")
        
        apiClient
            .activateRecurrence(id: "")
            .done { _ in
                expectation.fulfill()
            }
            .catch { error in
                print(error)
            }
        
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testDeactivateRecurrence() {
        let expectation = XCTestExpectation(description: "")
        
        apiClient
            .deactivateRecurrence(id: "")
            .done { _ in
                expectation.fulfill()
            }
            .catch { error in
                print(error)
            }
        
        wait(for: [expectation], timeout: 3.0)
    }
}
