//
//  EBLocationViewController.m
//  SaturdayApp
//
//  Created by michael on 4/19/14.
//  Copyright (c) 2014 BharatJeffSimer. All rights reserved.
//

#import "EBLocationViewController.h"
#import "EBSelfieViewController.h"

@interface EBLocationViewController ()

@property (strong, nonatomic) CLLocationManager *lm;
@property (strong, nonatomic) NSMutableArray *trackPointArray;
@property (weak, nonatomic) IBOutlet UILabel *locationWelcomeText;
@property (weak, nonatomic) IBOutlet UIButton *locationGrantPermissionButton;
@property (weak, nonatomic) IBOutlet MKMapView *mapview;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *locationSpinnerAnimation;
- (IBAction)startTracking:(id)sender;

@end
@implementation EBLocationViewController
@synthesize mapview;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Find Your Location";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    _trackPointArray = [[NSMutableArray alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startTracking:(id)sender {

    if ([[_locationGrantPermissionButton currentTitle] isEqual:@"Continue to Next Step"]) {
        NSLog(@"Location Permission Granted");
        [_lm stopUpdatingLocation];
        EBSelfieViewController *selfieView = [[EBSelfieViewController alloc] init];
        [self.navigationController pushViewController:selfieView animated:YES];
    } else {
        //start location manager
        _lm = [[CLLocationManager alloc] init];
        _lm.delegate = self;
        _lm.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        _lm.distanceFilter = kCLDistanceFilterNone;
        [_lm startUpdatingLocation];
        
        mapview.delegate = self;
        mapview.showsUserLocation = YES;
        [UIView animateWithDuration:.5
                         animations:^{
            self.locationGrantPermissionButton.alpha = 0;
            self.locationWelcomeText.alpha = 0;
            self.locationSpinnerAnimation.alpha = 1;
                         }
                         completion:^(BOOL fin) {
                             if (fin) {
                                 NSLog(@"Text Change Finished Animating");
                                 [self changeButtonText];
                             }
                        }
         ];
    }

}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    //get the latest location
    CLLocation *currentLocation = [locations lastObject];
    
    //store latest location in stored track array;
    [_trackPointArray addObject:currentLocation];
    
    //get latest location coordinates
    CLLocationDegrees Latitude = currentLocation.coordinate.latitude;
    CLLocationDegrees Longitude = currentLocation.coordinate.longitude;
    CLLocationCoordinate2D locationCoordinates = CLLocationCoordinate2DMake(Latitude, Longitude);
    
    //zoom map to show users location
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(locationCoordinates, 1000, 1000);
    MKCoordinateRegion adjustedRegion = [mapview regionThatFits:viewRegion];
    [mapview setRegion:adjustedRegion
              animated:YES
            //completion:^(BOOL fin) {
                //if (fin) {
                    //NSLog(@"Map Finished Animating");
                    //[self changeButtonText];
                //}
            //}
     ];
    
    [_lm stopUpdatingLocation];

}

-(void)changeButtonText {
    [_locationGrantPermissionButton setTitle:@"Continue to Next Step" forState:UIControlStateNormal];
    [_locationWelcomeText setText:@"Great! We found you. In the next step we'll get a better look at you."];
    
    [UIView animateWithDuration:.5
                          delay:3
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
        self.locationGrantPermissionButton.alpha = 1;
        self.locationWelcomeText.alpha = 1;
        self.locationSpinnerAnimation.alpha = 0;
                    }
                     completion:nil];
    [_lm stopUpdatingLocation];
}

@end
