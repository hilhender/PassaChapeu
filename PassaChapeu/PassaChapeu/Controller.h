//
//  Controller.h
//  PassaChapeu
//
//  Created by Marcos Kobuchi on 3/26/15.
//  Copyright (c) 2015 Marcos Kobuchi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sharer.h"
#import "Expense.h"
#import "Event.h"

@interface Controller : NSObject

@property NSMutableArray* EventsArray;

@property Event* event;

- (Controller *) init;

- (void) addNewEvent: (NSString*) newEventName;
- (void) removeEvent: (Event*) eventToBeRemoved;
- (void) selectEvent: (Event*) selectedEvent;

- (void) addNewSharer: (NSString*) newSharerName;
- (void) removeSharer: (Sharer*) sharerToBeRemoved;

- (void) addNewExpense: (NSString*) expenseToBeAdded withValue: (float) value;
- (void) removeExpense: (Expense*) expenseToBeRemoved;

- (NSMutableArray*) getSharers;
- (NSMutableArray*) getExpenses;

- (void) linkExpense: (Expense *) expense ToSharer: (Sharer *)sharer;
- (void) unlinkExpense: (Expense*) expense ToSharer: (Sharer *)sharer;

- (float) getContributedValue;
- (float) getTotalCost;

@end
