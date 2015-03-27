//
//  ViewController.m
//  PassaChapeu
//
//  Created by Marcos Kobuchi on 3/26/15.
//  Copyright (c) 2015 Marcos Kobuchi. All rights reserved.
//

#import "ViewController.h"
#import "Controller.h"

@interface ViewController ()

@property Controller *controller;

@end

@implementation ViewController

- (void)viewDidLoad {
    self.controller = [[Controller alloc] init];
    
    //teste do model
    
    
    
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
-(IBAction)cadastreEvent(id)sender {


//#pragma mark - Data source
//visualization of events recorded
//New event


/* O MAIOR PROBLEMA EH MANTER A COERENCIA DE DADOS (BASE DE DADOS E O QUE ESTÁ SENDO EXIBIDO NA TELA!). */
/* SE EU ADIOCIONAR NOVO GASTO OU PARTICIPANTE, PRECISO RECARREGAR A TELA???? */


@end
