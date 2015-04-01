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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //_events = [[NSMutableArray alloc] init];
    _eventsOnMemory = [[NSMutableArray alloc] init];
    
    [_eventsOnMemory addObject:[[Event alloc] initWithName:@"Churcao"]];
    [_eventsOnMemory addObject:[[Event alloc] initWithName:@"Praia"]];
    [_eventsOnMemory addObject:[[Event alloc] initWithName:@"Macarronada"]];
    [_eventsOnMemory addObject:[[Event alloc] initWithName:@"Churcao"]];
   /*
    [_events addObject:@"Churcao"];
    [_events addObject:@"Praia"];
    [_events addObject:@"Macarronada"];
    [_events addObject:@"Churcao"];
    */
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
        //newEventName = eventName.text;
        [_eventsOnMemory addObject: [[Event alloc] initWithName: eventName.text]];
        [self.EventsTable reloadData];

        [self performSegueWithIdentifier:@"newEvent" sender:self];
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
    static NSString *CellIdentifier = @"EventCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Event *event = _eventsOnMemory[indexPath.row];
    cell.textLabel.text = event.name;

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{

    return [_eventsOnMemory count];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"newEvent"]) {
        
        ExpensesViewController *destViewController = segue.destinationViewController;
        destViewController.event = [_eventsOnMemory lastObject];
        
    } else if ([segue.identifier isEqualToString:@"oldEvent"]) {
       
        
        ExpensesViewController *destViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [self.EventsTable indexPathForSelectedRow];
        destViewController.event = [_eventsOnMemory objectAtIndex:indexPath.row];
        NSLog(@"%@", destViewController.event.name);
    }
}
 



@end
