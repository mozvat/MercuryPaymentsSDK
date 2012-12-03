//
//  MercuryPayments.m
//  MercuryPayments
//
//  Created by Mercury Payments Systems on 5/25/12.
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

#import "MercuryPayments.h"

@implementation MercuryPayments

@synthesize authResponseReceived;
@synthesize cmdStatus;
@synthesize textResponse;
@synthesize authCode;


- (void) SendEncryptedCreditPayment:(double)amount:(NSString *)merchantId:(NSString*)wsPassword:(NSString*)refNo:(NSString*)encryptedBlock:(NSString*)encryptedKey:(NSString*)operatorName:(NSString*)wsUrl:(NSString*)memo
{
    NSString *amountStr = [NSString stringWithFormat:@"%.2lf", amount];
    
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                    @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                    "<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">"
                    "<soap:Body>"
                    "<CreditTransaction xmlns=\"http://www.mercurypay.com\">"
                    "<tran>&lt;?xml version=\"1.0\"?&gt;"
                    "&lt;TStream&gt;"
                    "&lt;Transaction&gt;"
                    "&lt;MerchantID&gt;%@&lt;/MerchantID&gt;"
                    "&lt;OperatorID&gt;%@&lt;/OperatorID&gt;"
                    "&lt;TranType&gt;Credit&lt;/TranType&gt;"
                    "&lt;TranCode&gt;Sale&lt;/TranCode&gt;"
                    "&lt;InvoiceNo&gt;%@&lt;/InvoiceNo&gt;"
                    "&lt;RefNo&gt;%@&lt;/RefNo&gt;"
                    "&lt;Memo&gt;%@&lt;/Memo&gt;"
                    "&lt;Account&gt;"
                    "&lt;EncryptedFormat&gt;MagneSafe&lt;/EncryptedFormat&gt;"
                    "&lt;AccountSource&gt;Swiped&lt;/AccountSource&gt;"
                    "&lt;EncryptedBlock&gt;%@&lt;/EncryptedBlock&gt;"
                    "&lt;EncryptedKey&gt;%@&lt;/EncryptedKey&gt;"
                    "&lt;/Account&gt;"
                    "&lt;Amount&gt;"
                    "&lt;Purchase&gt;%@&lt;/Purchase&gt;"
                    "&lt;/Amount&gt;"
                    "&lt;/Transaction&gt;"
                    "&lt;/TStream&gt;</tran>"
                    "<pw>%@</pw>"
                    "</CreditTransaction>"
                    "</soap:Body>"
                    "</soap:Envelope>",
                    merchantId,
                    operatorName,
                    refNo,
                    refNo,
                    memo,
                    encryptedBlock,
                    encryptedKey,
                    amountStr,
                    wsPassword
                    ];
    
    [self SendPayment:soapMessage:wsUrl];
}

- (void) SendEncryptedDebitPayment:(double)amount:(NSString *)merchantId:(NSString*)wsPassword:(NSString*)refNo:(NSString*)encryptedBlock:(NSString*)encryptedKey:(NSString*)operatorName:(NSString*)wsUrl:(NSString*)pinBlock:(NSString*)pinKey:(NSString*)memo
{
    NSString *amountStr = [NSString stringWithFormat:@"%.2lf", amount];
    
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                   "<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">"
                   "<soap:Body>"
                   "<CreditTransaction xmlns=\"http://www.mercurypay.com\">"
                   "<tran>&lt;?xml version=\"1.0\"?&gt;"
                   "&lt;TStream&gt;"
                   "&lt;Transaction&gt;"
                   "&lt;MerchantID&gt;%@&lt;/MerchantID&gt;"
                   "&lt;OperatorID&gt;%@&lt;/OperatorID&gt;"
                   "&lt;TranType&gt;Debit&lt;/TranType&gt;"
                   "&lt;TranCode&gt;Sale&lt;/TranCode&gt;"
                   "&lt;InvoiceNo&gt;%@&lt;/InvoiceNo&gt;"
                   "&lt;RefNo&gt;%@&lt;/RefNo&gt;"
                   "&lt;Memo&gt;%@&lt;/Memo&gt;"
                   "&lt;Account&gt;"
                   "&lt;EncryptedFormat&gt;MagneSafe&lt;/EncryptedFormat&gt;"
                   "&lt;AccountSource&gt;Swiped&lt;/AccountSource&gt;"
                   "&lt;EncryptedBlock&gt;%@&lt;/EncryptedBlock&gt;"
                   "&lt;EncryptedKey&gt;%@&lt;/EncryptedKey&gt;"
                   "&lt;/Account&gt;"
                   "&lt;Amount&gt;"
                   "&lt;Purchase&gt;%@&lt;/Purchase&gt;"
                   "&lt;/Amount&gt;"
                   "&lt;PIN&gt;"
                   "&lt;PINBlock&gt;%@&lt;/PINBlock&gt;"
                   "&lt;DervdKey&gt;%@&lt;/DervdKey&gt;"
                   "&lt;/PIN&gt;"                   
                   "&lt;/Transaction&gt;"
                   "&lt;/TStream&gt;</tran>"
                   "<pw>%@</pw>"
                   "</CreditTransaction>"
                   "</soap:Body>"
                   "</soap:Envelope>",
                   merchantId,
                   operatorName,
                   refNo,
                   refNo,
                   memo,
                   encryptedBlock,
                   encryptedKey,
                   amountStr,
                   pinBlock,
                   pinKey,
                   wsPassword
                   ];
    
   [self SendPayment:soapMessage:wsUrl]; 
}

- (void) SendCreditPayment:(double)amount:(NSString *)merchantId:(NSString*)wsPassword:(NSString*)refNo:(NSString*)trackData:(NSString*)operatorName:(NSString*)wsUrl:(NSString*)memo
{
    NSString *amountStr = [NSString stringWithFormat:@"%.2lf", amount];
    
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                   "<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">"
                   "<soap:Body>"
                   "<CreditTransaction xmlns=\"http://www.mercurypay.com\">"
                   "<tran>&lt;?xml version=\"1.0\"?&gt;"
                   "&lt;TStream&gt;"
                   "&lt;Transaction&gt;"
                   "&lt;MerchantID&gt;%@&lt;/MerchantID&gt;"
                   "&lt;OperatorID&gt;%@&lt;/OperatorID&gt;"
                   "&lt;TranType&gt;Credit&lt;/TranType&gt;"
                   "&lt;TranCode&gt;Sale&lt;/TranCode&gt;"
                   "&lt;InvoiceNo&gt;%@&lt;/InvoiceNo&gt;"
                   "&lt;RefNo&gt;%@&lt;/RefNo&gt;"
                   "&lt;Memo&gt;%@&lt;/Memo&gt;"
                   "&lt;Account&gt;"
                   "&lt;AccountSource&gt;Swiped&lt;/AccountSource&gt;"
                   "&lt;Track2&gt;%@&lt;/Track2&gt;"
                   "&lt;/Account&gt;"
                   "&lt;Amount&gt;"
                   "&lt;Purchase&gt;%@&lt;/Purchase&gt;"
                   "&lt;/Amount&gt;"
                   "&lt;/Transaction&gt;"
                   "&lt;/TStream&gt;</tran>"
                   "<pw>%@</pw>"
                   "</CreditTransaction>"
                   "</soap:Body>"
                   "</soap:Envelope>",
                   merchantId,
                   operatorName,
                   refNo,
                   refNo,
                   memo,
                   trackData,
                   amountStr,
                   wsPassword
                   ];    
   [self SendPayment:soapMessage:wsUrl]; 
}

- (void) SendDebitPayment:(double)amount:(NSString *)merchantId:(NSString*)wsPassword:(NSString*)refNo:(NSString*)trackData:(NSString*)operatorName:(NSString*)wsUrl:(NSString*)pinBlock:(NSString*)pinKey:(NSString*)memo
{
    NSString *amountStr = [NSString stringWithFormat:@"%.2lf", amount];
    
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                   "<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">"
                   "<soap:Body>"
                   "<CreditTransaction xmlns=\"http://www.mercurypay.com\">"
                   "<tran>&lt;?xml version=\"1.0\"?&gt;"
                   "&lt;TStream&gt;"
                   "&lt;Transaction&gt;"
                   "&lt;MerchantID&gt;%@&lt;/MerchantID&gt;"
                   "&lt;OperatorID&gt;%@&lt;/OperatorID&gt;"
                   "&lt;TranType&gt;Debit&lt;/TranType&gt;"
                   "&lt;TranCode&gt;Sale&lt;/TranCode&gt;"
                   "&lt;InvoiceNo&gt;%@&lt;/InvoiceNo&gt;"
                   "&lt;RefNo&gt;%@&lt;/RefNo&gt;"
                   "&lt;Memo&gt;%@&lt;/Memo&gt;"
                   "&lt;Account&gt;"
                   "&lt;AccountSource&gt;Swiped&lt;/AccountSource&gt;"
                   "&lt;Track2&gt;%@&lt;/Track2&gt;"
                   "&lt;/Account&gt;"
                   "&lt;Amount&gt;"
                   "&lt;Purchase&gt;%@&lt;/Purchase&gt;"
                   "&lt;/Amount&gt;"
                   "&lt;PIN&gt;"
                   "&lt;PINBlock&gt;%@&lt;/PINBlock&gt;"
                   "&lt;DervdKey&gt;%@&lt;/DervdKey&gt;"
                   "&lt;/PIN&gt;"                    
                   "&lt;/Transaction&gt;"
                   "&lt;/TStream&gt;</tran>"
                   "<pw>%@</pw>"
                   "</CreditTransaction>"
                   "</soap:Body>"
                   "</soap:Envelope>",
                   merchantId,
                   operatorName,
                   refNo,
                   refNo,
                   memo,
                   trackData,
                   amountStr,
                   pinBlock,
                   pinKey,
                   wsPassword
                   ];
    
    [self SendPayment:soapMessage:wsUrl];
}

- (void) SendEncryptedCreditPaymentManual:(double)amount:(NSString *)merchantId:(NSString*)wsPassword:(NSString*)refNo:(NSString*)encryptedBlock:(NSString*)encryptedKey:(NSString*)operatorName:(NSString*)wsUrl:(NSString*)memo:(NSString*)avsZip:(NSString*)avsAddress
{
    NSString *amountStr = [NSString stringWithFormat:@"%.2lf", amount];
    
    NSString *soapMessage;
    
    NSString *avsInfo;
    NSString *avsZipInfo;
    NSString *avsAddressInfo;
    

    if (avsZip.length > 0)
    {
            avsZipInfo = [NSString stringWithFormat:
                          @"&lt;Zip&gt;%@&lt;/Zip&gt;",
                          avsZip
                          ];
    }
    
    if (avsAddress.length > 0)
    {
        avsAddressInfo = [NSString stringWithFormat:
                      @"&lt;Address&gt;%@&lt;/Address&gt;",
                      avsAddress
                      ];    
    }
    
    if (avsZip.length > 0 || avsAddress.length > 0)
    {
        avsInfo = [NSString stringWithFormat:
                         @"&lt;AVS&gt;"
                         "%@"
                         "%@"
                         "&lt;/AVS&gt;",
                         avsAddressInfo,
                         avsZipInfo
                         ];
    }
    else 
    {
        avsInfo = [[NSString alloc] initWithString:@""];
    }
    
    soapMessage = [NSString stringWithFormat:
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                   "<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">"
                   "<soap:Body>"
                   "<CreditTransaction xmlns=\"http://www.mercurypay.com\">"
                   "<tran>&lt;?xml version=\"1.0\"?&gt;"
                   "&lt;TStream&gt;"
                   "&lt;Transaction&gt;"
                   "&lt;MerchantID&gt;%@&lt;/MerchantID&gt;"
                   "&lt;OperatorID&gt;%@&lt;/OperatorID&gt;"
                   "&lt;TranType&gt;Credit&lt;/TranType&gt;"
                   "&lt;TranCode&gt;Sale&lt;/TranCode&gt;"
                   "&lt;InvoiceNo&gt;%@&lt;/InvoiceNo&gt;"
                   "&lt;RefNo&gt;%@&lt;/RefNo&gt;"
                   "&lt;Memo&gt;Ingenico iSMP&lt;/Memo&gt;"
                   "&lt;Account&gt;"
                   "&lt;EncryptedFormat&gt;MagneSafe&lt;/EncryptedFormat&gt;"
                   "&lt;AccountSource&gt;Keyed&lt;/AccountSource&gt;"
                   "&lt;EncryptedBlock&gt;%@&lt;/EncryptedBlock&gt;"
                   "&lt;EncryptedKey&gt;%@&lt;/EncryptedKey&gt;"
                   "&lt;/Account&gt;"
                   "&lt;Amount&gt;"
                   "&lt;Purchase&gt;%@&lt;/Purchase&gt;"
                   "&lt;/Amount&gt;"
                   "%@"
                   "&lt;/Transaction&gt;"
                   "&lt;/TStream&gt;</tran>"
                   "<pw>%@</pw>"
                   "</CreditTransaction>"
                   "</soap:Body>"
                   "</soap:Envelope>",
                   merchantId,
                   operatorName,
                   refNo,
                   refNo,
                   encryptedBlock,
                   encryptedKey,
                   amountStr,
                   avsInfo,
                   wsPassword
                   ];
    [self SendPayment:soapMessage:wsUrl];
}


- (void) SendCreditPaymentManual:(double)amount:(NSString *)merchantId:(NSString*)wsPassword:(NSString*)refNo:(NSString*)account:(NSString*)expDate:(NSString*)cvv:(NSString*)operatorName:(NSString*)wsUrl:(NSString*)memo:(NSString*)avsZip:(NSString*)avsAddress
{
    NSString *amountStr = [NSString stringWithFormat:@"%.2lf", amount];
    
    NSString *soapMessage;
    
    NSString *avsInfo;
    NSString *avsZipInfo;
    NSString *avsAddressInfo;
    
    
    if (avsZip.length > 0)
    {
        avsZipInfo = [NSString stringWithFormat:
                      @"&lt;Zip&gt;%@&lt;/Zip&gt;",
                      avsZip
                      ];
    }
    
    if (avsAddress.length > 0)
    {
        avsAddressInfo = [NSString stringWithFormat:
                          @"&lt;Address&gt;%@&lt;/Address&gt;",
                          avsAddress
                          ];    
    }
    
    if (avsZip.length > 0 || avsAddress.length > 0)
    {
        avsInfo = [NSString stringWithFormat:
                   @"&lt;AVS&gt;"
                   "%@"
                   "%@"
                   "&lt;/AVS&gt;",
                   avsAddressInfo,
                   avsZipInfo
                   ];
    }
    else 
    {
        avsInfo = [[NSString alloc] initWithString:@""];
    }
    
    soapMessage = [NSString stringWithFormat:
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                   "<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">"
                   "<soap:Body>"
                   "<CreditTransaction xmlns=\"http://www.mercurypay.com\">"
                   "<tran>&lt;?xml version=\"1.0\"?&gt;"
                   "&lt;TStream&gt;"
                   "&lt;Transaction&gt;"
                   "&lt;MerchantID&gt;%@&lt;/MerchantID&gt;"
                   "&lt;OperatorID&gt;%@&lt;/OperatorID&gt;"
                   "&lt;TranType&gt;Credit&lt;/TranType&gt;"
                   "&lt;TranCode&gt;Sale&lt;/TranCode&gt;"
                   "&lt;InvoiceNo&gt;%@&lt;/InvoiceNo&gt;"
                   "&lt;RefNo&gt;%@&lt;/RefNo&gt;"
                   "&lt;Memo&gt;Ingenico iSMP&lt;/Memo&gt;"
                   "&lt;Account&gt;"
                   "&lt;AccountSource&gt;Keyed&lt;/AccountSource&gt;"
                   "&lt;AcctNo&gt;%@&lt;/AcctNo&gt;"
                   "&lt;ExpDate&gt;%@&lt;/ExpDate&gt;"
                   "&lt;/Account&gt;"
                   "&lt;Amount&gt;"
                   "&lt;Purchase&gt;%@&lt;/Purchase&gt;"
                   "&lt;/Amount&gt;"
                   "%@"
                   "&lt;/Transaction&gt;"
                   "&lt;/TStream&gt;</tran>"
                   "<pw>%@</pw>"
                   "</CreditTransaction>"
                   "</soap:Body>"
                   "</soap:Envelope>",
                   merchantId,
                   operatorName,
                   refNo,
                   refNo,
                   account,
                   expDate,
                   amountStr,
                   avsInfo,
                   wsPassword
                   ];
    
    [self SendPayment:soapMessage:wsUrl];
}

- (void) SendPayment:(NSString*)soapMessage:(NSString*)wsUrl
{
    NSLog(@"soapMessage=%@", soapMessage);
    
    NSURL *url = [NSURL URLWithString:wsUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://www.mercurypay.com/CreditTransaction" forHTTPHeaderField:@"Soapaction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    conn = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if (conn)
    {
        webData = [NSMutableData data];
    }
    else
    {
        NSLog(@"The connection to the webservice is not available or null.");
    }

}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"Received response from webservice.");
    [webData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"Received data from webservice.");    
    [webData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Connection failed with error.");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:webData];
    
    [xmlParser setDelegate:self];
    BOOL success = [xmlParser parse];
    if (success)
    {
        if ([tranData length] > 0)
        {
            NSData* data2 = [tranData dataUsingEncoding:NSUTF8StringEncoding];
            NSString *test = [[NSString alloc] initWithData:data2 encoding:NSASCIIStringEncoding];
            NSLog(@"XML Ret=%@", test);
            NSXMLParser *xmlParser2 = [[NSXMLParser alloc] initWithData:data2];
            
            [xmlParser2 setDelegate:self];
            BOOL success = [xmlParser2 parse];
            if (success)
            {
                [self.authResponseReceived authResponseAction];
            }
            else
            {
                NSLog(@"Error Error Error From Parser2!!!");
            }
        }
        else
        {
            NSLog(@"No data returned from webservice");
        }
        
    }
    else
    {
        NSLog(@"Error Error Error!!!");
    }
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (!currentStringData)
    {
        currentStringData = [[NSMutableString alloc] init];
    }
    
    [currentStringData appendString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSString *current = [currentStringData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    currentStringData = nil;
    
    if ([elementName isEqualToString:@"CreditTransactionResult"])
    {
        tranData = current;
    }
    else if([elementName isEqualToString:@"CmdResponse"])
    {
        cmdResponse = current;
    }
    else if([elementName isEqualToString:@"CmdStatus"])
    {
        self.cmdStatus = current;
    }
    else if([elementName isEqualToString:@"TextResponse"])
    {
        self.textResponse = current;
    }
    else if([elementName isEqualToString:@"AcqRefData"])
    {
        acqRefData = current;
    }
    else if([elementName isEqualToString:@"ProcessData"])
    {
        processData = current;
    }
    else if([elementName isEqualToString:@"AuthCode"])
    {
        self.authCode = current;
    }
}

@end
