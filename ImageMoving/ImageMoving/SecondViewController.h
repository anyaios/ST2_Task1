//
//  SecondViewController.h
//  ImageMoving
//
//  Created by Anna Ershova on 5/31/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface SecondViewController : UIViewController
@property (nonatomic, copy)void(^myBlock)(NSString *, UIView *);
@end


