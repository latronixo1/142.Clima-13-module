//
//  WeatherManager.swift
//  142.Clima-13-module
//
//  Created by Валентин Картошкин on 22.02.2025.
//

import Foundation
import UIKit
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    //базовый URL
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(Constants.id)&units=metric"
    
    //делегат, с помощью которого мы будем вызывать функкции в didUpdateWeather и didFailWithError и будем передвать в WeatherViewController модель weather типа WeatherModel
    var delegate: WeatherManagerDelegate?
    
    //две основные функции, при помощи которых мы будем получать нашу погоду
    
    //функция получения данных о погоде по имени города, которое пользователь ввел в поле поиска
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    //функция получения данных о погоде по геопозиции (ширине и долготе)
    func fetchWeather(latitide: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitide)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        //1. создаем URL
        guard let url = URL(string: urlString) else { return }
        
        //2. создаем URL сессию
        let session = URLSession(configuration: .default)   //инициализатор
        
        //3. создаем задание для URL сессии и сразу (в фигурных скобках) обработчик полученного результата
        //результатом сессии будет data, resonse и error
        let task = session.dataTask(with: url) { data, response, error in
            
            //если ошибка,
            if let error {      //равносильно опциональному связыванию "if let error = error {", то есть безопасно извлекаем опционал. Если в error оказался nil, содержимое фигурных скобок не выполнится
                //то вызываю функцию didFailWithError, которая определена в делегате (в нашем случае в WeatherViewController), и передаю туда ошибку error
                delegate?.didFailWithError(error: error)    //В идеале создать несколько функций didFailWithError, которые будут принимать ошибки разных типов (error, errorData и т.д.), чтобы обработать каждую ошибку по-разному. Но тут мы упростили.
                return
            }
            
            //безопасно извлекаю опциональные переменные data и parseJSON
            guard let safeData = data else  { return }
            guard let weather = parseJSON(safeData) else { return }
            delegate?.didUpdateWeather(weather: weather)
        }
        
        //4. Начало задания
        task.resume()
    }
    
    //преобразование (parse) из сырых полученных от сервера погоды данных в нашу модель WeatherModel
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            //пишем в консоль размер ответа в байтах (например, "weatherData: 498 bytes")
            print("weatherData: \(weatherData)")
            //безопасно извлекаем и пишем в консоль сырые полученные данные (например, "Response: {"coord":{"lon":-122.4064, "lat":37.7858},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":04n"}],"base":"stations","main":{"temp":11.9,"feel_like":11.42,"temp_min":10.19,"temp_max":13.44,"pressure":1012,"humidity":87},"visibility":10000,"wind":{"speed":9.83,"deg":315,"gust":12.07},"clouds":{"all":100},"dt":1688895767,"sys":{"type":2,"id":2007646,"country":"US","sunrise":1688907327,"sunset":1688960028},"timezonde":-25200,"id:5391959,"name":"San Francisco","cod":200}
            if let jsonResponse = String(data: weatherData, encoding: String.Encoding.utf8) {
                print("Response; \(jsonResponse)")
            }
            
            //пробуем (try) декодировать
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
//            let weather = WeatherModel(weatherData: decodedData)
            
            return weather
        } catch let error {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
