import Foundation

public class IPData {
    
    public static var urlSession = URLSession.shared
    
    public static var apiKey: String?
    
    private init() {
    }
    
    @discardableResult
    public static func lookup(
        urlSession: URLSession = urlSession,
        apiKey: String? = apiKey,
        ip: String = "",
        completionHandler: @escaping (Result<IP>) -> Void
        ) -> URLSessionTask {
        var urlComponents = URLComponents(string: "https://api.ipdata.co/\(ip)")!
        urlComponents.queryItems = [
            URLQueryItem(name: "api-key", value: apiKey)
        ]
        let task = urlSession.dataTask(with: urlComponents.url!) { data, response, error in
            responseHandler(data: data, response: response, error: error, completionHandler: completionHandler)
        }
        task.resume()
        return task
    }
    
    @discardableResult
    public static func carrier(
        urlSession: URLSession = urlSession,
        apiKey: String? = apiKey,
        ip: String,
        completionHandler: @escaping (Result<Carrier>) -> Void
        ) -> URLSessionTask {
        var urlComponents = URLComponents(string: "https://api.ipdata.co/\(ip)/carrier")!
        urlComponents.queryItems = [
            URLQueryItem(name: "api-key", value: apiKey)
        ]
        let task = urlSession.dataTask(with: urlComponents.url!) { data, response, error in
            responseHandler(data: data, response: response, error: error, completionHandler: completionHandler)
        }
        task.resume()
        return task
    }
    
    @discardableResult
    public static func lookup(
        urlSession: URLSession = urlSession,
        apiKey: String? = apiKey,
        bulk ips: [String],
        completionHandler: @escaping (Result<[IP]>) -> Void
        ) -> URLSessionTask? {
        var urlComponents = URLComponents(string: "https://api.ipdata.co/bulk")!
        urlComponents.queryItems = [
            URLQueryItem(name: "api-key", value: apiKey)
        ]
        var request = URLRequest(url: urlComponents.url!)
        do  {
            request.httpMethod = "POST"
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONSerialization.data(withJSONObject: ips)
            let task = urlSession.dataTask(with: request) { data, response, error in
                responseHandler(data: data, response: response, error: error, completionHandler: completionHandler)
            }
            task.resume()
            return task
        } catch {
            completionHandler(.failure(error))
            return nil
        }
    }
    
    private static func responseHandler<SucessType>(
        data: Data?,
        response: URLResponse?,
        error: Error?,
        completionHandler: (Result<SucessType>) -> Void
        ) where SucessType: Decodable {
        if let error = error {
            completionHandler(.failure(error))
            return
        }
        guard let response = response as? HTTPURLResponse else {
            completionHandler(.failure(IPDataError.unknown))
            return
        }
        guard let statusCode = StatusCode(rawValue: response.statusCode), let data = data else {
            completionHandler(.failure(IPDataError.invalidResponse(statusCode: response.statusCode)))
            return
        }
        do {
            switch statusCode {
            case .ok:
                let ip = try JSONDecoder().decode(SucessType.self, from: data)
                completionHandler(.success(ip))
            case .badRequest,
                 .unauthorized,
                 .forbidden:
                if let json = try JSONSerialization.jsonObject(with: data) as? [String : Any],
                    let message = json["message"] as? String
                {
                    let error = IPDataError(statusCode: response.statusCode, message: message)
                    completionHandler(.failure(error))
                    return
                } else {
                    fallthrough
                }
            default:
                completionHandler(.failure(IPDataError.invalidResponse(statusCode: response.statusCode)))
            }
        } catch {
            completionHandler(.failure(error))
        }
    }
    
}
