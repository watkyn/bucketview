//
//  FlipsideViewController.h
//  BucketView
//
//  Created by Tony Eichelberger on 7/3/09.
//

@protocol FlipsideViewControllerDelegate;


@interface FlipsideViewController : UIViewController {
	IBOutlet UILabel *versionLabel;
	IBOutlet UITextField *urlTextField;
	IBOutlet UITextField *userNameTextField;
	IBOutlet UITextField *passwordTextField;
}

@property (nonatomic, retain) id <FlipsideViewControllerDelegate> delegate;

- (IBAction)done;

@end


@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

