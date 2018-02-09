//
//  NewsTableViewController.swift
//  CSWSchool
//
//  Created by wyx on 2018/1/20.
//  Copyright © 2018年 com.cswSchool. All rights reserved.
//

import UIKit

extension Array {
    
    // 去重
    func filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            }
        }
        return result
    }
}

extension String {
    //返回字数
    var count: Int {
        let string_NS = self as NSString
        return string_NS.length
    }
    
    //使用正则表达式替换
    func pregReplace(pattern: String, with: String,
                     options: NSRegularExpression.Options = []) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: self, options: [],
                                              range: NSMakeRange(0, self.count),
                                              withTemplate: with)
    }
}

class NewsModel: CustomStringConvertible {
    
    let Id: Int
    let Name: String
    let PublishDateLong: String
    let BriefDescription: String
    
    init(_ dic: [String:Any]) {
        self.Id = dic["Id"] as! Int
        self.Name = dic["Name"] as! String
        self.PublishDateLong = dic["PublishDateLong"] as! String
        
//        </?[^>]+>
        let str = dic["BriefDescription"] as! String
        let newStr = str.pregReplace(pattern: "</?[^>]+>", with: "")
        self.BriefDescription = newStr
    }
    
    var description: String {
        return Name
    }
}

class NewsTableViewController: UITableViewController {
    var dataArray = [NewsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        NetworkTools.requestData(.get, URLString: "https://csw.myschoolapp.com/api/News/FeaturedNewsGet/?format=json") { (result) in
//            print(result)
            if let array = result as? [[String:Any]] {
                var tempArray = [NewsModel]()
                for item in array {
                    let model = NewsModel(item)
                    tempArray.append(model)
                }
                let filterArrays = tempArray.filterDuplicates({$0.Id})
                print(filterArrays)
                self.dataArray += filterArrays
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewsDetailViewController()
        vc.Id = "\(self.dataArray[indexPath.row].Id)"
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
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
        var cell = tableView.dequeueReusableCell(withIdentifier: "NewsCellId") as? NewsCell

        // Configure the cell...
        if cell == nil {
            cell = Bundle.main.loadNibNamed("NewsCell", owner: self, options: nil)?.last as? NewsCell
        }
        
        let model = self.dataArray[indexPath.row]
        cell?.dateLabel.text = model.PublishDateLong
        cell?.titleLabel.text = model.Name
        cell?.contentLabel.text = model.BriefDescription

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
