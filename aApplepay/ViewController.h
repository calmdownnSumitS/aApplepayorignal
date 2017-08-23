//
//  ViewController.h
//  aApplepay
//
//  Created by abc on 7/6/17.
//  Copyright © 2017 hArsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PassKit/PassKit.h>

@interface ViewController : UIViewController <PKPaymentAuthorizationViewControllerDelegate>
@property (strong, nonatomic)IBOutlet UITextField *textelem;
@property (strong, nonatomic) IBOutlet UITextField *textamount;
- (IBAction)addelement:(id)sender;

- (IBAction)applepay:(id)sender;

@end

