//
//  Date+Extensions.swift
//  TodoList
//
//  Created by George Prokopenko on 3/17/20.
//

import Foundation

enum WeekDay: Int, CaseIterable {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday

    var shortDescription: String {
        switch self {
        // TODO: Localize
        case .sunday: return "Sun"
        case .monday: return "Mon"
        case .tuesday: return "Tue"
        case .wednesday: return "Wed"
        case .thursday: return "Thu"
        case .friday: return "Fri"
        case .saturday: return "Sat"
        }
    }

    var weekDayComponent: Int {
        rawValue + 1
    }

    init?(weekDayComponent: Int) {
        let index = (weekDayComponent != 0 ? weekDayComponent : WeekDay.allCases.count) - 1
        self.init(rawValue: index)
    }

    init?(buttonIndex: Int, calendar: Calendar) {
        let index = calendar.firstWeekday
        let weekDayIndex = -1 + index + buttonIndex
        self.init(rawValue: weekDayIndex < WeekDay.allCases.count ? weekDayIndex : 0)
    }
}

extension Date {
    static var startOfAnyMonth: Date {
        var components = DateComponents()
        components.year = 1970
        components.month = 1
        components.day = 1
        return Calendar.current.date(from: components)!
    }

    static var endOfAnyMonth: Date {
        var components = DateComponents()
        components.year = 1970
        components.month = 1
        components.day = 31
        return Calendar.current.date(from: components)!
    }

    static func anyDate(for day: Int) -> Date {
        var components = DateComponents()
        components.year = 1970
        components.month = 1
        components.day = day
        return Calendar.current.date(from: components)!
    }

    static var startOfDay: Date {
        return Calendar.current.startOfDay(for: Date())
    }

    static var startOfWeek: Date? {
        let calendar = Calendar.current
        guard let sunday = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear],
                                                                       from: Date())) else { return nil }
        return calendar.date(byAdding: .day, value: 1, to: sunday)
    }

    static var startOfNextWeek: Date? {
        let calendar = Calendar.current
        guard let endOfWeek = Date.endOfWeek else { return nil }
        return calendar.date(byAdding: .day, value: 1, to: endOfWeek)
    }

    static var tomorrow: Date? {
        Calendar.current.date(byAdding: .day, value: 1, to: Date())
    }

    static var afterTomorrow: Date? {
        Calendar.current.date(byAdding: .day, value: 2, to: Date())
    }

    var minute: Int {
        Calendar.current.component(.minute, from: self)
    }

    var hour: Int {
        Calendar.current.component(.hour, from: self)
    }

    var day: Int {
        Calendar.current.component(.day, from: self)
    }

    var month: Int {
        Calendar.current.component(.month, from: self)
    }

    var year: Int {
        Calendar.current.component(.year, from: self)
    }

    static var endOfWeek: Date? {
        var components = DateComponents()
        components.day = 8
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }

    func byAddingYear(_ year: Int) -> Date {
        var components = DateComponents()
        components.year = year
        return Calendar.current.date(byAdding: components, to: Date())!
    }

    func byAddingDay(_ day: Int) -> Date {
        var components = DateComponents()
        components.day = day
        return Calendar.current.date(byAdding: components, to: self)!
    }

    func byAddingWeek() -> Date {
        var components = DateComponents()
        components.weekday = 7
        return Calendar.current.date(byAdding: components, to: self)!
    }

    func bySubtractingWeek() -> Date {
        var components = DateComponents()
        components.weekday = -7
        return Calendar.current.date(byAdding: components, to: self)!
    }

    func byAddingYear() -> Date {
        var components = DateComponents()
        components.year = 1
        return Calendar.current.date(byAdding: components, to: self)!
    }

    func byAddingHours(_ hours: Int) -> Date {
        var components = DateComponents()
        components.hour = hours
        return Calendar.current.date(byAdding: components, to: self)!
    }

    func byAddingMinutes(_ minutes: Int) -> Date {
        var components = DateComponents()
        components.minute = minutes
        return Calendar.current.date(byAdding: components, to: self)!
    }

    static func dateByAddingMilliseconds(_ milliseconds: Int) -> Date {
        var components = DateComponents()
        components.second = milliseconds / 1000
        return Calendar.current.date(byAdding: components, to: Date())!
    }

    var isTodayOrEarlier: Bool {
        Calendar.current.isDate(self, inSameDayAs: Date()) || self <= Date()
    }

    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }

    var isTomorrow: Bool {
        Calendar.current.isDateInTomorrow(self)
    }

    var isYesterday: Bool {
        Calendar.current.isDateInYesterday(self)
    }

    var isWithinWeek: Bool {
        if let endOfWeek = Date.endOfWeek,
           !isTodayOrEarlier,
           !isTomorrow,
           self > Date(),
           self < endOfWeek {
            return true
        } else {
            return false
        }
    }

    var previousMonth: Date? {
        Calendar.current.date(byAdding: .month, value: -1, to: self)
    }

    var nextMonth: Date? {
        Calendar.current.date(byAdding: .month, value: 1, to: self)
    }

    var isLaterThanCurrentWeek: Bool {
        if let endOfWeek = Date.endOfWeek, self > endOfWeek {
            return true
        } else {
            return false
        }
    }

    var shortHourMinuteString: String {
        let hourString = hour < 10 ? "0\(hour)" : "\(hour)"
        let minuteString = minute < 10 ? "0\(minute)" : "\(minute)"
        return "\(hourString):\(minuteString)"
    }

    var weekDay: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: self)
    }

    var shortDateString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "dd MMM"
        return formatter.string(from: self)
    }

    var fullDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: self)
    }

    static func dateFromFullString(_ string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.calendar = Calendar.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: string)
    }

    var dateDashString: String {
        let day = Calendar.current.component(.day, from: self)
        let month = Calendar.current.component(.month, from: self)
        let year = Calendar.current.component(.year, from: self)
        return "\(day)-\(month)-\(year)"
    }

    var dateSlashString: String {
        DateFormatter.YYYYMMdd.string(from: self)
    }
}
