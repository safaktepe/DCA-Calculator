//
//  APIService.swift
//  DCA-Calculator
//
//  Created by Mert Şafaktepe on 5.09.2022.
//

import Foundation
import Combine

struct APIService {
    
    // The reason why I used 3 differents API keys is because of free version of API has a
    // limit for requests.
    
    var API_KEY: String {
        return keys.randomElement() ?? ""
    }
    
    let keys = ["KWBF6KU1RFJDID5R" , "8R6IO1LL523DC1MV", "EGVQYPN01UGQTUTD"]
    
    func fetchSymbolsPublisher(keywords: String) -> AnyPublisher<SearchResults, Error> {
        let urlString = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(keywords)&apikey=\(API_KEY)"
        let url = URL(string: urlString)!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: SearchResults.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
    }
    
    
}
