
//This is an example of how to call the  the MercuryPayments object.
 - (void) SendTransaction
{ 
	self.mps = [[MercuryPayments alloc] init];
    [self.mps setAuthResponseReceived:self];
    
    NSString* merchantId;
    NSString* wsPassword;
    NSString* wsUrl = [[NSString alloc] initWithString:@"https://w1.mercurydev.net/ws/ws.asmx"];
    NSString* operatorName = [[NSString alloc] initWithString:@"<YOUR IDENTIFIER>"];
    NSString* memo = [[NSString alloc] initWithString:@"<YOUR POS NAME/VERSION>"];
    double amount = [self.textInfo.text floatValue];
     
     merchantId = [[NSString alloc] initWithString:@"<YOUR TEST/PROD MERCHANT ID>"];
     wsPassword = [[NSString alloc] initWithString:@"<YOUR TEST/PROD MERCHANT PASSWORD>"];
       
     [self.mps SendEncryptedCreditPayment:amount :merchantId :wsPassword :self.textRefNo.text : self.cardInfo.trackData :self.cardInfo.trackDataKSN :operatorName :wsUrl :memo];
}
	 
	 //This method gets fired when SendEncryptedCreditPayment is completed.
 - (void) authResponseAction 
{
        
    if ([self.mps.cmdStatus isEqualToString:@"Success"] || [self.mps.cmdStatus isEqualToString: @"Approved"])
    {
         //DO Something on approved
    }
    else
    {
		// DO Something on decline
    }

}


 //This is your headerfile of the ViewController
 
 #import "MercuryPayments.h"

@interface Mercury : UIViewController <authResponseDelegate>
{
}
@property (nonatomic, retain) MercuryPayments* mps;

@end
