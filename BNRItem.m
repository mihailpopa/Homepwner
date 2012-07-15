//
//  BNRItem.m
//  RandomPossesions
//
//  Created by Mihai Popa on 7/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem

@synthesize imageKey;


//Class method (comes first, before the initializers)

+(id)randomItem
{
    //Create an array of three adjectives
    
    NSArray *randomAdjectiveList = [NSArray arrayWithObjects:@"Fluffy",@"Rusty",@"Shiny", nil];
    
    //Create an array of three nouns
    NSArray *randomNounList = [NSArray arrayWithObjects:@"Bear",@"Spork",@"Mac", nil];
    
    //Get the index of a random adjective/noun from the lists
    //Note: The % operator, called the modulo operator ...
    NSInteger adjectiveIndex = rand() % [randomAdjectiveList count];
    NSInteger nounIndex = random() % [randomNounList count];
    
    //NSInteger is a typedef!!!
    
    NSString *randomName = [NSString stringWithFormat:@"%@ %@", [randomAdjectiveList objectAtIndex:adjectiveIndex], [randomNounList objectAtIndex:nounIndex]];
    
    int randomValue = random() % 100;
    
    NSString *randomSerialNumber  = [NSString stringWithFormat:@"%c%c%c%c", '0' + rand() % 10, 'A' + rand() % 26 , '0' + rand() % 10 , 'A' + rand() % 26];
    
    BNRItem *newItem = [[self alloc] initWithItemName:randomName valueInDollars:randomValue serialNumber:randomSerialNumber];
    
    return newItem;
    
}


//Overriding init so it calls the designated initializer

-(id) init
{
    return [self initWithItemName:@"Item" valueInDollars:0 serialNumber:@""];
}

//Creating another initializer
-(id) initWithItemName:(NSString*) name
        valueInDollars:(int)value
{
    return [self initWithItemName:name valueInDollars:value serialNumber:@""];
}


//My designated initializer

-(id) initWithItemName:(NSString*) name
        valueInDollars:(int)value
          serialNumber:(NSString*) number
{
    if (self = [super init])
    {
    [self setItemName:name];
    [self setSerialNumber:number];
    [self setValueInDollars:value];
    dateCreated = [NSDate date];
    }
    return self;
}

-(NSString*) itemName
{
    return itemName;
}
-(void)setItemName:(NSString*)newItemName
{
    itemName = newItemName;
}
-(NSString*) serialNumber
{
    return serialNumber;
}
-(void)setSerialNumber:(NSString*) newSerialNumber
{
    serialNumber = newSerialNumber;
}
-(int) valueInDollars
{
    return valueInDollars;
}
-(void)setValueInDollars:(int)newValueInDollars
{
    valueInDollars = newValueInDollars;
}
-(NSDate*) dateCreated
{
    return dateCreated;
}
-(void)setDateCreated:(NSDate*)newDateCreated
{
    dateCreated = newDateCreated;
}
-(NSString*)description
{
    NSString *descriptionString = [[NSString alloc] initWithFormat:@"%@ (%@): Worth $%d, recorded on %@", itemName, serialNumber, valueInDollars, dateCreated];
    return descriptionString;
}


@end
