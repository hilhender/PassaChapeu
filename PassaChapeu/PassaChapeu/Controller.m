//
//  Controller.m
//  PassaChapeu
//
//  Created by Marcos Kobuchi on 3/26/15.
//  Copyright (c) 2015 Marcos Kobuchi. All rights reserved.
//

#import "Controller.h"

@interface Controller()

@end

@implementation Controller

/* Default constructor. */
- (Controller*) init {
    _EventsArray = [[NSMutableArray alloc] init];
    
    return self;
}

/*Adiciona novo evento*/
//Dois eventos distintos podem ter exatamente o mesmo nome, porem serao
//eventos diferentes (com enderecos diferentes)
- (void) addNewEvent:(NSString *)newEventName{
    [_EventsArray addObject: [[Event alloc] initWithName: newEventName]];
}

/*Remove evento*/
- (void) removeEvent:(Event *)eventToBeRemoved{
    [_EventsArray removeObject: eventToBeRemoved];
}

/*Seleciona evento a ser operado por Controller*/
- (void) selectEvent:(Event *)selectedEvent{
    self.event = selectedEvent;
}

/* Adiciona novo participante. */
- (void) addNewSharer: (NSString*) newSharerName {
    Sharer* sharer = [[Sharer alloc] initWithName: newSharerName];
    [self.event addNewSharer: sharer];
}

/* Remove participante... */
- (void) removeSharer: (Sharer*) sharer {
    /* ...do evento. */
    [self.event removeSharer:sharer];
    
    /* ...de todos os gastos. */
    for (Expense *expense in self.event.expenses) {
        [expense unassingSharer:sharer];
    }
}

/* Adiciona gasto. */
- (void) addNewExpense: (NSString*)expenseToBeAdded withValue: (float)value{
    Expense* expense = [[Expense alloc] initWithName:expenseToBeAdded andValue: value];
    [self.event addNewExpense:expense];
}

/* Remove gasto... */
- (void) removeExpense: (Expense*) expense {
    /* ...do evento. */
    [self.event removeExpense:expense];
    
    /* ...de todos os participantes. */
    for (Sharer *sharer in self.event.sharers) {
        [sharer unassingExpense:expense];
    }
}

/* Retorna os participantes. */
- (NSMutableArray*) getSharers {
    return self.event.sharers;
}

/* Retorna os gastos. */
- (NSMutableArray*) getExpenses {
    return self.event.expenses;
}

/* Vincula participantes e gastos. */
- (void) linkExpense: (Expense*) expense ToSharer: (Sharer*) sharer {
    [sharer assignExpense: expense];
    [expense assignSharer: sharer];
}

/* Desvincula participantes e gastos. */
- (void) unlinkExpense: (Expense*) expense ToSharer: (Sharer*) sharer {
    [sharer unassingExpense: expense];
    [expense unassingSharer: sharer];
}

- (float) getContributedValue {
    return [self.event getContributedValue];
}

- (float) getTotalCost {
    return [self.event getTotalCost];
}

@end
