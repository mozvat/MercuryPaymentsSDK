//
//  MercuryPayments.h
//  MercuryPayments
//
//  Created by Mercury Payments System on 5/25/12.
//
/*
 (c) 2012 Mercury Payment Systems, LLC - all rights reserved.
 
 Disclaimer:
 This software and all specifications and documentation contained herein or provided to you hereunder 
 (the “Software”) are provided free of charge strictly on an “AS IS” basis.  No representations or 
 warranties are expressed or implied, including, but not limited to, warranties of suitability, quality, 
 merchantability, or fitness for a particular purpose (irrespective of any course of dealing, 
 custom or usage of trade), and all such warranties are expressly and specifically disclaimed.  
 Mercury Payment Systems shall have no liability or responsibility to you nor any other person or entity 
 with respect to any liability, loss, or damage, including lost profits whether foreseeable or not, or other 
 obligation for any cause whatsoever, caused or alleged to be caused directly or indirectly by the Software.  
 Use of the Software signifies agreement with this disclaimer notice.
 */

#import <Foundation/Foundation.h>

@protocol authResponseDelegate
- (void) authResponseAction;
@end

@interface MercuryPayments : NSObject <NSXMLParserDelegate>
{
    NSMutableData *webData;
    NSMutableString *soapResults;
    NSURLConnection *conn;
    NSMutableArray *xmlData;
    NSMutableString *currentStringData;
    NSString *cmdResponse;
    NSString *textResponse;
    NSString *acqRefData;
    NSString *processData;
    NSString *tranData;
}

@property (retain) NSString *cmdStatus;
@property (retain) NSString *textResponse;
@property (retain) NSString *authCode;
@property (retain) id <NSObject, authResponseDelegate> authResponseReceived;

//send swiped transactions
- (void) SendEncryptedCreditPayment:(double)amount:(NSString *)merchantId:(NSString*)wsPassword:(NSString*)refNo:(NSString*)encryptedBlock:(NSString*)encryptedKey:(NSString*)operatorName:(NSString*)wsUrl:(NSString*)memo;

- (void) SendEncryptedDebitPayment:(double)amount:(NSString *)merchantId:(NSString*)wsPassword:(NSString*)refNo:(NSString*)encryptedBlock:(NSString*)encryptedKey:(NSString*)operatorName:(NSString*)wsUrl:(NSString*)pinBlock:(NSString*)pinKey:(NSString*)memo;

- (void) SendCreditPayment:(double)amount:(NSString *)merchantId:(NSString*)wsPassword:(NSString*)refNo:(NSString*)trackData:(NSString*)operatorName:(NSString*)wsUrl:(NSString*)memo;

- (void) SendDebitPayment:(double)amount:(NSString *)merchantId:(NSString*)wsPassword:(NSString*)refNo:(NSString*)trackData:(NSString*)operatorName:(NSString*)wsUrl:(NSString*)pinBlock:(NSString*)pinKey:(NSString*)memo;

//send manual transactions
- (void) SendEncryptedCreditPaymentManual:(double)amount:(NSString *)merchantId:(NSString*)wsPassword:(NSString*)refNo:(NSString*)encryptedBlock:(NSString*)encryptedKey:(NSString*)operatorName:(NSString*)wsUrl:(NSString*)memo:(NSString*)avsZip:(NSString*)avsAddress;

- (void) SendCreditPaymentManual:(double)amount:(NSString *)merchantId:(NSString*)wsPassword:(NSString*)refNo:(NSString*)account:(NSString*)expDate:(NSString*)cvv:(NSString*)operatorName:(NSString*)wsUrl:(NSString*)memo:(NSString*)avsZip:(NSString*)avsAddress;



@end
