//
//  SecondViewController.m
//  ImageMoving
//
//  Created by Anna Ershova on 5/31/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

#import "SecondViewController.h"

@interface CustomView : UIView
@property (strong, nonatomic, readwrite) NSString *name;
@end

@implementation CustomView

- (void)drawRect:(CGRect)rect

{
    UIImage *img = [UIImage imageNamed: self.name];
    [img drawInRect:rect];
}

@end

@interface SecondViewController ()
//@property (strong, nonatomic) UIView *createView;
//@property (weak, nonatomic) IBOutlet CustomView *customView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *listView;
@property (strong, nonatomic) UIView *elementView;
@property (nonatomic, strong) NSMutableArray *squares;



@end

@implementation SecondViewController

float viewHeight = 100.0;
float openViewHeight = 225.0;
float currentViewPossitionX = 0.0;
float currentViewPossitionY = 0.0;
float viewSpacing = 10.0;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Select Item";
    
    
//    _elementView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height / 2)];
//    _elementView.layer.borderWidth = 6;
//    [self.scrollView addSubview:_elementView];
    
//    [self addImage:@"Image"];
//    [self addImage:@"1"];
    
    _squares[3] = [[NSMutableArray alloc] init];
    float viewCount = 0;
    for (int i = 0; i < 4; i++) {
        _elementView = [[UIView alloc] initWithFrame:CGRectMake(currentViewPossitionX, currentViewPossitionY, CGRectGetWidth(_scrollView.bounds),viewHeight)];
        _elementView.layer.borderWidth = 6;
        [self addImage: i];
        
        viewCount++;
        currentViewPossitionY += viewHeight + viewSpacing;
        
        [self.scrollView addSubview:_elementView];
        [_squares[i] addObject:_elementView];
    }

    
//
//    for(int i = 0; i <3; i++){
//        _squares[i] = [[CustomView alloc] initWithFrame:CGRectMake(currentViewPossitionX, currentViewPossitionY, CGRectGetWidth(_scrollView.bounds), viewHeight)];
//
//
//        [_scrollView addSubview:_squares[i]];
//        viewCount++;
//        currentViewPossitionY += viewHeight + viewSpacing;
//    }
    
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds),(viewHeight * viewCount + 500));

//    self.squares = [[NSMutableArray alloc] init];
//
//    for(int i = 0; i < 4; i++)
//    {
//        CustomView *v = [[CustomView alloc] initWithFrame: CGRectMake(100, 100, 60, 60)];
//        [self.squares addObject:v];
//    }
    

    // Do any additional setup after loading the view from its nib.
}
-(void) addImage: (int) imageName {
    
    NSString *name = [NSString stringWithFormat:@"%d",imageName];
    
    UIImage *img = [UIImage imageNamed: name];
    
    CustomView *elementImage = [[CustomView alloc] initWithFrame:CGRectMake(_scrollView.bounds.size.width / 2 - (img.size.width / 3) / 2, 0.f, img.size.width / 3, img.size.height / 3)];
    
    elementImage.layer.borderWidth = 3;
    elementImage.name = name;
    
    [_elementView addSubview:elementImage];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
