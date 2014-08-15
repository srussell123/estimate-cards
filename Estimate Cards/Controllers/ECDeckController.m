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

- (void)ensureDeckDirectory {
    BOOL isDir = NO;
    BOOL somethingExists = [self.fileManager fileExistsAtPath:[self storagePath] isDirectory:&isDir];
    NSError *error = nil;
    
    if (somethingExists && !isDir) {
        [self.fileManager removeItemAtPath:[self storagePath] error:&error];
        
        if (error) {
            NSLog(@"DECK CONTROLLER>>ERROR>>Error removing non-directory storage path: %@", error);
        }
        
        [self.fileManager createDirectoryAtPath:[self storagePath] withIntermediateDirectories:YES attributes:nil
                                          error:&error];
        
        if (error) {
            NSLog(@"DECK CONTROLLER>>ERROR>>Error creating storage directory: %@", error);
        }
    } else if (!somethingExists) {
        [self.fileManager createDirectoryAtPath:[self storagePath] withIntermediateDirectories:YES attributes:nil
                                          error:&error];
        
        if (error) {
            NSLog(@"DECK CONTROLLER>>ERROR>>Error creating storage directory: %@", error);
        }
    } else {
        NSLog(@"DECK CONTROLLER>>INFO>>Storage directory exists");
    }
}

- (void)installStarterDecks {
    [self ensureDeckDirectory];
    
    NSString *deckFile = [[NSBundle mainBundle] pathForResource:@"Decks" ofType:@"json"];
    
    NSError *error = nil;
    NSString *name = [deckFile lastPathComponent];
    NSString *dtsPath = [[self storagePath] stringByAppendingPathComponent:name];
    [self.fileManager copyItemAtPath:deckFile toPath:dtsPath error:&error];
    
    if (error) {
        NSLog(@"DECK CONTROLLER>>ERROR>>Could not copy starter deck from bundle: %@", error);
    }
    
}

- (NSArray*)availableDecks {
    NSMutableArray *decks = [NSMutableArray array];
    NSError *error = nil;
    NSData *data = nil;
    
    NSString *filePath = [[self storagePath] stringByAppendingPathComponent:@"Decks.json"];
    data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *deckInfo = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (!error) {
        NSArray *keys = [[deckInfo objectForKey:@"decks"] allKeys];
        [decks addObjectsFromArray: keys];
    } else {
          NSLog(@"DECK CONTROLLER>>ERROR>>Could not parse json from file: %@", @"Decks.json");
    }
    
    return decks;
}

- (NSDictionary*)deckNamed:(NSString *)name {
    NSString *actualName = [name stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *file = [[self storagePath] stringByAppendingPathComponent:@"Decks.json"];
    NSData *data = [NSData dataWithContentsOfFile:file];
    NSError *error = nil;
    NSHashTable *allDecks = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error] valueForKey:@"decks"];
    if (error) {
        NSLog(@"DECK CONTROLLER>>ERROR>>Could not parse deck from file: %@", @"Decks.json");
        return nil;
    }
    NSDictionary *deck = [allDecks valueForKey:actualName];
    //NSLog(@"key=%@ value=%@", key, [deck objectForKey:key]);
    
    return deck;
}
@end
