import Foundation

struct DailyPrice: Decodable {
    let metaData: MetaData
    let daily: Daily
    
    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case daily = "Time Series (Daily)"
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
            case timeZone = "5. Time Zone"
        }
    }
    
    struct Daily: Decodable {
        struct StockData {
            let date: String
            let open: String
            let high: String
            let low: String
            let close: String
            let volume: String
        }
        
        var stockDatas: [StockData] = []
        
        init(_ stockDatas: [StockData]) {
            self.stockDatas = stockDatas
        }
        
        struct StockKey: CodingKey {
            var stringValue: String
            init?(stringValue: String) {
                self.stringValue = stringValue
            }
            
            var intValue: Int? { nil }
            init?(intValue: Int) { nil }
            
            static let open = StockKey(stringValue: "1. open")!
            static let high = StockKey(stringValue: "2. high")!
            static let low = StockKey(stringValue: "3. low")!
            static let close = StockKey(stringValue: "4. close")!
            static let volume = StockKey(stringValue: "5. volume")!
        }
            
        init(from decoder: Decoder) throws {
            var stockDatas = [StockData]()
            let container = try decoder.container(keyedBy: StockKey.self)
            for key in container.allKeys {
                let productContainer = try container.nestedContainer(keyedBy: StockKey.self, forKey: key)
                let open = try productContainer.decode(String.self, forKey: .open)
                let high = try productContainer.decode(String.self, forKey: .high)
                let low = try productContainer.decode(String.self, forKey: .low)
                let close = try productContainer.decode(String.self, forKey: .close)
                let volume = try productContainer.decode(String.self, forKey: .volume)
                
                let stockData = StockData(
                    date: key.stringValue,
                    open: open,
                    high: high,
                    low: low,
                    close: close,
                    volume: volume
                )
                stockDatas.append(stockData)
            }
            
            self.init(stockDatas)
        }
    }
}
