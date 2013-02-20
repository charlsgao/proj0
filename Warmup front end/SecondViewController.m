//
//  SecondViewController.m
//  Warmup
//
//  Created by Lion User on 2/19/13.
//  Copyright (c) 2013 Lion User. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

//@synthesize texts = _texts;
@synthesize label = _label;

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
    self.label.text = self.texts;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setLabel:nil];
    [super viewDidUnload];
}
- (IBAction)logout:(id)sender {
    self.view = parentViewController.view;
}
@end
