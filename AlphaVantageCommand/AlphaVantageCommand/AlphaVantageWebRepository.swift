import Foundation
import Combine

protocol AlphaVantageWebRepository: WebRepository {
    func loadDividends(_ ticker: Ticker) -> AnyPublisher<MonthlyAdjustedTimeSeries, Error>
    func loadLatestPrice(_ ticker: Ticker) -> AnyPublisher<DailyPrice, Error>
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
    
    func loadLatestPrice(_ ticker: Ticker) -> AnyPublisher<DailyPrice, Error> {
        call(endpoint: API.loadLatestPrice(ticker))
    }
}

extension AlphaVantageWebService {
    enum API {
        case loadDividends(String)
        case loadLatestPrice(String)
    }
}

extension AlphaVantageWebService.API: APICall {
    var path: String {
        switch self {
        case .loadDividends(let ticker):
            return "/query?function=TIME_SERIES_MONTHLY_ADJUSTED&symbol=\(ticker)&apikey=WIN4ZCY6VUPIHEB9"
        case .loadLatestPrice(let ticker):
            return "/query?function=TIME_SERIES_DAILY&symbol=\(ticker)&apikey=WIN4ZCY6VUPIHEB9"
        }
    }
    
    var method: String {
        "GET"
    }
    
    var headers: [String : String]? {
        nil
    }
    
    func body() throws -> Data? {
        nil
    }
}
