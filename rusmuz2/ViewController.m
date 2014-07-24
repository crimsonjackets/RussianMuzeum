//
//  ViewController.m
//  rusmuz
//
//  Created by Richard Topchiy on 13/05/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "ViewController.h"
#import "ExhibitViewController.h"
#import "AppDelegate.h"


ZBarReaderViewController *codeReader = nil;

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self checkCoreData];

    DatabaseManager *databaseManager = [DatabaseManager sharedInstance];
    databaseManager.exhibits = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"It Works!!!",@"http://en.m.wikipedia.org", nil];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)buttonStart:(id)sender {
    ZBarReaderViewController *codeReader = [ZBarReaderViewController new];
    codeReader.readerDelegate=self;
    codeReader.supportedOrientationsMask = ZBarOrientationMaskAll;
    ZBarImageScanner *scanner = codeReader.scanner;
    [scanner setSymbology: ZBAR_I25 config: ZBAR_CFG_ENABLE to: 0];
    [self presentViewController:codeReader animated:YES completion:nil];
}


- (void) imagePickerController: (UIImagePickerController*) reader didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    //  get the decode results
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // just grab the first barcode
        break;
    
    // showing the result on textview
    _outText = symbol.data;
    
    
    // dismiss the controller
    [self performSegueWithIdentifier:@"QRSegue" sender:self];
    [reader dismissViewControllerAnimated:YES completion:nil];
    
    
}


- (void)checkCoreData {
    self.managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSManagedObjectContext *context = self.managedObjectContext;

    NSFetchRequest *exhibits = [NSFetchRequest fetchRequestWithEntityName:@"Exhibit"];
    NSFetchRequest *rooms = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
    
    NSError *errorRoom = nil;
    NSError *errorExhibit = nil;

    if (([context countForFetchRequest:exhibits error:&errorExhibit] == 0) || ([context countForFetchRequest:rooms error:&errorRoom] == 0)) {
        NSLog(@"Core Data Entities do not exist. Creating...");
        [self getCoreData];
    }
    
    NSLog(@"Core Data exists");
}

- (void)getCoreData {
    [self createOneRoom];
    [self createExhibits];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"QRSegue"]) {
        ExhibitViewController *destination = [segue destinationViewController];
        destination.textQRCode = _outText;
    }
}







- (void)createOneRoom {
    NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Room" inManagedObjectContext:self.managedObjectContext];
    Room *room1 = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    room1.number = [NSNumber numberWithInt:78];
    NSLog(@"Room with number %@ created", room1.number);
    
    
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (void)createExhibits {
    NSManagedObjectContext *context = self.managedObjectContext;
    Room *room = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
    request.predicate = nil;
    request.fetchLimit = 1;
    NSError *error = nil;
    
    NSArray *fetchedRoom = [self.managedObjectContext executeFetchRequest:request error:&error];
    room = fetchedRoom[0];
    for (int i=0; i<10; i++) {
        Exhibit *ex = [NSEntityDescription insertNewObjectForEntityForName:@"Exhibit" inManagedObjectContext:context];
        ex.room = room;
        ex.name =[NSString stringWithFormat:@"%d", i];
        
        
        CGFloat horizontal = ( arc4random() % 640);
        CGFloat vertical = ( arc4random() % 620);
        
        ex.coordinates = [NSString stringWithFormat:@"%f,%f", horizontal, vertical];
        
        
        NSLog(@"Exhibit %@ created.",ex.name);
    }
    
    
    NSError *error1 = nil;
    if (![context save:&error1]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
}


@end
