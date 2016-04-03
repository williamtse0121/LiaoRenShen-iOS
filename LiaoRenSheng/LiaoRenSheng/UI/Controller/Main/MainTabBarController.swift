//
//  MainTabBarController.swift
//  LiaoRenSheng
//
//  Created by Wei on 3/28/16.
//  Copyright © 2016 Wei. All rights reserved.
//

import UIKit

class MainTabBarController: CYLTabBarController {
    
    //以后新项目开发的话，只需要修改这4个集合里的内容即可
    
    //StoryBoard的名称
    let StoryName = ["Home","Voice","Collection","Profile"]
    //标题
    let Title = ["Home","Voice","Collection","Profile"]
    //选中时的图片
    let SelectedImage = ["tab_5th_h","tab_2nd_h","tab_4th_h","tab_3rd_h"]
    //未选中时的图片
    let Image = ["tab_5th_n","tab_2nd_n","tab_4th_n","tab_3rd_n"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var tabBarItemsAttributes: [AnyObject] = []
        var viewControllers:[AnyObject] = []
        
        for i in 0 ... Title.count - 1 {
            let dict: [NSObject : AnyObject] = [
                CYLTabBarItemTitle: Title[i],
                CYLTabBarItemImage: Image[i],
                CYLTabBarItemSelectedImage: SelectedImage[i]
            ]
            let vc = UIStoryboard(name: StoryName[i], bundle: nil).instantiateInitialViewController()
            
            tabBarItemsAttributes.append(dict)
            viewControllers.append(vc!)
        }
        
        self.tabBarItemsAttributes = tabBarItemsAttributes
        self.viewControllers = viewControllers
        
        let button   = UIButton(type: UIButtonType.Custom) as UIButton
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let tabBarHeight = self.tabBar.frame.size.height
        
        button.frame = CGRectMake((screenSize.width - tabBarHeight)/2, screenSize.height - tabBarHeight, tabBarHeight, tabBarHeight)
        button.backgroundColor = UIColor.clearColor()
//        button.setTitle("Test Button", forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        let image = UIImage(named: "icon_middle_add") as UIImage?
        button.setImage(image, forState: .Normal)
        self.view.addSubview(button)
    }
    
    func buttonAction(sender:UIButton!)
    {
        let vc = UIStoryboard(name: "AddNewVoice", bundle: nil).instantiateInitialViewController()
        self.presentViewController(vc!, animated: true, completion: nil)
        print("Button tapped")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class PlusButtonSubclass : CYLPlusButton, CYLPlusButtonSubclassing{
    
    class func plusButton() -> AnyObject! {
        let button:PlusButtonSubclass =  PlusButtonSubclass()
//        button.setImage(UIImage(named: "icon_middle_add"), forState: UIControlState.Normal)
//        button.titleLabel!.textAlignment = NSTextAlignment.Center;
//        button.adjustsImageWhenHighlighted = false;
//        button.addTarget(button, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
//        
        
        return  button
    }
    
    //点击事件
    func buttonClicked(sender:CYLPlusButton)
    {
        print("hello mm")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 控件大小,间距大小
        let imageViewEdge   = self.bounds.size.width * 0.6;
        let centerOfView    = self.bounds.size.width * 0.5;
        let labelLineHeight = self.titleLabel!.font.lineHeight;
        //        let verticalMarginT = self.bounds.size.height - labelLineHeight - imageViewEdge;
        //        let verticalMargin  = verticalMarginT / 2;
        
        // imageView 和 titleLabel 中心的 Y 值
        //        _  = verticalMargin + imageViewEdge * 0.5;
        let centerOfTitleLabel = imageViewEdge  + labelLineHeight + 2;
        
        //imageView position 位置
        self.imageView!.bounds = CGRectMake(0, 0, 36, 36);
        self.imageView!.center = CGPointMake(centerOfView, 0)//centerOfImageView * 2 );
        
        //title position 位置
        self.titleLabel!.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
        self.titleLabel!.center = CGPointMake(centerOfView, centerOfTitleLabel);
    }
}
