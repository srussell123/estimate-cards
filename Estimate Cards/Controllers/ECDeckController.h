//
//  ECDeckController.h
//  Estimate Cards
//
//  Created by Christopher Martin on 5/6/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECDeckController : NSObject

- (void)installStarterDecks;
- (NSArray*)availableDecks;
- (NSDictionary*)deckNamed:(NSString*)name;

@end
