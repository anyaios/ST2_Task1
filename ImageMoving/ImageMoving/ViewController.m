//
//  ViewController.m
//  ImageMoving
//
//  Created by Anna Ershova on 5/31/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController () <UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Description";
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(prepareForSegue:sender:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    UIView *customView = [[UIView alloc] initWithFrame:self.view.bounds];
    customView.layer.borderWidth = 3;
    [customView addSubview:_pickedImage];
    [self.view addSubview:customView];
    
    //SecondViewController *ref =[[SecondViewController alloc ]init];
    
//    ref.myBlock =^void(NSString *data)
//    {
//        self.title = data;
//    };
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    SecondViewController *controller = [SecondViewController new];
    
    controller.myBlock =^void(NSString *data, UIView *uiview)
    {
        self.title = data;
        [self.view addSubview:uiview];
    };
    //SecondViewController *controller = (SecondViewController *)segue.destinationViewController;
   // [self presentViewController:controller animated:YES completion:nil];
    [self showViewController:controller sender:sender];
}


@end
