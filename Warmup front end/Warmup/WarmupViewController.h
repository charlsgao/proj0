//
//  WarmupViewController.h
//  Warmup
//
//  Created by Lion User on 2/19/13.
//  Copyright (c) 2013 Lion User. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SecondPageViewController.h"


static const int SUCCESS = 1;
static const int ERR_BAD_CREDENTIALS = -1;
static const int ERR_USER_EXISTS = -2;
static const int ERR_BAD_USERNAME = -3;
static const int ERR_BAD_PASSWORD = -4;





@interface WarmupViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) NSDictionary *errCode;
@property (strong, nonatomic) NSString *url;

@property (weak, nonatomic) IBOutlet UITextView *message;


@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;

- (IBAction)loginAction:(id)sender;
- (IBAction)addAction:(id)sender;

@property (copy,nonatomic) NSString *username;
@property (copy,nonatomic) NSString *psd;
@property (strong,nonatomic) NSNumber *count;

- (NSDictionary*) HTTPResponseAndRequest: (NSString*)appended_url;
- (void) responseHandler: (NSDictionary *) response;


@end
