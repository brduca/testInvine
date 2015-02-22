//
//  TwitterViewController.m
//  ex1
//
//  Copyright (c) 2015 Salvador Mósca. All rights reserved.
//

#import "TwitterViewController.h"
#import "STTwitter.h"

@interface TwitterViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *twitterFeed;
@end

@implementation TwitterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    STTwitterAPI *twitter = [STTwitterAPI twitterAPIAppOnlyWithConsumerKey:@"kJrYLMFXVUPhuaAY3UU4ozpyd"
                                          consumerSecret:@"8w6KZklnO780znm8vk7y1dCM6rgSwltQu4L1fwTRlK2qVu23td"];
    
    [twitter verifyCredentialsWithSuccessBlock:^(NSString *bearerToken) {
        
        [twitter getUserTimelineWithScreenName:@"brduca"
                                  successBlock:^(NSArray *statuses) {
                                      self.twitterFeed = [NSMutableArray arrayWithArray:statuses];
                                      [self.tableView reloadData];
                                      
                                  } errorBlock:^(NSError *error) {
                                      NSLog(@"%@", error.debugDescription);
                                  }];
        
    } errorBlock:^(NSError *error) {
        NSLog(@"%@", error.debugDescription);
    }];
}

-(NSInteger) tableView: (UITableView*) tableView numberOfRowsInSection:(NSInteger)section{
    return self.twitterFeed.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID =  @"CellID" ;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    NSInteger idx = indexPath.row;
    NSDictionary *t = self.twitterFeed[idx];
    
    cell.textLabel.text = t[@"text"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
