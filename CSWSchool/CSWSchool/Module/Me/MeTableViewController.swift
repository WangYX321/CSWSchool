//
//  MeTableViewController.swift
//  CSWSchool
//
//  Created by wyx on 2018/1/20.
//  Copyright © 2018年 com.cswSchool. All rights reserved.
//

import UIKit
import SDWebImage

class MeTableViewController: UITableViewController {
    @IBOutlet weak var backImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        NetworkTools.requestData(.get, URLString: "https://csw.myschoolapp.com/api/webapp/context", parameters: ["_" : Date().timeIntervalSince1970*1000]) { (result) in
//            print(result)
            if let dictionary = result as? [String:Any] {
                print(dictionary)
                if let UserInfo = dictionary["UserInfo"] as? [String:Any] {
                    if let firstName = UserInfo["FirstName"] as? String {
                        if let lastName = UserInfo["LastName"] as? String {
                            self.nameLabel.text = firstName + lastName
                        }
                    }
                    
                    let imageUrl_prefix = "https://bbk12e1-cdn.myschoolcdn.com"
                    if let ProfilePhoto = UserInfo["ProfilePhoto"] as? [String:Any] {
                        if let ThumbFilenameUrl = ProfilePhoto["ThumbFilenameUrl"] as? String {
                            self.iconImageView.sd_setImage(with: URL(string: imageUrl_prefix+ThumbFilenameUrl), completed: { (image, error, SDImageCacheTypeDisk, url) in
                                if let originImage = image {                                     self.getGausImage(originalImage: originImage)
                                }
                            })
                            
                            
                        }
                    }
                }
            }
        }
    }
    
    func getGausImage(originalImage: UIImage) {
        //获取原始图片
        let inputImage =  CIImage(image: originalImage)
        //使用高斯模糊滤镜
        let filter = CIFilter(name: "CIGaussianBlur")!
        filter.setValue(inputImage, forKey:kCIInputImageKey)
        //设置模糊半径值（越大越模糊）
        filter.setValue(1.0, forKey: kCIInputRadiusKey)
        let outputCIImage = filter.outputImage!
        let rect = CGRect(origin: CGPoint.zero, size: originalImage.size)
        let cgImage = context.createCGImage(outputCIImage, from: rect)
        //显示生成的模糊图片
        backImageView.image = UIImage(cgImage: cgImage!)
    }

    lazy var context: CIContext = {
        return CIContext(options: nil)
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
