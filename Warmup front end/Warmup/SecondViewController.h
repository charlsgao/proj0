//
//  SecondViewController.h
//  Warmup
//
//  Created by Lion User on 2/19/13.
//  Copyright (c) 2013 Lion User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController
{
    UIViewController *parentViewController;
}
@property (weak, nonatomic) IBOutlet UITextView *label;

- (IBAction)logout:(id)sender;

@end
