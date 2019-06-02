//
//  SecondViewController.m
//  ImageMoving
//
//  Created by Anna Ershova on 5/31/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

#import "SecondViewController.h"
#import "ViewController.h"

@interface CustomView : UIView
@property (strong, nonatomic, readwrite) NSString *name;
@property (strong, nonatomic, readwrite) UILabel *nameLabel;
@property float imageHeight;
@end

@implementation CustomView

- (void)drawRect:(CGRect)rect

{
    UIImage *img = [UIImage imageNamed: self.name];
    [img drawInRect:rect];
}

@end

@interface SecondViewController () <UIGestureRecognizerDelegate>
//@property (strong, nonatomic) UIView *createView;
//@property (weak, nonatomic) IBOutlet CustomView *customView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *listView;
@property (strong, nonatomic) UIView *elementView;
@property (nonatomic, strong) NSMutableArray *squares;
@property (strong, nonatomic) UILabel *label;

@property (strong, nonatomic) CustomView *image;

@property float height;

@end

@implementation SecondViewController


float viewHeight = 150.0;
float openViewHeight = 225.0;
float currentViewPossitionX = 0.0;
float currentViewPossitionY = 0.0;
float viewSpacing = 10.0;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Select Item";
    self.navigationItem.hidesBackButton = YES;
    

    _height = _scrollView.bounds.size.height;

    NSArray *listUrl = @[
                         @"https://loremflickr.com/cache/resized/7805_32549528197_df71385922_320_240_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/7811_46251604515_8380bc8272_320_320_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/7916_47537711841_8cbf59efb8_c_320_480_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/4808_32447536148_5a7cae30dc_h_320_240_nofilter.jpg"
                         ];
    
    _squares[3] = [[NSMutableArray alloc] init];
    float viewCount = 0;
    for (int i = 0; i < 4; i++) {
        
        _elementView = [[UIView alloc] initWithFrame:CGRectMake(currentViewPossitionX, 190*i + viewSpacing, CGRectGetWidth(_scrollView.bounds),viewHeight)];
        
        _elementView.layer.borderWidth = 0;
        
        _image = [self addImage: i];
        [_elementView addSubview:_image];
        //float g = [self addImage:i];
        
        _label = [self addLabel: [listUrl objectAtIndex:i]];
        [_elementView addSubview:_label];
        
        viewCount++;
        currentViewPossitionY += _image.bounds.size.height + viewSpacing*4;
        
        [self.scrollView addSubview:_elementView];
        [_squares[i] addObject:_elementView];
        
        [self tapImage];
    }


    
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds),(viewHeight * viewCount + 500));
    
    
    


}
-(CustomView*) addImage: (int) imageName {
    
    NSString *name = [NSString stringWithFormat:@"%d",imageName];
    
    UIImage *img = [UIImage imageNamed: name];
    
    CustomView *elementImage = [[CustomView alloc] initWithFrame:CGRectMake(_scrollView.bounds.size.width / 2 - (img.size.width / 2) / 2, viewSpacing, img.size.width / 2, img.size.height / 2)];
    
    elementImage.layer.borderWidth = 0;
    elementImage.name = name;
   // elementImage.imageHeight = img.size.height / 2.5 + viewSpacing;
    
   // [_elementView addSubview:elementImage];
    return elementImage;
    

    //return img.size.height / 2.5 + viewSpacing;
}

-(UILabel*) addLabel: (NSString*) imageName {
    
    UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectMake(_scrollView.bounds.size.width / 2 - _image.bounds.size.width / 2, _image.bounds.size.height + viewSpacing*1.5, _scrollView.bounds.size.width / 2, 20)];
    newLabel.layer.borderWidth = 0;
    newLabel.text = imageName;
    
    
    return newLabel;
}

- (void)handleTap:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded) {
        //        ViewController *vc = [[ViewController alloc] init];
        //        [self.navigationController popToViewController:vc animated:YES];
        
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)tapImage {
    UITapGestureRecognizer *select = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    select.delegate = self;
    select.numberOfTapsRequired = 1;
    [_image addGestureRecognizer:select];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ViewController *destination = (ViewController*)segue.destinationViewController;
    destination.pickedImage = _elementView;
    //sender = _image;
    [self.navigationController popToRootViewControllerAnimated:YES];
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
