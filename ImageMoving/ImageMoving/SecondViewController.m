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
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) UILabel *nameLabel;
@end

@implementation CustomView

- (void)drawRect:(CGRect)rect

{
    UIImage *img = [UIImage imageNamed: self.name];
    [img drawInRect:rect];
}

@end

@interface SecondViewController () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIView *elementView;
@property (nonatomic, strong) NSMutableArray *squares;
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) CustomView *image;
@end

@implementation SecondViewController


float viewHeight = 150.0;
float currentViewPossitionX = 0.0;
float currentViewPossitionY = 0.0;
float viewSpacing = 10.0;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"Select Item";
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *closing = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(toClose)];
    self.navigationItem.rightBarButtonItem = closing;
  
    
    NSArray *listUrl = @[
                         @"https://loremflickr.com/cache/resized/7805_32549528197_df71385922_320_240_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/3311_46251604515_8380bc8272_320_320_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/7916_47537711841_8cbf59efb8_c_320_480_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/4808_32447536148_5a7cae30dc_h_320_240_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/6805_32549528197_df71385922_320_240_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/9811_46251604515_8380bc8272_320_320_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/37916_47537711841_8cbf59efb8_c_320_480_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/42808_32447536148_5a7cae30dc_h_320_240_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/71916_47537711841_8cbf59efb8_c_320_480_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/7916_47537711841_8cbf59efb8_c_320_480_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/73805_32549528197_df71385922_320_240_nofilter.jpg",
                         ];

    float viewCount = 0;
    float height = 0;
    for (int i = 0; i < 11; i++) {
       
        _image = [self addImage: i];
        _label = [self addLabel: [listUrl objectAtIndex:i]];
     
        [_image setFrame:CGRectMake(self.view.frame.size.width / 2 - _image.frame.size.width / 2, 20 + height, _image.frame.size.width, _image.frame.size.height)];
        [_label setFrame:CGRectMake(0,0, _image.frame.size.width, _image.frame.size.height)];
        [_image addSubview:_label];
  
        _label.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint activateConstraints:@[
                                                  [_label.bottomAnchor constraintEqualToAnchor:_image.bottomAnchor constant:0]
                                                  ]];
        

        
        [_scrollView addSubview:_image];
        height += _image.frame.size.height + 20;
        viewCount++;
        [self tapImage];
    }
    
    

    

    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds),(height));
    
    _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
                                              [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
                                              [self.scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
                                              [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor]
                                              ]
     ];
    
    
}
- (CustomView*) addImage: (int) imageName {
    
    NSString *name = [NSString stringWithFormat:@"%d",imageName];
    UIImage *imgage = [UIImage imageNamed: name];
    CustomView *elementImage = [[CustomView alloc] initWithFrame:CGRectMake(0, 0, imgage.size.width, imgage.size.height)];
    elementImage.layer.borderWidth = 0;
    elementImage.name = name;
    return elementImage;
}


-(UILabel*) addLabel: (NSString*) imageURL {
    
    UILabel *newLabel = [[UILabel alloc] initWithFrame:_image.frame];
    newLabel.layer.borderWidth = 0;
    newLabel.text = imageURL;
    if ([newLabel.text length] > 40) {
       newLabel.text = [newLabel.text substringToIndex:40];
    }
    newLabel.textColor = UIColor.blueColor;
    return newLabel;
}



- (void)handleTap:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded) {
        CustomView *customView = (CustomView *)sender.view;
        customView.subviews.lastObject.tag = 1111;
        
        _myBlock(customView.subviews.lastObject, customView);
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)tapImage {
    UITapGestureRecognizer *select = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    select.delegate = self;
    select.numberOfTapsRequired = 1;
    [_image addGestureRecognizer:select];
}

- (void)toClose {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
