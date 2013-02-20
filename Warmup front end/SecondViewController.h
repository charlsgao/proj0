//
//  SecondViewController.h
//  Warmup
//
//  Created by Lion User on 2/19/13.
//  Copyright (c) 2013 Lion User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WarmupViewController.h"

@interface SecondViewController : UIViewController
{
    WarmupViewController *parentViewController;
}
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet NSString *texts;
- (IBAction)logout:(id)sender;

@end
