//
//  BNRItem.h
//  RandomPossesions
//
//  Created by Mihai Popa on 7/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject
{
    NSString *itemName;
    NSString *serialNumber;
    int valueInDollars;
    NSDate *dateCreated;
}
@property (nonatomic, copy) NSString *imageKey;

+(id)randomItem;
-(id) initWithItemName:(NSString*) name
        valueInDollars:(int)value
          serialNumber:(NSString*) number;
-(NSString*) itemName;

-(id) initWithItemName:(NSString*) name
  valueInDollars:(int)value;
           
-(void)setItemName:(NSString*)newItemName;

-(NSString*) serialNumber;

-(void)setSerialNumber:(NSString*) newSerialNumber;

-(int) valueInDollars;

-(void)setValueInDollars:(int)newValueInDollars;

-(NSDate*) dateCreated;

-(void)setDateCreated:(NSDate*)newDateCreated;

//Method not implemented
//-(void)throwAnException;
@end
