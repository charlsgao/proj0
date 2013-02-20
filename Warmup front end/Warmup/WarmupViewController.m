//
//  WarmupViewController.m
//  Warmup
//
//  Created by Lion User on 2/19/13.
//  Copyright (c) 2013 Lion User. All rights reserved.
//

#import "WarmupViewController.h"
#import "SecondPageViewController.h"

@interface WarmupViewController ()

@end

@implementation WarmupViewController

@synthesize username = _username;
@synthesize psd = _psd;
//@synthesize count = _count;


- (void)viewDidLoad
{
    self.errCode = [NSDictionary dictionaryWithObjectsAndKeys:@"Invalid username and password combination. Please try again.", [NSNumber numberWithInt:ERR_BAD_CREDENTIALS], @"This user name already exists. Please try again.", [NSNumber numberWithInt:ERR_USER_EXISTS], @"The user name should not be empty and at most 128 characters long. Please try again.", [NSNumber numberWithInt:ERR_BAD_USERNAME], @"The password should be at most 128 characters long. Please try again.", [NSNumber numberWithInt:ERR_BAD_PASSWORD], nil];
    
    self.url = [NSString stringWithFormat:@"http://salty-castle-4218.herokuapp.com"];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginAction:(id)sender {
    
    NSDictionary *response = [self HTTPResponseAndRequest:@"/users/login"];
    
    [self responseHandler:response];
    
}


- (IBAction)addAction:(id)sender{
    NSDictionary *response = [self HTTPResponseAndRequest:@"/users/add"];
    
    [self responseHandler:response];
}

- (NSDictionary*) HTTPResponseAndRequest:(NSString *)appended_url{
    self.username = self.usernameField.text;
    self.psd = self.passwordField.text;
    
    NSDictionary *jdict = [NSDictionary dictionaryWithObjectsAndKeys:self.username, @"user", self.psd, @"password",nil];
    NSError *error;
    
    NSData *jsonReq = [NSJSONSerialization dataWithJSONObject:jdict options:NSJSONWritingPrettyPrinted error: &error];
    
    NSLog(@"jsonRequest: %@", [[NSString alloc] initWithData:jsonReq encoding:NSUTF8StringEncoding]);
    
    NSString *address = [NSString stringWithFormat:@"%@%@", self.url, appended_url];
    NSLog(@"address: %@", address);
    
    NSURL *addr = [NSURL URLWithString:address];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:addr cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];

    [request setHTTPMethod: @"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:[NSString stringWithFormat:@"%d", [jsonReq length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:jsonReq];
    
    NSURLResponse *resp = [[NSURLResponse alloc]init];
    
    
    NSData *jsonResp = [NSURLConnection sendSynchronousRequest:request returningResponse: &resp error:&error];
    
    
    
    NSDictionary *jsonDictResp = [NSJSONSerialization JSONObjectWithData:jsonResp options:kNilOptions error: &error];
    
    NSLog(@"response: %@", jsonDictResp);
    
    return jsonDictResp;

}

- (void)responseHandler:(NSDictionary *)response{
    NSNumber *error_code = [response objectForKey:@"errCode"];
    NSLog(@"Error code: %@", error_code);
    
    NSString *return_msg = [self.errCode objectForKey:error_code];
    
    if (return_msg!=nil){
        self.message.text = return_msg;
    }
    else{
        self.count = [response objectForKey: @"count"];
        SecondPageViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondPageViewController"];
        [self presentViewController:vc2 animated:YES completion:nil];
        vc2.label_2.text = [NSString stringWithFormat: @"Welcome %@ ! \n You have logged in %@ times.", self.username, self.count];
        //NSLog(vc2.label_2.text);
        
    }
    
    [self.usernameField resignFirstResponder];
    
    self.usernameField.text = @"";
    self.passwordField.text = @"";
    
}
    

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.usernameField){
        [theTextField resignFirstResponder];
    }
    if (theTextField == self.passwordField){
        [theTextField resignFirstResponder];
    }
    return YES;
}

- (void)viewDidUnload {
    [self setUsernameField:nil];
    [self setPasswordField:nil];
    [self setMessage:nil];
    [self setMessage:nil];
    [super viewDidUnload];
}
@end
