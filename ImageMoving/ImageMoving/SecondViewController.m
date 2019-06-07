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
                         @"https://loremflickr.com/cache/resized/7800_46805176934_d904c0b852_n_320_240_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/65535_46895581504_b23230298c_320_240_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/65535_40804101203_6ddc27cb07_320_240_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/7896_47497005672_02c681b7e7_320_240_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/65535_46725501825_2cd99b6748_z_320_240_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/7800_46805176934_d904c0b852_n_320_240_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/65535_48006770457_0108f4c11b_n_320_200_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/62535_47012827704_e0b7455098_n_320_100_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/65535_46701072295_554cf585cd_b_320_500_g.jpg",
                         @"https://loremflickr.com/cache/resized/65535_46845973115_9dfa472072_z_320_600_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/7881_47519179492_6238eb61b8_z_320_400_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/7920_47527808392_9b8fee011d_320_300_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/65535_33863181638_5f47f92739_320_320_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/7839_47485332522_3ffe9a6d18_320_300_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/65535_32822510797_d3cfb4a2d7_320_300_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/65535_40682943623_0edbff849f_z_320_320_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/65535_47622703371_7be66efa87_z_320_320_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/7864_32621727967_a1c37686b9_z_320_320_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/7823_40621387943_626aeeafaa_c_320_800_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/7807_32666767997_0600d2ae91_320_320_nofilter.jpg",
                         @"https://loremflickr.com/cache/resized/7805_46807674274_d6aa59c99c_h_320_600_nofilter.jpg"
                         
                         
                         
                         
                         ];

    float viewCount = 0;
    float height = 0;
    for (int i = 0; i < 31; i++) {
       
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
