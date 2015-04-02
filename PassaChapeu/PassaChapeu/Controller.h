//
//  Controller.h
//  PassaChapeu
//
//  Created by Marcos Kobuchi on 3/26/15.
//  Copyright (c) 2015 Marcos Kobuchi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Sharer.h"
#import "Expense.h"
#import "Event.h"

@interface Controller : NSObject
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property Event* event;

- (Controller *) initWithEvent : (Event*) event;

- (void) addNewSharer: (NSString*) newSharerName;
- (Sharer*) getSharer: (NSUInteger) row;
- (NSUInteger) getSharerID: (Sharer*) sharer;
- (void) removeSharer: (Sharer*) sharerToBeRemoved;

- (void) addNewExpense: (NSString*) expenseToBeAdded withValue: (float) value;
- (Expense*) getExpense: (NSUInteger) row;
- (NSUInteger) getExpenseID: (Expense*) expense;
- (void) removeExpense: (Expense*) expenseToBeRemoved;

- (NSMutableArray*) getSharers;
- (NSMutableArray*) getExpenses;

- (void) linkExpense: (Expense *) expense ToSharer: (Sharer *)sharer;
- (void) unlinkExpense: (Expense*) expense ToSharer: (Sharer *)sharer;

- (float) getContributedValue;
- (float) getTotalCost;

@end
