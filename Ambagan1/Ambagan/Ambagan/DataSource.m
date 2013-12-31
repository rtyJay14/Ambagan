//
//  DataSource.m
//  Ambagan
//
//  Created by Kana on 11/28/13.
//  Copyright (c) 2013 Kana. All rights reserved.
//

#import "DataSource.h"
#define DATABASE_FILE @"ambag_2.sqlite"

@implementation DataSource

@synthesize database = _database;

static sqlite3_stmt *update_statement = nil;
static sqlite3_stmt *insert_statement = nil;
static sqlite3_stmt *select_statement = nil;
static sqlite3_stmt *init_statement = nil;

-(void) setupDatabase{
    NSLog(@"setupDatabase");
    
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryDirectory = [paths objectAtIndex:0];
    
    BOOL success = [[NSFileManager defaultManager] fileExistsAtPath:[libraryDirectory stringByAppendingPathComponent:DATABASE_FILE]];
    
    if (!success) {
        success = [[NSFileManager defaultManager] copyItemAtPath:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:DATABASE_FILE] toPath:[libraryDirectory stringByAppendingPathComponent:DATABASE_FILE] error:&error];
        
        if (!success) {
            NSAssert1(0, @"Failed to create writable database fle with message '%@'.", [error localizedDescription]);
        } else {
            [self openDatabase];
        }
    } else {
        [self openDatabase];
    }
}

-(void) openDatabase{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSLog(@"openDatabase");
    if (sqlite3_open([[[paths objectAtIndex:0] stringByAppendingPathComponent:DATABASE_FILE] UTF8String], &_database) != SQLITE_OK) {
        NSLog(@"Cannot create a database connection.");
    }
}

-(void) closeDatabase{
    [self finalizeStatements];
    sqlite3_close(_database);
}

-(void) finalizeStatements{
    if(update_statement){
        sqlite3_finalize(update_statement);
        update_statement = nil;
    }
    if(insert_statement){
        sqlite3_finalize(insert_statement);
        insert_statement = nil;
    }
    if(select_statement){
        sqlite3_finalize(select_statement);
        select_statement = nil;
    }
    if(init_statement){
        sqlite3_finalize(init_statement);
        init_statement = nil;
    }
}
- (void) test{
    NSLog(@"test");
}
- (NSMutableArray *) getAllLocations{
    NSLog(@"getAllLocations");
    self.database = _database;
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    if(select_statement == nil){
        static const char *sql = "SELECT location FROM location";
        if(sqlite3_prepare_v2(self.database, sql, -1, &select_statement, NULL) != SQLITE_OK){
            NSAssert1(0, @"Error: failed to prepare statement with '%s'.", sqlite3_errmsg(self.database));
        }
    }
    
    char *str;
    
    while(sqlite3_step(select_statement) == SQLITE_ROW){
        NSString *pips = [[NSString alloc] init];
        str = (char *) sqlite3_column_text(select_statement, 0);
        pips = (str) ? [NSString stringWithUTF8String:str] : @"";
        [list addObject:pips];
    }
    
    sqlite3_reset(select_statement);
    select_statement = nil;
    
    return list;
}

- (NSMutableArray *) getAllAmbager {
    NSLog(@"getAllAmbager");
    self.database = _database;
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
   if(select_statement == nil){
        static const char *sql = "SELECT name FROM person";
        if(sqlite3_prepare_v2(self.database, sql, -1, &select_statement, NULL) != SQLITE_OK){
            NSAssert1(0, @"Error: failed to prepare statement with '%s'.", sqlite3_errmsg(self.database));
        }
    }
    
    char *str;
    
    while(sqlite3_step(select_statement) == SQLITE_ROW){
        NSString *pips = [[NSString alloc] init];
        str = (char *) sqlite3_column_text(select_statement, 0);
        pips = (str) ? [NSString stringWithUTF8String:str] : @"";
        [list addObject:pips];
    }
    
    sqlite3_reset(select_statement);
    select_statement = nil;
    
    return list;
}

- (BOOL) insertAmbager : (NSString *) fullname
{
    self.database = _database;
    
    NSLog(@"insertAmbager");
    if (insert_statement == nil) {
        static const char *sql = "INSERT INTO person (name) VALUES(?)";
        
        if (sqlite3_prepare_v2(self.database, sql, -1, &insert_statement, NULL) != SQLITE_OK) {
            NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(self.database));
        }
    }
	
    sqlite3_bind_text(insert_statement, 1, [fullname UTF8String], -1, SQLITE_TRANSIENT);
    
    int success = sqlite3_step(insert_statement);
    sqlite3_reset(insert_statement);
	
    if (success == SQLITE_ERROR) {
        NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(self.database));
        return false;
    }
    sqlite3_reset(insert_statement);
    insert_statement = nil;
    return true;
}

- (BOOL) insertLocation: (NSString*) location{
    self.database = _database;
    
    NSLog(@"insertLocation");
    if (insert_statement == nil) {
        static const char *sql = "INSERT INTO location (location) VALUES(?)";
        
        if (sqlite3_prepare_v2(self.database, sql, -1, &insert_statement, NULL) != SQLITE_OK) {
            NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(self.database));
        }
    }
	
    sqlite3_bind_text(insert_statement, 1, [location UTF8String], -1, SQLITE_TRANSIENT);
    
    int success = sqlite3_step(insert_statement);
    sqlite3_reset(insert_statement);
	
    if (success == SQLITE_ERROR) {
        NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(self.database));
        return false;
    }
    sqlite3_reset(insert_statement);
    insert_statement = nil;
    return true;
}

-(int) getLocationId:(NSString *)location{
    NSLog(@"getLocationId");
    self.database = _database;
	
	if (select_statement == nil) {
		static const char *sql = "SELECT id FROM location WHERE location=?";
		if (sqlite3_prepare_v2(self.database, sql, -1, &select_statement, NULL) != SQLITE_OK) {
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(self.database));
		}
	} else {
        NSLog(@"hindi nag reset.");
    }
    
    sqlite3_bind_text(select_statement, 1, [location UTF8String], -1, SQLITE_TRANSIENT);

    int loc_id = 0;
    
	if (sqlite3_step(select_statement) == SQLITE_ROW) {
        loc_id = sqlite3_column_int(select_statement, 0);
	} else {
        NSLog(@"Error1: %d", SQLITE_ROW);
        NSLog(@"Error2: %d", sqlite3_step(select_statement));
    }
    sqlite3_reset(select_statement);
    select_statement = nil;
    NSLog(@"location_id:%d", loc_id);
    return loc_id;
}
- (BOOL) insertEvent: (int) locationid
                    : (double) bill{
    self.database = _database;
    
    NSLog(@"insertEvent");
    if (insert_statement == nil) {
        static const char *sql = "INSERT INTO event (location_id, bill, timestamp) VALUES(?, ?, datetime('now'))";
        
        if (sqlite3_prepare_v2(self.database, sql, -1, &insert_statement, NULL) != SQLITE_OK) {
            NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(self.database));
        }
    }
	//int loc_id = [self getLocationId:location];
    NSLog(@"location: %d", locationid);
    NSLog(@"bill: %f", bill);
    sqlite3_bind_int(insert_statement, 1, locationid);
    sqlite3_bind_double(insert_statement, 2, bill);
    
    int success = sqlite3_step(insert_statement);
    sqlite3_reset(insert_statement);
	
    if (success == SQLITE_ERROR) {
        NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(self.database));
        return false;
    }
    sqlite3_reset(insert_statement);
    insert_statement = nil;
    
    return true;
}

- (int) getAmbagerId : (NSString *) name{
    NSLog(@"getAmbagerId");
    self.database = _database;
	
	if (select_statement == nil) {
		static const char *sql = "SELECT id FROM person WHERE name=?";
		if (sqlite3_prepare_v2(self.database, sql, -1, &select_statement, NULL) != SQLITE_OK) {
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(self.database));
		}
	}
    NSLog(@"name: %@", name);
    sqlite3_bind_text(select_statement, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
    
    int name_id = 0;
	if (sqlite3_step(select_statement) == SQLITE_ROW) {
        name_id = sqlite3_column_int(select_statement, 0);
	} 
	sqlite3_reset(select_statement);
    NSLog(@"ambagerid: %d", name_id);
    return name_id;
}

- (int) getEventId{
    NSLog(@"getEventId");
    self.database = _database;
	
	if (select_statement == nil) {
		static const char *sql = "SELECT MAX(id) FROM event";
		if (sqlite3_prepare_v2(self.database, sql, -1, &select_statement, NULL) != SQLITE_OK) {
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(self.database));
		}
	}
    int event_id = 0;
	if (sqlite3_step(select_statement) == SQLITE_ROW) {
        event_id = sqlite3_column_int(select_statement, 0);
	} else {
        NSLog(@"Error sa event: %d", SQLITE_ROW);
    }
	sqlite3_reset(select_statement);
    NSLog(@"eventid: %d", event_id);
    select_statement = nil;
    return event_id;
}

- (BOOL) insertAmbagan : (int) eventid
                       : (int) personid
                       : (double) amount{
    self.database = _database;
    
    NSLog(@"insertAmbagan");
    if (insert_statement == nil) {
        static const char *sql = "INSERT INTO ambag (event_id, person_id, amount) VALUES(?,?,?);";
        
        if (sqlite3_prepare_v2(self.database, sql, -1, &insert_statement, NULL) != SQLITE_OK) {
            NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(self.database));
        }
    }
    NSLog(@"eventid: %d", eventid);
    NSLog(@"personid: %d", personid);
    NSLog(@"amount: %f", amount);
    
    sqlite3_bind_int(insert_statement, 1, eventid);
    sqlite3_bind_int(insert_statement, 2, personid);
    sqlite3_bind_double(insert_statement, 3, amount);
    
    int success = sqlite3_step(insert_statement);
    sqlite3_reset(insert_statement);
	
    if (success == SQLITE_ERROR) {
        NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(self.database));
        return false;
    }
    return true;
    
}


- (NSMutableArray *) getPeopleByDate : (int) report_date{
    NSLog(@"getPeopleByDate");
    self.database = _database;
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    static const char *sql;
    
    switch(report_date){
        case 0: // daily
            sql = "SELECT person.name || ': ' || ROUND(SUM(amount), 2) || 'Php (' || COUNT(person.name) || ' event(s))' FROM person JOIN ambag ON person.id = ambag.person_id JOIN event ON ambag.event_id = event.id WHERE date(event.timestamp) = date('now') GROUP BY person.name;";
            break;
        case 1: // weekly
            sql = "SELECT  person.name || ':\n ' || ROUND(SUM(amount), 2) || 'Php (' || COUNT(person.name) || ' event(s))' FROM person JOIN ambag ON person.id = ambag.person_id JOIN event ON ambag.event_id = event.id WHERE date(event.timestamp) >= DATE('now', 'weekday 0', '-7 days') GROUP BY person.name;";
            break;
        case 2: // monthly
            sql = "SELECT  person.name || ':\n ' || ROUND(SUM(amount), 2) || 'Php (' || COUNT(person.name) || ' event(s))' FROM person JOIN ambag ON person.id = ambag.person_id JOIN event ON ambag.event_id = event.id WHERE strftime('%m',date(event.timestamp)) >= strftime('%m',date('now')) GROUP BY person.name;";
            break;
        case 3: // yearly
            sql = "SELECT  person.name || ':\n ' || ROUND(SUM(amount), 2) || 'Php (' || COUNT(person.name) || ' event(s))' FROM person JOIN ambag ON person.id = ambag.person_id JOIN event ON ambag.event_id = event.id WHERE strftime('%Y',date(event.timestamp)) >= strftime('%Y',date('now')) GROUP BY person.name;";
            break;
    }
    if(select_statement == nil){
        if(sqlite3_prepare_v2(self.database, sql, -1, &select_statement, NULL) != SQLITE_OK){
            NSAssert1(0, @"Error: failed to prepare statement with '%s'.", sqlite3_errmsg(self.database));
        }
    }
    
    char *str;
    
    while(sqlite3_step(select_statement) == SQLITE_ROW){
        NSString *pips = [[NSString alloc] init];
        str = (char *) sqlite3_column_text(select_statement, 0);
        pips = (str) ? [NSString stringWithUTF8String:str] : @"";
        [list addObject:pips];
    }
    
    sqlite3_reset(select_statement);
    select_statement = nil;
    
    return list;
}


- (NSMutableArray *) getGastosByDate : (int) report_date{
    NSLog(@"getGastosByDate");
    self.database = _database;
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    static const char *sql;
    
    switch(report_date){
        case 0: // daily
            sql = "SELECT SUM(bill) ||  'Php on ' || strftime('%m-%d-%Y %H:%M', timestamp), SUM(bill) FROM event WHERE date(event.timestamp) = date('now') GROUP BY datetime(timestamp);";
            break;
        case 1: // weekly
            sql = "SELECT SUM(bill) ||  'Php on ' || strftime('%m-%d-%Y %H:%M', timestamp), SUM(bill) FROM event WHERE date(event.timestamp) >= DATE('now', 'weekday 0', '-7 days') GROUP BY datetime(timestamp);";
            break;
        case 2: // monthly
            sql = "SELECT SUM(bill) ||  'Php on ' || strftime('%m-%d-%Y %H:%M', timestamp), SUM(bill) FROM event WHERE strftime('%m',date(timestamp)) >= strftime('%m',date('now')) GROUP BY datetime(timestamp);";
            break;
        case 3: // yearly
            sql = "SELECT SUM(bill) ||  'Php on ' || strftime('%m-%d-%Y %H:%M', timestamp), SUM(bill) FROM event WHERE strftime('%Y',date(timestamp)) >= strftime('%Y',date('now')) GROUP BY datetime(timestamp);";
            break;
    }
    if(select_statement == nil){
        if(sqlite3_prepare_v2(self.database, sql, -1, &select_statement, NULL) != SQLITE_OK){
            NSAssert1(0, @"Error: failed to prepare statement with '%s'.", sqlite3_errmsg(self.database));
        }
    }
    
    char *str;
    
    while(sqlite3_step(select_statement) == SQLITE_ROW){
        NSString *pips = [[NSString alloc] init];
        str = (char *) sqlite3_column_text(select_statement, 0);
        pips = (str) ? [NSString stringWithUTF8String:str] : @"";
        [list addObject:pips];
    }
    
    sqlite3_reset(select_statement);
    select_statement = nil;
    
    return list;
}
- (NSMutableArray *) getPlaceByDate : (int) report_date{
    NSLog(@"getPlaceByDate");
    self.database = _database;
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    static const char *sql;
    
    switch(report_date){
        case 0: // daily
            sql = "SELECT location || ' - ' || COUNT(location) || ' time(s)' FROM location JOIN event ON location.id = event.location_id WHERE date(event.timestamp) = date('now') GROUP BY location;";
            break;
        case 1: // weekly
            sql = "SELECT location || ' - ' || COUNT(location) || ' time(s)' FROM location JOIN event ON location.id = event.location_id WHERE date(event.timestamp) >= DATE('now', 'weekday 0', '-7 days') GROUP BY location;";
            break;
        case 2: // monthly
            sql = "SELECT location || ' - ' || COUNT(location) || ' time(s)' FROM location JOIN event ON location.id = event.location_id WHERE strftime('%m',date(event.timestamp)) >= strftime('%m',date('now')) GROUP BY location;";
            break;
        case 3: // yearly
            sql = "SELECT location || ' - ' || COUNT(location) || ' time(s)' FROM location JOIN event ON location.id = event.location_id WHERE strftime('%Y',date(event.timestamp)) >= strftime('%Y',date('now')) GROUP BY location;";
            break;
    }
    if(select_statement == nil){
        if(sqlite3_prepare_v2(self.database, sql, -1, &select_statement, NULL) != SQLITE_OK){
            NSAssert1(0, @"Error: failed to prepare statement with '%s'.", sqlite3_errmsg(self.database));
        }
    }
    
    char *str;
    
    while(sqlite3_step(select_statement) == SQLITE_ROW){
        NSString *pips = [[NSString alloc] init];
        str = (char *) sqlite3_column_text(select_statement, 0);
        pips = (str) ? [NSString stringWithUTF8String:str] : @"";
        [list addObject:pips];
    }
    
    sqlite3_reset(select_statement);
    select_statement = nil;
    
    return list;
}

- (NSMutableArray *) getEventsByDate : (int) report_date{
    NSLog(@"getEventsByDate");
    self.database = _database;
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    NSMutableArray *datetime = [[NSMutableArray alloc] init];
    NSMutableArray *eventid = [[NSMutableArray alloc] init];
    static const char *sql;
    
    switch(report_date){
        case 0: // daily
            sql = "SELECT event.id, strftime('%m-%d-%Y %H:%M', timestamp) || ' at ' || location.location  FROM event JOIN location ON event.location_id = location.id WHERE date(event.timestamp) = date('now') ORDER BY date(timestamp) DESC;";
            break;
        case 1: // weekly
            sql = "SELECT event.id, strftime('%m-%d-%Y %H:%M',timestamp) || ' at ' || location.location  FROM event JOIN location ON event.location_id = location.id WHERE date(event.timestamp) >= DATE('now', 'weekday 0', '-7 days') ORDER BY date(timestamp) DESC;";
            break;
        case 2: // monthly
            sql = "SELECT event.id, strftime('%m-%d-%Y %H:%M',timestamp) || ' at ' || location.location  FROM event JOIN location ON event.location_id = location.id WHERE strftime('%m',date(event.timestamp)) >= strftime('%m',date('now')) ORDER BY date(timestamp) DESC;";
            break;
        case 3: // yearly
            sql = "SELECT event.id, strftime('%m-%d-%Y %H:%M',timestamp) || ' at ' || location.location  FROM event JOIN location ON event.location_id = location.id WHERE strftime('%Y',date(event.timestamp)) >= strftime('%Y',date('now')) ORDER BY date(timestamp) DESC;";
            break;
    }
    if(select_statement == nil){
        if(sqlite3_prepare_v2(self.database, sql, -1, &select_statement, NULL) != SQLITE_OK){
            NSAssert1(0, @"Error: failed to prepare statement with '%s'.", sqlite3_errmsg(self.database));
        }
    }
    
    char *str;
    /*
     int x = 10;
     NSNumber* xWrapped = [NSNumber numberWithInt:x];
     NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:15];
     [array addObject:xWrapped];
     */
    while(sqlite3_step(select_statement) == SQLITE_ROW){
        int e_id = sqlite3_column_int(select_statement, 0);
        [eventid addObject:[NSNumber numberWithInt:e_id]];
        
        NSString *pips = [[NSString alloc] init];
        str = (char *) sqlite3_column_text(select_statement, 1);
        pips = (str) ? [NSString stringWithUTF8String:str] : @"";
        [datetime addObject:pips];
        
        
    }
    [list addObject:eventid];
    [list addObject:datetime];
    
    sqlite3_reset(select_statement);
    select_statement = nil;
    
    return list;
}
@end