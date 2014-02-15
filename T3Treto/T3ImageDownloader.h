//
//  T3ImageDownloader.h
//  T3Treto
//
//  Created by Alexey Boyko on 15.02.14.
//  Copyright (c) 2014 Alexey Boyko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol T3ImageDownloaderDelegate

- (void) imageDownloadProgress: (float) progress;
- (void) imageDownloadFinished:(UIImage*) image;
- (void) imageDownloadError;

@end

@interface T3ImageDownloader : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, assign) id<T3ImageDownloaderDelegate> delegate;

- (id) initWithDelegate:(id<T3ImageDownloaderDelegate>) delegate;
- (void) downloadFrom:(NSURL*) url;

@end
