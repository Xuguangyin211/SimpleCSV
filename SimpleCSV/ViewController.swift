//
//  ViewController.swift
//  SimpleCSV
//
//  Created by xuguangyin on 2022/4/20.
//

import UIKit

class User {
    var userid: String = ""
    var name:String = ""
    var email:String = ""
    var isValidUser:Bool = false
    var message:String = ""
    var balance:Double = 0.0
}

class RowNum {
    var a: String = ""
    var b: String = ""
    var c: String = ""
    var d: String = ""
    var e: String = ""
    var f: String = ""
    var g: String = ""
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let paths = ["1", "2", "3"];
        let objects = ["a", "b", "c", "d"];

        let data:NSMutableArray  = NSMutableArray()

        var leftPaths = paths
        var leftWidgets = objects
        let empty = " "
        let emptyData = ["a": empty, "b": empty, "c": empty, "d": empty, "e": empty, "f": empty, "g": empty]

        //path
        let fileName = "aaa: " + "|" + currentTime()
        let nameFirst = ["a": empty, "b": fileName, "c": empty, "d": empty, "e": empty, "f": empty, "g": empty]
        let pathData = ["a": "Path Data", "b": empty, "c": empty, "d": empty, "e": empty, "f": empty, "g": empty]
        let pathDetail = ["a": "Path Name", "b": "Area", "c": "Perimeter", "d": "Measurements", "e": empty, "f": empty, "g": empty]
        data.add(nameFirst)
        data.add(pathData)
        data.add(pathDetail)
        while true {
            if let firPath = leftPaths.first {
                let daee = ["a": empty, "b": empty, "c": firPath, "d": empty, "e": empty, "f": empty, "g": empty]
                data.add(daee)
                //第一个数据
                leftPaths.removeFirst()
                if leftPaths.count == 0 {
                    //加一行空的
                    data.add(emptyData)
                }
                continue
            } else if paths.count == 0 {
                //加上object的
            }
            break
        }

        let objectData = ["a": "Object Data", "b": empty, "c": empty, "d": empty, "e": empty, "f": empty, "g": empty]
        let objectDetail = ["a": "Object Name", "b": "Area", "c": "Perimeter", "d": "Measurements", "e": empty, "f": empty, "g": empty]
        data.add(nameFirst)
        data.add(objectData)
        data.add(objectDetail)
        while true {
            if let firObj = leftWidgets.first {
                //计算
                let daee = ["a": empty, "b": empty, "c": firObj, "d": empty, "e": empty, "f": empty, "g": empty]
                data.add(daee)
                leftWidgets.removeFirst()
                if leftWidgets.count == 0 {
                    //加上空行
                    data.add(emptyData)
                }
                continue
            } else if objects.count == 0 {
                //estimor
            }
            break
        }

        let estData = ["a": "Object Data", "b": empty, "c": empty, "d": empty, "e": empty, "f": empty, "g": empty]
        let estDetail = ["a": "Object Name", "b": "Area", "c": "Perimeter", "d": "Measurements", "e": empty, "f": empty, "g": empty]
        data.add(nameFirst)
        data.add(estData)
        data.add(estDetail)

        let user3 = RowNum()
        user3.a = " "
        user3.b = "John"
        user3.c = "John@gmail.com"
        user3.d = "true"
        user3.e = "Hi 'John!'; \nHow are you? \t Shall we meet tomorrow? \r Thanks "
        user3.f = "105.41"
        user3.g = "ss"
        data.add(listPropertiesWithValues(user3))

        let header = ["a", "b", "c", "d","e","f","g"]
        // Create a object for write CSV
        let writeCSVObj = CSV()
        writeCSVObj.rows = data
        writeCSVObj.delimiter = DividerType.comma.rawValue
        writeCSVObj.fields = header as NSArray
        writeCSVObj.name = "userlist"

        // Write File using CSV class object
        let output = CSVExport.export(writeCSVObj);
        if output.result.isSuccess {
            guard let filePath =  output.filePath else {
                print("Export Error: \(String(describing: output.message))")
                return
            }
            print("File Path: \(filePath)")
            self.readCSVPath(filePath)
        } else {
            print("Export Error: \(String(describing: output.message))")
        }
    }

    func readCSVPath(_ filePath: String) {
        _ = NSURLRequest(url:  URL(fileURLWithPath: filePath) )
        // Read File and convert as CSV class object
        _ = CSVExport.readCSVObject(filePath);
        
        // Use 'SwiftLoggly' pod framework to print the Dictionary
//        loggly(LogType.Info, text: readCSVObj.name)
//        loggly(LogType.Info, text: readCSVObj.delimiter)
    }

    func currentTime() -> String {
        let date = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yy/MM/dd"
        return timeFormatter.string(from: date)
    }
}
