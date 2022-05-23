import Foundation
struct MonthlyAdjustedTimeSeries: Decodable {
    let metaData: MetaData
    let monthly: Monthly
    
    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case monthly = "Monthly Adjusted Time Series"
    }
    
    struct MetaData: Decodable {
        let information: String
        let symbol: String
        let lastRefreshed: String
        let timeZone: String
        
        enum CodingKeys: String, CodingKey {
            case information = "1. Information"
            case symbol = "2. Symbol"
            case lastRefreshed = "3. Last Refreshed"
            case timeZone = "4. Time Zone"
        }
    }
    
    struct Monthly: Decodable {
//        let data: Data
    }
}
