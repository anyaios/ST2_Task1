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
@property (nonatomic, strong) NSMutableArray *squares;

@end

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Select Item";
    
    [self addImage:@"Image"];
    [self addImage:@"1"];

//    self.squares = [[NSMutableArray alloc] init];
//
//    for(int i = 0; i < 4; i++)
//    {
//        CustomView *v = [[CustomView alloc] initWithFrame: CGRectMake(100, 100, 60, 60)];
//        [self.squares addObject:v];
//    }
    

    // Do any additional setup after loading the view from its nib.
}
-(void) addImage: (NSString *) imageName {
    
    CustomView *elementView = [[CustomView alloc] initWithFrame:CGRectMake(0.f, 0.f, 50, 50)];
    
    elementView.layer.borderWidth = 3;
    elementView.name = imageName;
    

    
    [_listView addSubview:elementView];
    
    
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
