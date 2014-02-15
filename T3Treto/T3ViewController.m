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

@property (strong, nonatomic) T3ImageDownloader* imageDownloader;
@property (nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation T3ViewController

@synthesize imageDownloader;
@synthesize imageView;
@synthesize progressView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    imageDownloader = [[T3ImageDownloader alloc] initWithDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) downloadImage
{
    NSURL *url = [NSURL URLWithString:@"http://treto.ru/img_lb/Settecento/.IT/per_sito/ambienti/01.jpg"];
    [imageDownloader downloadFrom:url];
}

- (void) imageDownloadProgress: (float) progress;
{
    [progressView setProgress:progress animated:YES];
}

- (void) imageDownloadFinished:(UIImage*) image;
{
    NSLog(@"Download finished");
    imageView.image = image;
}

- (void) imageDownloadError
{
    NSLog(@"Download error");
}

- (IBAction)onDownload:(id)sender
{
    [self downloadImage];
}

@end
