//
//  ECDeckController.m
//  Estimate Cards
//
//  Created by Christopher Martin on 5/6/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "ECDeckController.h"

NSString *const ECDeckFolder =  @"net.shadyproject.EstimateCards.Decks";

@interface ECDeckController ()
@property (nonatomic, strong) NSFileManager *fileManager;
@end

@implementation ECDeckController

- (id)init {
    if (self = [super init]) {
        _fileManager = [NSFileManager defaultManager];
    }
    
    return self;
}

- (NSString*)storagePath {
    NSArray *dirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [dirs firstObject];
    
    return [path stringByAppendingPathComponent:ECDeckFolder];
}

- (void)installStarterDecks {
    NSArray *startDecks = [[NSBundle mainBundle] pathsForResourcesOfType:@"json" inDirectory:nil];
    
    __block NSError *error = nil;
    __weak typeof(self)weakSelf = self;
    [startDecks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf.fileManager copyItemAtPath:obj toPath:[strongSelf storagePath] error:&error];
        
        if (error) {
            NSLog(@"DECK CONTROLLER>>ERROR>>Could not copy starter deck from bundle: %@", error);
        }
    }];
}

- (NSArray*)availableDecks {
    NSMutableArray *decks = [NSMutableArray array];
    NSError *error = nil;
    NSData *data = nil;
    
    for (NSString *file in [self.fileManager enumeratorAtPath:[self storagePath]]) {
        if ([@"json" isEqualToString:[file lastPathComponent]]) {
            data = [NSData dataWithContentsOfFile:file];
            NSDictionary *deckInfo = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            
            if (!error) {
                [decks addObject:deckInfo[@"name"]];
            } else {
                NSLog(@"DECK CONTROLLER>>ERROR>>Could not parse json from file: %@", file);
                continue;
            }
        }
    }
    
    return decks;
}

- (NSDictionary*)deckNamed:(NSString *)name {
    NSString *path = [[self storagePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json", name]];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *error = nil;
    NSDictionary *deck = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (error) {
        NSLog(@"DECK CONTROLLER>>ERROR>>Could not parse deck from file: %@", path);
        return nil;
    }
    
    return deck;
}
@end
