//
//  Expense.h
//  PassaChapeu
//
//  Created by Marcos Kobuchi on 3/26/15.
//  Copyright (c) 2015 Marcos Kobuchi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Sharer;


@interface Expense : NSObject

@property int uniqueID;
@property NSString* name;
@property float value;
@property NSMutableArray* sharers;

+ (int) getUniqueIDAssigner;

+ (void) uniqueIDAssignerIncrement;

+ (void) setUniqueIDAssingerTo:(int) value;

- (Expense *) initWithName: (NSString*)name andValue: (float) value;

- (void) assignSharer : (Sharer *) sharer;
- (void) unassingSharer : (Sharer *) sharer;

- (NSInteger) getNumberOfSharers;

@end
