//
//  Room.h
//  IntroToRealm
//
//  Created by Hyung Jip Moon on 2017-03-03.
//  Copyright © 2017 leomoon. All rights reserved.
//

#import <Realm/Realm.h>

@interface Room : RLMObject

@property NSString *name;


//
//#import <Realm/Realm.h>
//
//@interface Artist : RLMObject
//
//@property (nonatomic, strong) NSString *firstName;
//
//@property (nonatomic, strong) NSString *lastName;
//
//@property (nonatomic, strong) NSDate *registrationDate;
//
//// This protocol enables typed collections. i.e.:
//
//// RLMArray<Artist>
@end

RLM_ARRAY_TYPE(Room)



