//
//  T3ViewController.m
//
//
//  Created by Alexey Boyko on 15.02.14.
//  Copyright (c) 2014 Alexey Boyko. All rights reserved.
//

#import "T3ViewController.h"

@interface T3ViewController ()

@property (nonatomic) T3ImageDownloader* imageDownloader;
@property (nonatomic) NSArray* url;

@end

@implementation T3ViewController

@synthesize imageDownloader, url;

- (void)viewDidLoad
{
    [super viewDidLoad];
    imageDownloader = [[T3ImageDownloader alloc] initWithDelegate:self];
    [self initUrls];
}

- (void) initUrls
{
    url = [[NSArray alloc] initWithObjects:[NSURL URLWithString:@"http://treto.ru/img_lb/Settecento/.IT/per_sito/ambienti/01.jpg"],
                                           [NSURL URLWithString:@"http://treto.ru/img_lb/Settecento/.IT/per_sito/ambienti/02.jpg"],
                                           [NSURL URLWithString:@"http://treto.ru/img_lb/Settecento/.IT/per_sito/ambienti/02.jpg"],
                                           [NSURL URLWithString:@"http://treto.ru/img_lb/Settecento/.IT/per_sito/ambienti/05.jpg"],
                                           [NSURL URLWithString:@"http://treto.ru/img_lb/Settecento/.IT/per_sito/ambienti/08.jpg"], nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) downloadImage
{
}

- (void) imageDownloadProgress: (float) progress;
{
}

- (void) imageDownloadFinished:(UIImage*) image;
{
}

- (void) imageDownloadError
{
}

@end
