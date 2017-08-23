//
//  ViewController.m
//  aApplepay
//
//  Created by abc on 7/6/17.
//  Copyright © 2017 hArsh. All rights reserved.
//

#import "ViewController.h"
#import <PassKit/PassKit.h>

@interface ViewController ()
{
    PKPaymentSummaryItem *widget;
    NSMutableString *itemName,*amount;
    NSDecimalNumber *total;
    double theValue;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
  
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}


- (IBAction)applepay:(id)sender {
    
    if([PKPaymentAuthorizationViewController canMakePayments]) {
        
        NSLog(@"payment process is happening...");
        itemName=[NSMutableString stringWithFormat:@"%@", self.textelem.text];
        amount=[NSMutableString stringWithFormat:@"%@" ,self.textamount.text];
        
        NSScanner *aScanner = [NSScanner localizedScannerWithString:amount];
//        double theValue;
        
        if ([aScanner scanDouble:&theValue])
        {
            // theValue should equal 1.04 (or thereabouts)
            theValue=theValue+3.7;
            total=[NSMutableString stringWithFormat:@"%f" ,theValue];

        }
        else
        {
            // the string could not be successfully interpreted
        }
        
        
        
         PKPaymentAuthorizationViewController *paymentPane = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:self.paymentRequest];
        paymentPane.delegate = self;
        [self presentViewController:paymentPane animated:TRUE completion:nil];
        
    } else {
        NSLog(@"This device cannot make payments");
    }
    
}




- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller
                       didAuthorizePayment:(PKPayment *)payment
                                completion:(void (^)(PKPaymentAuthorizationStatus status))completion
{
    NSLog(@"Payment was authorized: %@", payment);
    
    
    BOOL asyncSuccessful = FALSE;
    
    
    if(asyncSuccessful) {
        completion(PKPaymentAuthorizationStatusSuccess);
        
       
        
        NSLog(@"Payment was successful");
        
      
        
    }
    else
    {
        completion(PKPaymentAuthorizationStatusFailure);
        
           NSLog(@"Payment was unsuccessful");
   
    }
    
}

- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller
{
    NSLog(@"Finishing payment view controller");
      [controller dismissViewControllerAnimated:TRUE completion:nil];
}



- (IBAction)addelement:(id)sender {
    
    if([PKPaymentAuthorizationViewController canMakePayments]) {
        
        NSLog(@"payment process is happening...");
        itemName=[NSMutableString stringWithFormat:@"%@", self.textelem.text];
        amount=[NSMutableString stringWithFormat:@"%@" ,self.textamount.text];
        
        NSScanner *aScanner = [NSScanner localizedScannerWithString:amount];
        //        double theValue;
        
        if ([aScanner scanDouble:&theValue])
        {
            // theValue should equal 1.04 (or thereabouts)
            theValue=theValue+3.7;
            total=[NSMutableString stringWithFormat:@"%f" ,theValue];
            
        }
        else
        {
            // the string could not be successfully interpreted
        }
        
    
    }
    
    
    
    NSLog(@"the value is = %f",theValue);
    
    
    self.textelem.text=nil;
    self.textamount.text=nil;
    
}
//////////////////////////
- (PKPaymentRequest *)paymentRequest
{
    PKPaymentRequest *paymentRequest = [[PKPaymentRequest alloc] init];
    paymentRequest.merchantIdentifier = @"merchant.com.demo.crittercismdemo";
    paymentRequest.supportedNetworks = @[PKPaymentNetworkAmex, PKPaymentNetworkVisa, PKPaymentNetworkMasterCard];
    paymentRequest.merchantCapabilities = PKMerchantCapability3DS;
    paymentRequest.countryCode = @"US"; // e.g. US
    paymentRequest.currencyCode = @"USD"; // e.g. USD
    paymentRequest.paymentSummaryItems =
    @[
      [PKPaymentSummaryItem summaryItemWithLabel:itemName amount:[NSDecimalNumber decimalNumberWithString:amount]],
      [PKPaymentSummaryItem summaryItemWithLabel:@"shipping" amount:[NSDecimalNumber decimalNumberWithString:@"3.7"]],

      // Add add'l payment summary items...
      [PKPaymentSummaryItem summaryItemWithLabel:@"AppDodo" amount:[NSDecimalNumber decimalNumberWithString:total]]
      ];
    return paymentRequest;
}
////////////
@end
