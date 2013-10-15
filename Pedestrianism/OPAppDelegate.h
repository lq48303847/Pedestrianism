//
//  OPAppDelegate.h
//  Pedestrianism
//
//  Created by TY on 13-10-15.
//  Copyright (c) 2013年 First. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
