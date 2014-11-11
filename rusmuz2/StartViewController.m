//
//  StartViewController.m
//  RussianMuseum
//
//  Created by admin on 13.08.14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "StartViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationButton.buttonKind = startVC;
    self.navigationButton.delegate = self;
    
    self.managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];

    [self checkCoreData];
    
    [self showExhibit:[self getRandomExhibit]];

}

#pragma mark - fetching random exhibit
- (Exhibit *)getRandomExhibit {
    NSManagedObjectContext *context = self.managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Exhibit"];
    request.predicate = nil;
    NSError *error = nil;
    
    NSArray *fetchedExhibits = [context executeFetchRequest:request error:&error];
    Exhibit *exhibit = fetchedExhibits[arc4random_uniform([fetchedExhibits count])];

//    UIImage *picture = [UIImage imageWithData:exhibit.picture scale:2];
    return  exhibit;
}

- (void)showExhibit:(Exhibit *)exhibit {

// заккоментировал, так как показывает серый экран
// поставлю заглушку
//    self.imageView.image = [UIImage imageWithData:exhibit.picture scale:2];
    self.imageView.image = [UIImage imageNamed:@"picture"];
    self.titleLabel.text = exhibit.name;
    self.authorLabel.text = exhibit.author;
}




#pragma mark - fetching CoreData // RESTKit
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
- (void)createOneRoom {
    NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Room" inManagedObjectContext:self.managedObjectContext];
    Room *room1 = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    room1.number = @78;
    
    NSLog(@"Room with number %@ created", room1.number);
    
    
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (Room *)fetchTheRoom {
    NSManagedObjectContext *context = self.managedObjectContext;
    Room *room = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
    NSNumber *roomNumber = @78;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"number == %@", roomNumber];
    request.predicate = predicate;
    request.fetchLimit = 1;
    NSError *error = nil;
    
    NSArray *fetchedRoom = [context executeFetchRequest:request error:&error];
    room = fetchedRoom[0];
    NSLog(@"Room is: %@", room);
    return room;
}

- (void)createExhibits {
    NSManagedObjectContext *context = self.managedObjectContext;
    Room *room = [self fetchTheRoom];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
    request.predicate = nil;
    request.fetchLimit = 1;
    NSError *error = nil;
    
    NSArray *fetchedRoom = [self.managedObjectContext executeFetchRequest:request error:&error];
    room = fetchedRoom[0];
    for (int i = 0; i < 20; i++) {
        Exhibit *ex = [NSEntityDescription insertNewObjectForEntityForName:@"Exhibit" inManagedObjectContext:context];
        ex.room = room;
        NSString *exhibit = [NSString stringWithFormat:@"Экспонат номер %d", i];
        ex.name = exhibit;
        ex.author = [NSString stringWithFormat:@"Автор экспоната номер %d", i];
        
        ex.photoURL = @"http://spbfoto.spb.ru/foto/data/media/1/rusmus.jpg";

        //ex.picture = UIImageJPEGRepresentation([UIImage imageNamed:@"picture"], 1.0f);
        
        
        
        
        ex.info = [NSString stringWithFormat:@"%@ Брюллов посетил Помпеи в 1828 году, сделав много набросков для будущей картины про известное извержение вулкана Везувий в 79 году н. э. и разрушение города Помпеи близ Неаполя. Полотно выставлялось в Риме, где получило восторженные отклики критиков и переправлено в парижский Лувр. Эта работа стала первой картиной художника, вызвавшей такой интерес за рубежом. Вальтер Скотт назвал картину «необычной, эпической».", exhibit];
        
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

#pragma mark - Navigation Button methods
- (void)homeButtonPressed {
    NSLog(@"Home button pressed, ViewController");
//    StartViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"StartViewController"];
//    [self presentViewController:vc animated:YES completion:nil];
}

- (void)QRButtonPressed {
    UINavigationController *nvc = [self.storyboard instantiateViewControllerWithIdentifier:@"QRNVC"];
    //QRViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"QRViewController"];
    [self presentViewController:nvc animated:YES completion:nil];
    NSLog(@"QR button pressed, ViewController");
}

- (void)mapButtonPressed {
    FloorSelectorViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FloorSelectorViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)sponsorButtonPressed {
    FloorSelectorViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SponsorViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}


- (IBAction)playerButtonPressed:(id)sender {
    NSURL *url = [NSURL URLWithString:
                  @"http://www.jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v"];
    
    NSLog(@"URL: %@", url);

    MPMoviePlayerViewController *c = [[MPMoviePlayerViewController alloc]
                                      initWithContentURL:url];

    
    [self presentMoviePlayerViewControllerAnimated:c];
}
@end
