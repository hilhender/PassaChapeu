//
//  Expense.m
//  PassaChapeu
//
//  Created by Marcos Kobuchi on 3/26/15.
//  Copyright (c) 2015 Marcos Kobuchi. All rights reserved.
//

#import "Expense.h"

@implementation Expense

/* Default Constructor. */
- (Expense *) initWithName:(NSString *)name andValue:(float)value {
    self.name = name;
    self.value = value;
    self.sharers = [NSMutableArray array];
    
    return self;
}

/* Adiciona participante. */
- (void) assignSharer : (Sharer *) sharer {
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
