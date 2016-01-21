//
//  GLRSAUtils.h
//  GLRSA
//
//  Created by jiaguanglei on 16/1/21.
//  Copyright © 2016年 roseonly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLRSAUtils : NSObject

#pragma mark - Instance Methods

-(void) loadPublicKeyFromFile: (NSString*) derFilePath;
-(void) loadPublicKeyFromData: (NSData*) derData;

-(void) loadPrivateKeyFromFile: (NSString*) p12FilePath password:(NSString*)p12Password;
-(void) loadPrivateKeyFromData: (NSData*) p12Data password:(NSString*)p12Password;




-(NSString*) rsaEncryptString:(NSString*)string;
-(NSData*) rsaEncryptData:(NSData*)data ;

-(NSString*) rsaDecryptString:(NSString*)string;
-(NSData*) rsaDecryptData:(NSData*)data;





#pragma mark - Class Methods

+(void)setSharedInstance:(GLRSAUtils *)instance;
+(GLRSAUtils *) sharedInstance;

@end

