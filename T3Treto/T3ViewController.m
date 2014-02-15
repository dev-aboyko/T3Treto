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

@property (nonatomic) T3ImageDownloader* imageDownloader;

@end

@implementation T3ViewController

@synthesize imageDownloader;

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
