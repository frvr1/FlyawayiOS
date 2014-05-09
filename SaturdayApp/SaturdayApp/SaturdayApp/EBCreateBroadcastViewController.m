//
//  EBCreateBroadcastViewController.m
//  SaturdayApp
//
//  Created by Jeffrey Bergier on 4/19/14.
//  Copyright (c) 2014 BharatJeffSimer. All rights reserved.
//

#import "EBCreateBroadcastViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>

@interface EBCreateBroadcastViewController ()
@property (weak, nonatomic) IBOutlet UITextView *createBroadcastText;

@property (weak, nonatomic) IBOutlet UITextField *tagsText;


@end

@implementation EBCreateBroadcastViewController

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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.createBroadcastText.layer.borderWidth = .5f;
    self.createBroadcastText.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.createBroadcastText.layer.cornerRadius = 5;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
