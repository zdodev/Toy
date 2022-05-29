import Foundation
import Combine

typealias Ticker = String
private var cancellables = Set<AnyCancellable>()

struct View {
    let date: String
    let dividend: String
}

var views = [View]() {
    didSet {
        print(views)
    }
}

let url = "https://www.alphavantage.co"
let a = AlphaVantageWebService(session: URLSession.shared, baseURL: url)

a.loadLatestPrice("BST")
    .sink { result in
        switch result {
        case .failure(let error):
            print(error)
        case .finished:
            print("finished")
        }
    } receiveValue: { value in
        let s = value.daily.stockDatas.sorted { lhs, rhs in
            lhs.date < rhs.date
        }
        print(s)
    }
    .store(in: &cancellables)


//a.loadDividends("BST")
//    .sink { result in
//        switch result {
//        case .failure(let error):
//            print(error)
//        case .finished:
//            print("finished")
//        }
//    } receiveValue: { value in
//        views = value.monthly.stockDatas
//            .sorted { lhs, rhs in
//                lhs.date < rhs.date
//            }
//            .map { stockData in
//            View(date: stockData.date, dividend: stockData.dividend)
//        }
//    }
//    .store(in: &cancellables)

RunLoop.main.run()
