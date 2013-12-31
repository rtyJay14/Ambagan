//
//  DataSource.h
//  Ambagan
//
//  Created by Kana on 11/28/13.
//  Copyright (c) 2013 Kana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface DataSource : NSObject

@property (nonatomic) sqlite3 *database;

- (void) setupDatabase;
- (void) openDatabase;
- (void) closeDatabase;
- (void) finalizeStatements;
- (void) test;
- (BOOL) insertAmbager : (NSString *) fullname;
- (NSMutableArray *) getAllAmbager;
- (NSMutableArray *) getAllLocations;
- (int) getLocationId : (NSString *) location;
- (BOOL) insertEvent : (int) locationid
                     : (double) bill;
- (BOOL) insertLocation : (NSString *) location;
- (int) getAmbagerId : (NSString *) name;
- (BOOL) insertAmbagan : (int) eventid
                       : (int) personid
                       : (double) amount;
- (int) getEventId;
// reports //

- (NSMutableArray *) getPeopleByDate : (int) report_date;
- (NSMutableArray *) getGastosByDate : (int) report_date;
- (NSMutableArray *) getPlaceByDate : (int) report_date;
- (NSMutableArray *) getEventsByDate : (int) report_date;
@end