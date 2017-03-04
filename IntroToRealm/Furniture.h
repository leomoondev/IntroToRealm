//
//  Furniture.h
//  IntroToRealm
//
//  Created by Hyung Jip Moon on 2017-03-03.
//  Copyright © 2017 leomoon. All rights reserved.
//

#import <Realm/Realm.h>

@class Room;

@interface Furniture : RLMObject

@property NSString *name;

@property Room *aRoom;

@end

RLM_ARRAY_TYPE(Furniture)
