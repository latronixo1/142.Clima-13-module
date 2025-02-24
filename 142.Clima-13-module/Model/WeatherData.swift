//
//  WeatherData.swift
//  142.Clima-13-module
//
//  Created by Валентин Картошкин on 22.02.2025.
//

import Foundation

//структура, В ЭКЗЕМПЛЯР будем помещать Response - сырые результаты запроса с сайта openweathermap.org. Важно, чтобы свойства этой структуры в точности соответствовали переменным, полученным в сыром ответе
struct WeatherData: Codable {
    //название города (населенного пункта)
    let name: String
    //часть кода, именуемая как main
    let main: Main
    //часть кода, именуемая как weather
    let weather: [Weather]
}

//из части кода main нам нужна только переменная temp (температура)
struct Main: Codable {
    let temp: Double
}

//из части кода Weather (представленной в виде массива) нам нужна только переменная id осадков (по этому идентификатору будем определять, какую иконку будем отображать (облако, дождь, солнце, снег и т.д.)
struct Weather: Codable {
    let id: Int
}
