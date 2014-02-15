//
//  T3ViewController.m
//
//
//  Created by Alexey Boyko on 15.02.14.
//  Copyright (c) 2014 Alexey Boyko. All rights reserved.
//

#import "T3ViewController.h"

/*
 http://treto.ru/img_lb/Settecento/.IT/per_sito/ambienti/01.jpg
 http://treto.ru/img_lb/Settecento/.IT/per_sito/ambienti/02.jpg
 http://treto.ru/img_lb/Settecento/.IT/per_sito/ambienti/03.jpg
 http://treto.ru/img_lb/Settecento/.IT/per_sito/ambienti/05.jpg
 http://treto.ru/img_lb/Settecento/.IT/per_sito/ambienti/08.jpg
 */

@interface T3ViewController ()

@property (nonatomic) NSMutableData *imageData;
@property (nonatomic) NSUInteger totalBytes;
@property (nonatomic) NSUInteger receivedBytes;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation T3ViewController

@synthesize imageView, progressView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) downloadImage
{
    NSURL *url = [NSURL URLWithString:@"http://treto.ru/img_lb/Settecento/.IT/per_sito/ambienti/01.jpg"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)urlResponse
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) urlResponse;
    NSDictionary *dict = httpResponse.allHeaderFields;
    NSString *lengthString = [dict valueForKey:@"Content-Length"];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *length = [formatter numberFromString:lengthString];
    self.totalBytes = length.unsignedIntegerValue;
    self.imageData = [[NSMutableData alloc] initWithCapacity:self.totalBytes];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.imageData appendData:data];
    self.receivedBytes += data.length;
    NSLog(@"didReceiveData. Length: %d, total: %d", data.length, self.imageData.length);
    [progressView setProgress:(self.receivedBytes / self.totalBytes)];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Download finished");
    imageView.image = [UIImage imageWithData:self.imageData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Download error");
}

- (IBAction)onDownload:(id)sender
{
    [self downloadImage];
}

@end
