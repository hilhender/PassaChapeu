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

@property NSMutableArray* sharers;
@property NSMutableArray* expenses;

- (Event*) init;

- (void) addNewSharer: (Sharer*) sharerToBeAdded;
- (void) removeSharer: (Sharer*) sharerToBeRemoved;

- (void) addNewExpense: (Expense*) expenseToBeAdded;
- (void) removeExpense: (Expense*) expenseToBeRemoved;

@end
