//
//  ViewController.m
//  rusmuz
//
//  Created by Richard Topchiy on 13/05/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "ViewController.h"
#import "QRViewController.h"

ZBarReaderViewController *codeReader = nil;

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //NSDictionary *qrcodes = [[NSDictionary alloc]initWithObjectsAndKeys:@"It Works!!!",@"http://en.m.wikipedia.org", nil];
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



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"QRSegue"]) {
        QRViewController *secView = [segue destinationViewController];
        secView.textQRCode = _outText;
    }
}





@end
