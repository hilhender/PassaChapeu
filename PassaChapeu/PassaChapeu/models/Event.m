//
//  Event.m
//  PassaChapeu
//
//  Created by Marcos Kobuchi on 3/26/15.
//  Copyright (c) 2015 Marcos Kobuchi. All rights reserved.
//

#import "Event.h"

@interface Event()

@end

@implementation Event


/* Default constructor. */
- (Event*) initWithName: (NSString*) newEventName{
    self.name = newEventName;
    
    [Sharer setUniqueIDAssingerTo:0];
    [Expense setUniqueIDAssingerTo:0];
    
    self.sharers = [NSMutableArray array];
    self.expenses = [NSMutableArray array];
    
    _dateEvent = [[NSDate alloc] init];
    
    return self;
}

/* Adiciona novo participante. */
- (void) addNewSharer: (Sharer*) sharer {
    [self.sharers addObject:sharer];
}

- (Sharer*) getSharer: (NSUInteger) row {
    return [_sharers objectAtIndex:row];
}

- (NSUInteger) getSharerID: (Sharer*) sharer {
    return [_sharers indexOfObject:sharer];
}

/* Remove participante. */
- (void) removeSharer: (Sharer*) sharer {
    [self.sharers removeObject:sharer];
}

/* Adiciona gasto. */
- (void) addNewExpense: (Expense*) expense {
    [self.expenses addObject:expense];
}

- (Expense*) getExpense: (NSUInteger) row {
    return [_expenses objectAtIndex:row];
}

- (NSUInteger) getExpenseID: (Expense*) expense {
    return [_expenses indexOfObject:expense];
}

/* Remove gasto. */
- (void) removeExpense: (Expense*) expense {
    [self.expenses removeObject:expense];
}

/* Retorna o valor de contribuição total. */
- (float) getContributedValue {
    float value = 0;
    
    for (Sharer *sharer in self.sharers) {
        value += sharer.contributedValue;
    }
    
    return value;
}

/* Retorna o valor de contribuição total. */
- (float) getTotalCost {
    float value = 0;

    for (Expense *expense in self.expenses) {
        value += expense.value;
    }

    return value;
}

@end
