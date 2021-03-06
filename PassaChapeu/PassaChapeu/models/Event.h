//
//  Event.h
//  PassaChapeu
//
//  Created by Marcos Kobuchi on 3/26/15.
//  Copyright (c) 2015 Marcos Kobuchi. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "Sharer.h"
#import "Expense.h"

@interface Event : NSObject

@property NSString* name;
@property NSDate* dateEvent;

@property NSMutableArray* sharers;
@property NSMutableArray* expenses;

- (Event*) initWithName: (NSString*) newEventName;

- (void) addNewSharer: (Sharer*) sharerToBeAdded;
- (Sharer*) getSharer: (NSUInteger) row;
- (NSUInteger) getSharerID: (Sharer*) sharer;
- (void) removeSharer: (Sharer*) sharerToBeRemoved;

- (void) addNewExpense: (Expense*) expenseToBeAdded;
- (Expense*) getExpense: (NSUInteger) row;
- (NSUInteger) getExpenseID: (Expense*) expense;
- (void) removeExpense: (Expense*) expenseToBeRemoved;

- (float) getContributedValue;
- (float) getTotalCost;

@end
