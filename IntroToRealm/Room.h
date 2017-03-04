//
//  Room.h
//  IntroToRealm
//
//  Created by Hyung Jip Moon on 2017-03-03.
//  Copyright © 2017 leomoon. All rights reserved.
//

#import <Realm/Realm.h>
#import "Furniture.h"

@interface Room : RLMObject

@property NSString *name;

@property RLMArray<Furniture *><Furniture> *furniture;

@end

RLM_ARRAY_TYPE(Room)



