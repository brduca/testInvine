//
//  InternalViewController.m
//  ex1
//
//  Copyright (c) 2015 Salvador Mósca. All rights reserved.
//

#import "InternalViewController.h"

@interface InternalViewController ()

@property (weak, nonatomic) IBOutlet UILabel *DisplayImageClickLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ImageGalery;
@property (weak, nonatomic) IBOutlet UIImageView *ImageViewerTopRight;
@property (weak, nonatomic) IBOutlet UIImageView *ImageViewBottomLeft;
@property (weak, nonatomic) IBOutlet UIImageView *ImageViewBottomRight;
@property (strong, nonatomic) NSArray *ImageArray;
@property (strong, nonatomic) NSMutableArray *ImageViewArray;
@property (weak, nonatomic) IBOutlet UIStepper *Stepper;
@property NSInteger Pos;
@end

@implementation InternalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Pos = 0;
    
    self.ImageArray = [NSArray arrayWithObjects:
                       @"sample-parts-300x300.jpg",
                       @"Honey_Bees-300x300.jpg",
                       @"cover_300x300.jpg",
                       nil];
    
    self.ImageViewArray = [NSMutableArray arrayWithObjects:
                    
                           self.ImageViewerTopRight,
                           self.ImageViewBottomLeft,
                           self.ImageViewBottomRight,
                           nil];
    
    self.Stepper.minimumValue = 0;
    self.Stepper.maximumValue = self.ImageViewArray.count;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)imageClickEventHandler:(id)sender {
    self.DisplayImageClickLabel.text = @"Hello world";
}

- (IBAction)StepperValueChanged:(UIStepper *)sender {
    
    NSInteger value = [sender value];
    
    if(self.Pos <= value) // going up
    {
        value--;
        UIImageView *imageView = self.ImageViewArray[value];
        imageView.image =  [UIImage imageNamed:self.ImageArray[value]];
    }
    else
    {
        UIImageView *imageView = self.ImageViewArray[value];
        imageView.image = nil;
    }
    
    self.Pos = ++value;
}

@end
