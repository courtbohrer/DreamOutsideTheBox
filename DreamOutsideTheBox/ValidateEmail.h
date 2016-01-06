//
//  ValidateEmail.h
//  DreamOutsideTheBox
//
//  Created by Courtney Bohrer on 12/31/15.
//  Copyright © 2015 Courtney Bohrer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValidateEmail : NSObject

+ (BOOL)isValidEmailAddress:(NSString *)emailAddress ;

+ (BOOL) validateEmail:(NSString*) emailAddress ;

@end
