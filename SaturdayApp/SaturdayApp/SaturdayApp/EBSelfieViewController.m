//
//  EBSelfieViewController.m
//  SaturdayApp
//
//  Created by Jeffrey Bergier on 4/19/14.
//  Copyright (c) 2014 BharatJeffSimer. All rights reserved.
//

#import "EBSelfieViewController.h"
#import "EBNameViewController.h"
#import "EBCreateBroadcastViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>

//#import "selfie1.jpg"

@interface EBSelfieViewController ()
@property NSUInteger count;
@property (weak, nonatomic) NSTimer *selfieChangeImageTimer;
@property (weak, nonatomic) IBOutlet UIImageView *selfieImageView;
- (IBAction)didTakePicture:(id)sender;
- (IBAction)didChoosePicture:(id)sender;
- (IBAction)didSkipPicture:(id)sender;

@end

@implementation EBSelfieViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Take a Selfie";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [_selfieImageView setImage:[UIImage imageNamed:@"selfie1.jpg"]];
    
    self.count = 0;
    
    _selfieChangeImageTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changeSelfieImageView) userInfo:nil repeats:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTakePicture:(id)sender {
    NSLog(@"Taking Picture with Front Camera");
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    pickerController.allowsEditing = YES;
    pickerController.sourceType = UIImagePickerControllerCameraDeviceFront;
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (IBAction)didChoosePicture:(id)sender {
    NSLog(@"Choosing Picture from Library");
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (IBAction)didSkipPicture:(id)sender {
    NSLog(@"Skipping Selfie");
    // to be uncommented later
     EBNameViewController *nameViewController = [[EBNameViewController alloc] init];
    [self.navigationController pushViewController:nameViewController animated:YES];
    
    /*EBCreateBroadcastViewController *createBroadcastViewController = [[EBCreateBroadcastViewController alloc] init];
    [self.navigationController pushViewController:createBroadcastViewController animated:YES];*/
    

    [_selfieChangeImageTimer invalidate];
}

- (void)changeSelfieImageView {
    if (self.count==0){
        [_selfieImageView setImage:[UIImage imageNamed:@"selfie6.jpg"]];
        self.count = 1;
    } else if (self.count==1){
        [_selfieImageView setImage:[UIImage imageNamed:@"selfie2.jpg"]];
        self.count = 2;
    } else if (self.count==2){
        [_selfieImageView setImage:[UIImage imageNamed:@"selfie3.jpg"]];
        self.count = 3;
    } else if (self.count==3){
        [_selfieImageView setImage:[UIImage imageNamed:@"selfie4.jpg"]];
        self.count = 4;
    } else if (self.count==4){
        [_selfieImageView setImage:[UIImage imageNamed:@"selfie5.jpg"]];
        self.count = 5;
    } else if (self.count==5){
        [_selfieImageView setImage:[UIImage imageNamed:@"selfie1.jpg"]];
        self.count = 0;
    } else {
        NSLog(@"Counting is not working");
    }
}

// For responding to the user accepting a newly-captured picture or movie
- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToSave;
    
    // Handle a still image capture
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo) {
        
        editedImage = (UIImage *) [info objectForKey: UIImagePickerControllerEditedImage];
        originalImage = (UIImage *) [info objectForKey: UIImagePickerControllerOriginalImage];
        
        if (editedImage) {
            imageToSave = editedImage;
        } else {
            imageToSave = originalImage;
        }
        
        // Save the new image (original or edited) to the Camera Roll
        //UIImageWriteToSavedPhotosAlbum (imageToSave, nil, nil , nil);
        //UIImage *image = [pickerController valueForKey:UIImagePickerControllerOriginalImage];
        //NSString  *imagePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/chosenSelfie.jpg"]];
        NSString  *imagePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/chosenSelfie.jpg"];
        [UIImageJPEGRepresentation(imageToSave, 1.0) writeToFile:imagePath atomically:YES];
    }
    
    // Handle a movie capture
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
        NSLog(@"You chose a movie. Sorry, we're not that cool yet");
        //NSString *moviePath = [[info objectForKey: UIImagePickerControllerMediaURL] path];
        //if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (moviePath)) {
            //UISaveVideoAtPathToSavedPhotosAlbum (
              //                                   moviePath, nil, nil, nil);
        //}
    }
    
    [_selfieChangeImageTimer invalidate];
    
    //I absolutely cannot figure out why this line is not working!!!!
    [_selfieImageView setImage:[UIImage imageNamed:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/chosenSelfie.jpg"]]];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end
