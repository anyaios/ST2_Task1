//
//  ViewController.m
//  ImageMoving
//
//  Created by Anna Ershova on 5/31/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Description";
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(prepareForSegue:sender:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    UIView *customView = [[UIView alloc] initWithFrame:self.view.bounds];
    customView.layer.borderWidth = 6;
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
    
   
   
        
    controller.myBlock =^UIView*(NSString *data, UIView *uiview)
    {
        self.title = data;
        //UIView *newV = [UIView new];
        UIView *newV = [[UIView alloc] initWithFrame:CGRectMake(0,300,300,300)];
        newV.layer.borderWidth = 0;
        [self.view addSubview:newV];
        [newV addSubview:uiview];
        self.pickedImage = newV;
        
      
        UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moving:)];
        [panRecognizer setMinimumNumberOfTouches:1];
        [panRecognizer setMaximumNumberOfTouches:1];
        [panRecognizer setDelegate:self];
        [self.pickedImage addGestureRecognizer:panRecognizer];
        
        
        [self.array addObject:sender];
//        for(int i=0; i<4; ++i) {
//            
//        }
        
        return newV;
        
        
    };
        
    
    
    

    //SecondViewController *controller = (SecondViewController *)segue.destinationViewController;
   // [self presentViewController:controller animated:YES completion:nil];
    [self showViewController:controller sender:sender];
}
CGFloat initialX;
CGFloat initialY;

-(void)moving:(id)sender {
    [self.view bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
    CGPoint toPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        initialX = [[sender view] center].x;
        initialY = [[sender view] center].y;
    }
    toPoint = CGPointMake(initialX+toPoint.x, initialY+toPoint.y);
    
    [[sender view] setCenter:toPoint];
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        
        CGFloat currentX = toPoint.x + (0*[(UIPanGestureRecognizer*)sender velocityInView:self.pickedImage].x);
        CGFloat currentY = toPoint.y + (0*[(UIPanGestureRecognizer*)sender velocityInView:self.pickedImage].y);
        
        [[sender view] setCenter:CGPointMake(currentX, currentY)];
    }
}

@end
