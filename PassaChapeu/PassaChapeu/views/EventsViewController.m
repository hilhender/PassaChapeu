//
//  EventsViewController.m
//  PassaChapeu
//
//  Created by Andre Scherma Soleo on 31/03/15.
//  Copyright (c) 2015 Marcos Kobuchi. All rights reserved.
//

#import "EventsViewController.h"
#import "ExpensesViewController.h"

@interface EventsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *EventsTable;

//@property NSMutableArray* events;
@property NSMutableArray* eventsOnMemory;

@end

@implementation EventsViewController


# pragma mark - ViewController methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //_events = [[NSMutableArray alloc] init];
    _eventsOnMemory = [[NSMutableArray alloc] init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnNovo:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Atenção" message:@"Insira o nome do evento:" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancelar", @"Cancel action") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        /* Implementa o botao cancelar. */
        NSLog(@"Cancel action");
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK action") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        /* Implementa o botão OK. */
        UITextField *eventName = alert.textFields.firstObject;
        
        /* Verifica se insiro um nome válido. */
        if (![eventName.text compare:@""]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Atenção" message:@"Insira o nome do evento!" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK action") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                /* Implementa o botao cancelar. */
            }];
            
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            [_eventsOnMemory insertObject:[[Event alloc] initWithName: eventName.text] atIndex:0];
            [self.EventsTable reloadData];
            
            [self performSegueWithIdentifier:@"newEvent" sender:self];
        }
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"Nome do Evento", @"EventName");
    }];

    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource required methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([tableView isEqual: _EventsTable]){
        static NSString *CellIdentifier = @"EventCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

        Event *event = _eventsOnMemory[indexPath.row];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];

        cell.textLabel.text = event.name;
        cell.detailTextLabel.text = [dateFormat stringFromDate:event.dateEvent];

        return cell;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_eventsOnMemory count];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];

    if([tableView isEqual: _EventsTable]){
        [_eventsOnMemory removeObject:[_eventsOnMemory objectAtIndex:row]];
        [_EventsTable reloadData];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0) {
    return @"X";
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"newEvent"]) {
        
        ExpensesViewController *destViewController = segue.destinationViewController;
        destViewController.controller = [[Controller alloc] initWithEvent:[_eventsOnMemory firstObject]];

    } else if ([segue.identifier isEqualToString:@"oldEvent"]) {

        ExpensesViewController *destViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [self.EventsTable indexPathForSelectedRow];
        destViewController.controller = [[Controller alloc] initWithEvent:[_eventsOnMemory objectAtIndex:indexPath.row]];

        [_EventsTable deselectRowAtIndexPath:indexPath animated:YES];
    }
}
 



@end
