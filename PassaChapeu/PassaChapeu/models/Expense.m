//
//  Expense.m
//  PassaChapeu
//
//  Created by Marcos Kobuchi on 3/26/15.
//  Copyright (c) 2015 Marcos Kobuchi. All rights reserved.
//

#import "Expense.h"

@implementation Expense

static int uniqueIDAssigner;

#pragma mark - static methods

+ (int) getUniqueIDAssigner{
    return uniqueIDAssigner;
}

+ (void) uniqueIDAssignerIncrement{
    uniqueIDAssigner++;
}

+ (void) setUniqueIDAssingerTo:(int) value{
    uniqueIDAssigner = value;
}

#pragma mark - dinamic methods

/* Default Constructor. */
- (Expense *) initWithName:(NSString *)name andValue:(float)value {
    self.uniqueID = [Expense getUniqueIDAssigner];
    [Expense uniqueIDAssignerIncrement];
    
    self.name = name;
    self.value = value;
    self.sharers = [NSMutableArray array];
    
    return self;
}

/* Adiciona participante. */
- (void) assignSharer : (Sharer *) sharer {
    if (![self.sharers containsObject:sharer])
        [self.sharers addObject:sharer];
}

/* Remove Participante. */
- (void) unassingSharer : (Sharer *) sharer{
    [self.sharers removeObject:sharer];
}

/* Retorna o numero de participantes no gasto. */
- (NSInteger) getNumberOfSharers {
    return self.sharers.count;
}


@end
