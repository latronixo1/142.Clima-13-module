//
//  WeatherModel.swift
//  142.Clima-13-module
//
//  Created by Валентин Картошкин on 22.02.2025.
//

import Foundation

//модель данных, В КОТОРУЮ будем преобразовывать полученные от сервера сырые данные
struct WeatherModel {
    //следующие три переменные содержатся в ответе сервера
    let conditionId: Int
    let cityName: String    //город
    let temperature: Double //температура
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    //в зависимости от id в этой переменной будет текст иконки, которую нужно отобразить (снег, дождь, облачно, солнце и т.д.)
    var getConditionName: String {
        switch conditionId {
        case 200...232: return "cloud.bolt"     //облачно
        case 300...321: return "cloud.drizzle"  //мелкий дождь
        case 500...521: return "cloud.rain"     //дождь
        case 600...622: return "cloud.snow"     //снег
        case 700...781: return "cloud.fog"      //туман
        case 800: return "sun.max"              //солнечно
        case 801...804: return "cloud.bolt"     //облачно
        default: return "cloud"                 //облако
        }
    }
    
//    init(conditionID: Int, cityName: String, tempature: Double) {
//        self.conditionId = conditionID
//        self.cityName = cityName
//        self.temperature = temperature
//    }
//    
//    init(weatherData; WeatherData) {
//        self.conditionId = weatherData.weather[0].id
//        self.cityName = weatherData.name
//        self.temperature = weatherData.main.temperature
//    }
}
