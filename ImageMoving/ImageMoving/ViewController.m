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
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    SecondViewController *controller = [SecondViewController new];
    //SecondViewController *controller = (SecondViewController *)segue.destinationViewController;
   // [self presentViewController:controller animated:YES completion:nil];
    [self showViewController:controller sender:sender];
}


@end
