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
@property (strong,nonatomic) NSString *str;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Description";
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(prepareForSegue:sender:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    UIView *customView = [[UIView alloc] initWithFrame:self.view.bounds];
    customView.layer.borderWidth = 0;
    [customView addSubview:_pickedImage];
    [self.view addSubview:customView];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    SecondViewController *controller = [SecondViewController new];
    controller.myBlock =^UIView*(NSString *data, UIView *uiview)
    {
        self.title = data;
        self.str = data;
        //        UIView *newV = [[UIView alloc] initWithFrame:CGRectMake(0,300,300,300)];
        //        newV.layer.borderWidth = 0;
        //        [self.view addSubview:newV];
        
        [uiview setFrame:CGRectMake(0, self.view.frame.size.height/2, 200, 200)];
        uiview.center = self.view.center;
        [self.view addSubview:uiview];
        self.pickedImage = uiview;
        
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchesBegan:withEvent:)];
        [uiview addGestureRecognizer:tap];
        UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moving:)];
        [panRecognizer setMinimumNumberOfTouches:1];
        [panRecognizer setMaximumNumberOfTouches:1];
        [panRecognizer setDelegate:self];
        [self.pickedImage addGestureRecognizer:panRecognizer];
        [self.array addObject:sender];
        return uiview;
        
        
    };
    
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[[event allTouches] allObjects] objectAtIndex:0];
    if (![touch.view isEqual: self.view]) {
        self.title = @"Description";
    } else {
        self.title = _str;
    }
    
}

@end
