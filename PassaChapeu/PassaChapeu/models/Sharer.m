//
//  Sharer.m
//  PassaChapeu
//
//  Created by Marcos Kobuchi on 3/26/15.
//  Copyright (c) 2015 Marcos Kobuchi. All rights reserved.
//

#import "Sharer.h"


@implementation Sharer

static int uniqueIDAssigner;

#pragma mark - static methods

+ (int) getUniqueIDAssigner{
    return uniqueIDAssigner;
}

+ (void) setUniqueIDAssingerTo:(int)value{
    uniqueIDAssigner = value;
}

+ (void) uniqueIDAssignerIncrement{
    uniqueIDAssigner++;
}

#pragma mark - dinamic methods

/* Constructor. */
- (Sharer *) initWithName:(NSString *)newSharerName {

    self.uniqueID = [Sharer getUniqueIDAssigner];
    [Sharer uniqueIDAssignerIncrement];
    
    self.name = newSharerName;
    self.expenses = [NSMutableArray array];
    
    return self;
}

/* Adiciona gasto. */
- (void) assignExpense: (Expense *) expense {
    if(![self.expenses containsObject: expense])
       [self.expenses addObject:expense];
}

/* Remove gasto. */
- (void) unassingExpense: (Expense *) expense {
    [self.expenses removeObject:expense];
}

/* Soma os gasto. */
- (float) evaluateBalance {
    float sum = 0;

    /* Pego o valor de cada gasto e divido pelo número de participantes. */
    for (Expense *expense in self.expenses) {
        sum += (expense.value/expense.getNumberOfSharers);
    }

    return sum;
}

@end
