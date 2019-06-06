//
//  ViewController.h
//  ImageMoving
//
//  Created by Anna Ershova on 5/31/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CustomView;
@interface ViewController : UIViewController
@property (nonatomic, strong) UIView *pickedImage;
@property (nonatomic, strong) CustomView *customImage;
@property (nonatomic, strong) NSMutableArray *array;

@end

