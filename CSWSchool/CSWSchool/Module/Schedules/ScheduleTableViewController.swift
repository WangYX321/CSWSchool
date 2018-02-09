//
//  ScheduleTableViewController.swift
//  CSWSchool
//
//  Created by wyx on 2018/1/20.
//  Copyright © 2018年 com.cswSchool. All rights reserved.
//

import UIKit

class ScheduleModel {
    var CourseTitle : String = ""
    
    var BuildingName : String = ""
    var RoomNumber : String = ""
    
    var Block : String = ""
    
    var MyDayStartTime : String = ""
    var MyDayEndTime : String = ""
    
    var Contact : String = ""
    
    var AttendanceDisplay : String = ""
    var AssociationId : Int = 0
    
    init(dic: [String:Any]) {
        if let str = dic["CourseTitle"] as? String {
            self.CourseTitle = str
        }
        if let str = dic["BuildingName"] as? String {
            self.BuildingName = str
        }
        if let str = dic["RoomNumber"] as? String {
            self.RoomNumber = str
        }
        if let str = dic["Block"] as? String {
            self.Block = str
        }
        if let str = dic["MyDayStartTime"] as? String {
            self.MyDayStartTime = str
        }
        if let str = dic["MyDayEndTime"] as? String {
            self.MyDayEndTime = str
        }
        if let str = dic["Contact"] as? String {
            self.Contact = str
        }
        if let str = dic["AttendanceDisplay"] as? String {
            self.AttendanceDisplay = str
        }
        if let str = dic["AssociationId"] as? Int {
            self.AssociationId = str
        }
    }
}

class ScheduleTableViewController: UITableViewController {

    var dataArray = [ScheduleModel]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.rowHeight = UITableViewAutomaticDimension
        let parameters = ["scheduleDate" : "", "personaId" : "2"]
        NetworkTools.requestData(.get, URLString: "https://csw.myschoolapp.com/api/schedule/MyDayCalendarStudentList/", parameters: parameters) { (result) in
            if let array = result as? [[String:Any]] {
                array.enumerated().forEach({ (offset, element) in
                    let model = ScheduleModel(dic: element)
                    self.dataArray.append(model)
                })
                print("Schedule Data", result)
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.dataArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCellId") as? ScheduleCell

        if cell == nil {
            cell = Bundle.main.loadNibNamed("ScheduleCell", owner: self, options: nil)?.last as? ScheduleCell
        }
        let model = self.dataArray[indexPath.row]
        cell?.timeLabel.text = model.MyDayStartTime + "~" + model.MyDayEndTime
        cell?.blockLabel.text = "block: " + model.Block
        cell?.courseTitleLabel.text = model.CourseTitle
        cell?.detailLabel.text = model.BuildingName + ", " + model.RoomNumber
        cell?.contactLabel.text = model.Contact

        return cell!
    }    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
