//
//  T3ViewController.m
//
//
//  Created by Alexey Boyko on 15.02.14.
//  Copyright (c) 2014 Alexey Boyko. All rights reserved.
//

#import "T3ViewController.h"

@interface T3ViewController ()

@property (retain, nonatomic) T3ImageDownloader* imageDownloader;
@property (retain, nonatomic) NSArray* url;
@property (retain, nonatomic) UIScrollView* scrollView;
//@property (retain, nonatomic) UIProgressView* progressView;

@end

@implementation T3ViewController

@synthesize imageDownloader, url, scrollView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    imageDownloader = [[T3ImageDownloader alloc] initWithDelegate:self];
    [self initUrls];
    [self initScrollView];
}

- (void) initUrls
{
    url = [[NSArray alloc] initWithObjects:
           @"http://treto.ru/img_lb/Settecento/.IT/per_sito/ambienti/01.jpg",
           @"http://treto.ru/img_lb/Settecento/.IT/per_sito/ambienti/02.jpg",
           @"http://treto.ru/img_lb/Settecento/.IT/per_sito/ambienti/03.jpg",
           @"http://treto.ru/img_lb/Settecento/.IT/per_sito/ambienti/05.jpg",
           @"http://treto.ru/img_lb/Settecento/.IT/per_sito/ambienti/08.jpg", nil];
}

- (void) initScrollView
{
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollView.pagingEnabled = YES;
    NSInteger numberOfViews = url.count;
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width * numberOfViews, self.view.frame.size.height);
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    [self loadImageOnPage:0];
}

- (void) loadImageOnPage:(NSInteger) page
{
    [imageDownloader downloadFrom:url[page]];
//    NSInteger xOrigin = page * self.view.frame.size.width;
//    progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(xOrigin, self.view.frame.size.height / 2, self.view.frame.size.width, 5)];
//    [progressView setProgress:0];
//    [scrollView addSubview:progressView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) imageDownloadProgress: (float) progress
{
//    [progressView setProgress:progress];
}

- (void) imageDownloadFinished:(UIImage*) image
{
    NSInteger page = scrollView.contentOffset.x / self.view.frame.size.width;
    NSInteger xOrigin = page * self.view.frame.size.width;
    CGRect frame = CGRectMake(xOrigin, 0, self.view.frame.size.width, self.view.frame.size.height);
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = image;
//    [progressView removeFromSuperview];
    [scrollView addSubview:imageView];
    [imageView release];
//    [progressView release];
}

- (void) imageDownloadError
{
//    [progressView removeFromSuperview];
//    [progressView release];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scroll
{
    NSLog(@"scrollViewDidEndDecelerating");
    NSInteger page = scrollView.contentOffset.x / self.view.frame.size.width;
    [self loadImageOnPage:page];
}

- (void)dealloc
{
    for (NSURL* u in url)
    {
        [u release];
    }
    [url release];
    [imageDownloader release];
    [super dealloc];
}
@end
