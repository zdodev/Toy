import Foundation
import Combine

protocol AlphaVantageWebRepository: WebRepository {
    func loadDividends(_ ticker: Ticker) -> AnyPublisher<MonthlyAdjustedTimeSeries, Error>
}

struct AlphaVantageWebService: AlphaVantageWebRepository {
    let session: URLSession
    let baseURL: String
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func loadDividends(_ ticker: Ticker) -> AnyPublisher<MonthlyAdjustedTimeSeries, Error> {
        call(endpoint: API.loadDividends(ticker))
    }
}

extension AlphaVantageWebService {
    enum API {
        case loadDividends(String)
    }
}

extension AlphaVantageWebService.API: APICall {
    var path: String {
        switch self {
        case .loadDividends(let ticker):
            return "/query?function=TIME_SERIES_MONTHLY_ADJUSTED&symbol=\(ticker)&apikey=WIN4ZCY6VUPIHEB9"
        }
    }
    
    var method: String {
        switch self {
        case .loadDividends:
            return "GET"
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    func body() throws -> Data? {
        nil
    }
}
