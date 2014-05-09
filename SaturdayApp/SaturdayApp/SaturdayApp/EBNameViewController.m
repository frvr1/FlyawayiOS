//
//  EBNameViewController.m
//  
//
//  Created by michael on 5/4/14.
//
//

#import "EBNameViewController.h"
#import <Parse/Parse.h>
#import "EBMainListViewController.h"
#import "EBCreateBroadcastViewController.h"

@interface EBNameViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)signUpAndViewBroadcastButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@end

@implementation EBNameViewController

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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signUpAndViewBroadcastButton:(id)sender {
    
    PFUser *user = [PFUser user];
    
    user.username=self.userNameTextField.text;
    user.password = self.passwordTextField.text;
    user.email = self.emailTextField.text;
    
    // other fields can be set just like with PFObject
    //user[@"phone"] = @"415-392-0202";
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
            NSLog(@"User Signed Up");
           // disabled temporarly
            EBMainListViewController *mainListViewController = [[EBMainListViewController alloc] init];
            [self.navigationController pushViewController:mainListViewController animated:YES];
            
            // need to disabled eventually
           /* EBCreateBroadcastViewController *createBroadcastViewController = [[EBCreateBroadcastViewController alloc] init];
            [self.navigationController pushViewController:createBroadcastViewController animated:YES];*/
            
            
        } else {
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"%@",errorString);
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[[error userInfo] objectForKey:@"error"] message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alertView show];
            
            // Show the errorString somewhere and let the user try again.
        }
    }];
    
    
}
@end
