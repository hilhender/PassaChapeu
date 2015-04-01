//
//  EventsViewController.m
//  PassaChapeu
//
//  Created by Andre Scherma Soleo on 31/03/15.
//  Copyright (c) 2015 Marcos Kobuchi. All rights reserved.
//

#import "EventsViewController.h"
#import "ExpensesViewController.h"
#import "Controller.h"

@interface EventsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *EventsTable;

@property Controller* controller;

@property NSMutableArray* events;

@end

@implementation EventsViewController {
    NSMutableArray *_events;
    NSString *_newEventName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _controller = [[Controller alloc] init];
    
    [_controller addNewEvent: @"Churcao"];
    [_controller addNewEvent: @"Praia"];
    [_controller addNewEvent: @"Macarronada"];
    [_controller addNewEvent: @"Churcao"];
    
    _events = _controller.EventsArray;

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
        _newEventName = eventName.text;
        [_controller addNewEvent: eventName.text];
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
    
    static NSString *CellIdentifier =@"EventCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                            forIndexPath:indexPath];
    
    Event *event = _events[indexPath.row];
    cell.textLabel.text = [event name];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    
    return [_events count];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"newEvent"]) {
        
        [_controller selectEvent: [_controller.EventsArray lastObject]];
        ExpensesViewController *destViewController = segue.destinationViewController;
        [_controller selectEvent: [_controller.EventsArray lastObject]];
        destViewController.eventName = _controller.event.name;
        
    } else if ([segue.identifier isEqualToString:@"oldEvent"]) {
       
        
        ExpensesViewController *destViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [self.EventsTable indexPathForSelectedRow];
        [_controller selectEvent: [_controller.EventsArray objectAtIndex:indexPath.row]];
        destViewController.eventName = _controller.event.name;
    }
}
 



@end
