//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Mihai Popa on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BNRItem;



@interface BNRItemStore : NSObject
{
    NSMutableArray *allItems;
}

+(BNRItemStore*) sharedStore;
-(NSArray*)allItems;
-(BNRItem*)createItem;
-(void)removeItem:(BNRItem*)p;
-(void)moveItemAtIndex:(int)from toIndex:(int)to;
@end
