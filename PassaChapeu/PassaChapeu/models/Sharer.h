//
//  Sharer.h
//  PassaChapeu
//
//  Created by Marcos Kobuchi on 3/26/15.
//  Copyright (c) 2015 Marcos Kobuchi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Expense.h"

@interface Sharer : NSObject

@property int uniqueID;
@property NSString* name;
@property NSMutableArray* expenses;
@property float contributedValue;

+ (int) getUniqueIDAssigner;

+ (void) uniqueIDAssignerIncrement;

+ (void) setUniqueIDAssingerTo:(int) value;

- (Sharer *) initWithName: (NSString*) newSharerName;

- (void) assignExpense : (Expense *) expense;
- (void) unassingExpense : (Expense *) expense;

- (float) evaluateBalance;

@end
