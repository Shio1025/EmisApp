//
//  Formatter.swift
//  Core
//
//  Created by Shio Birbichadze on 20.06.23.
//



public final class Formatter {
    
    public static func formatNumber(number: Double) -> String  {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.groupingSeparator = ","
        numberFormatter.decimalSeparator = "."

        if let formattedString = numberFormatter.string(from: NSNumber(value: number)) {
            return formattedString
        }
        
        return ""
    }
    
    public static func formatDateToString(date: Date) -> String {
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "dd-MM-yyyy"
       return dateFormatter.string(from: date)
   }
}
