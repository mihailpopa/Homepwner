//
//  BNRImageStore.h
//  Homepwner
//
//  Created by Mihai Popa on 7/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRImageStore : NSObject
{
    NSMutableDictionary *dictionary;
}
+(BNRImageStore*) sharedStore;
-(void)setImage:(UIImage*)i forKey:(NSString*)s;
-(UIImage*)imageForKey:(NSString*)s;
-(void)deleteImageForKey:(NSString*)s;
@end
