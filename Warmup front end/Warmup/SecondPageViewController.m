//
//  SecondPageViewController.m
//  Warmup
//
//  Created by Wenhao Cen on 2/18/13.
//  Copyright (c) 2013 Lion User. All rights reserved.
//

#import "SecondPageViewController.h"

@interface SecondPageViewController ()

@end

@implementation SecondPageViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{   
    //self.label.hidden = false;
    //self.label.text = self.texts;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logout:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
