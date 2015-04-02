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

/*! Default constructor. 
 */
- (Controller*) initWithEvent : (Event*) event {
    _event = event;
    
    return self;
}

/*! Adiciona novo participante.
    \param NString: nome do participante
*/
- (void) addNewSharer: (NSString*) newSharerName {
    Sharer* sharer = [[Sharer alloc] initWithName: newSharerName];
    [_event addNewSharer: sharer];
}

- (Sharer*) getSharer: (NSUInteger) row {
    return [_event getSharer:row];
}

- (NSUInteger) getSharerID: (Sharer*) sharer {
    return [_event getSharerID:sharer];
}


/* Remove participante... */
/*! Remove participante em um evento
    \param Sharer  participante
 */
- (void) removeSharer: (Sharer*) sharer {
    /* ...do evento. */
    [self.event removeSharer:sharer];
    
    /* ...de todos os gastos. */
    for (Expense *expense in self.event.expenses) {
        [expense unassingSharer:sharer];
    }
}

/*! Adiciona novo gasto.
    \param String: string convertido em float representando o gasto
 */
- (void) addNewExpense: (NSString*)expenseToBeAdded withValue: (float)value{
    Expense* expense = [[Expense alloc] initWithName:expenseToBeAdded andValue: value];
    [self.event addNewExpense:expense];
}

- (Expense*) getExpense: (NSUInteger) row {
    return [_event getExpense:row];
}

- (NSUInteger) getExpenseID: (Expense*) expense {
    return [_event getExpenseID:expense];
}

/* Remove gasto... */
/*! Remove gasto.
    /param Expense: string representando o nome do gasto
*/
- (void) removeExpense: (Expense*) expense {
    /* ...do evento. */
    [self.event removeExpense:expense];
    
    /* ...de todos os participantes. */
    for (Sharer *sharer in self.event.sharers) {
        [sharer unassingExpense:expense];
    }
}

/*! Método Getter: Retorna os participantes de um dado EVENTO.
 */
- (NSMutableArray*) getSharers {
    return self.event.sharers;
}

/*! Método Getter: Retorna os gastos de um dado EVENTO
 */
- (NSMutableArray*) getExpenses {
    return self.event.expenses;
}

/*! Vincula participantes e gastos. 
 \param Expense: Gasto
 \param Sharer: Paticipante
 \return nenhum
 */
- (void) linkExpense: (Expense*) expense ToSharer: (Sharer*) sharer {
    [sharer assignExpense: expense];
    [expense assignSharer: sharer];
}

/*! Desvincula participantes e gastos. */
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
