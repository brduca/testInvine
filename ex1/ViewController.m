//
//  ViewController.m
//  ex1
//
//  Created by Sofia Ferreira on 19/02/15.
//  Copyright (c) 2015 Sofia Ferreira. All rights reserved.
//

@import Foundation;
#import "ViewController.h"


@interface ViewController ()
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UILabel *InitCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *WarningLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.username = @"testusername";
}

-(void) viewWillAppear:(BOOL) animated {
    NSUserDefaults *persistedData = [NSUserDefaults standardUserDefaults];
    NSInteger count = [persistedData integerForKey:@"currentCount"];
    self.InitCountLabel.text = [NSString stringWithFormat:@"This app has been initialized %ld times", count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)loginBtnClickEventHandler:(id)sender {
    
    self.password = self.passwordTextField.text;
    
    NSRange searchedRange = NSMakeRange(0, [self.password length]);
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"(?!^[0-9]*$)(?!^[a-zA-Z]*$)^([a-zA-Z0-9]{2,8})$"
                                  options:NSRegularExpressionCaseInsensitive
                                  error:nil];
    
    NSArray *matches = [regex matchesInString:self.password options: 0 range: searchedRange];
    
    BOOL isValidUsername = [self.username isEqualToString:self.usernameTextField.text];
    BOOL isValidPassword = matches != nil && matches.count > 0;
    
    if(isValidPassword && isValidUsername)
    {
        [self performSegueWithIdentifier:@"loginSuccess" sender:self];
    }
    else
    {
        self.WarningLabel.text = @"Wrong username or password";
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(cleanLabel:) userInfo:nil repeats:NO];
    }
}

-(void)cleanLabel:(id) sender{
    self.WarningLabel.text = @"";
}

@end
