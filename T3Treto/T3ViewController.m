//
//  T3ViewController.m
//
//
//  Created by Alexey Boyko on 15.02.14.
//  Copyright (c) 2014 Alexey Boyko. All rights reserved.
//

#import "T3ViewController.h"

@interface T3ViewController ()

{
    CGRect landscape;
}

@property (retain, nonatomic) T3ImageDownloader* imageDownloader;
@property (retain, nonatomic) NSArray* url;
@property (retain, nonatomic) UIScrollView* scrollView;
@property (assign, nonatomic) UIImageView* imageView;
@property (assign, nonatomic) UIProgressView* progressView;

@end

@implementation T3ViewController

@synthesize imageDownloader, url, scrollView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    imageDownloader = [[T3ImageDownloader alloc] initWithDelegate:self];
    landscape = CGRectMake(0, 20, self.view.frame.size.height, self.view.frame.size.width);
    [self addUrls];
    [self addScrollView];
    [self addImageViews:url.count];
    [self loadImageOnPage:0];
}

- (void) addUrls
{
    url = [[NSArray alloc] initWithObjects:
           @"http://treto.ru/img_lb/Settecento/.IT/per_sito/ambienti/01.jpg",
           @"http://treto.ru/img_lb/Settecento/.IT/per_sito/ambienti/02.jpg",
           @"http://treto.ru/img_lb/Settecento/.IT/per_sito/ambienti/03.jpg",
           @"http://treto.ru/img_lb/Settecento/.IT/per_sito/ambienti/05.jpg",
           @"http://treto.ru/img_lb/Settecento/.IT/per_sito/ambienti/08.jpg", nil];
}

- (void) addScrollView
{
    scrollView = [[UIScrollView alloc] initWithFrame:landscape];
    scrollView.pagingEnabled = YES;
    NSUInteger numberOfViews = url.count;
    scrollView.contentSize = CGSizeMake(landscape.size.width * numberOfViews, landscape.size.height);
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
}

- (void) addImageViews:(NSUInteger) numberOfViews
{
    for (NSUInteger page = 0; page != numberOfViews; ++page)
    {
        NSInteger xOrigin = page * landscape.size.width;
        CGRect frame = CGRectMake(xOrigin, 0, landscape.size.width, landscape.size.height);
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [scrollView addSubview:imageView];
        [imageView release];
    }
}

- (void) loadImageOnPage:(NSInteger) page
{
    self.imageView = (UIImageView*)[self.scrollView.subviews objectAtIndex:page];
    if (self.imageView.image == nil)
    {
        NSInteger xOrigin = page * landscape.size.width;
        CGRect frame = CGRectMake(xOrigin, landscape.size.height / 2, landscape.size.width, 5);
        self.progressView = [[UIProgressView alloc] initWithFrame:frame];
        [self.progressView setProgress:0];
        [self.scrollView addSubview:self.progressView];
        self.scrollView.scrollEnabled = NO;
        [imageDownloader downloadFrom:url[page]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) imageDownloadProgress: (float) progress
{
    [self.progressView setProgress:progress];
}

- (void) imageDownloadFinished:(UIImage*) image
{
    self.imageView.image = image;
    [self.progressView removeFromSuperview];
    [self.progressView release];
    self.progressView = nil;
    self.scrollView.scrollEnabled = YES;
}

- (void) imageDownloadError
{
    [self.progressView removeFromSuperview];
    [self.progressView release];
    self.progressView = nil;
    self.scrollView.scrollEnabled = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scroll
{
    NSInteger page = scrollView.contentOffset.x / landscape.size.width;
    [self loadImageOnPage:page];
}

- (void)dealloc
{
    [url release];
    [imageDownloader release];
    [scrollView release];
    [super dealloc];
}
@end
