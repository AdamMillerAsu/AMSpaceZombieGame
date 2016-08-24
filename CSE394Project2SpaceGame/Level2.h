//
//  Level2.h
//  CSE394Project2SpaceGame
//
//  Created by Sarah Jane on 4/29/15.
//  Copyright (c) 2015 Adam. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Level2 : SKScene <SKPhysicsContactDelegate>




@property CGPoint playerdest;
@property SKSpriteNode *playerSprite;
@property CFTimeInterval previousTime;
@property CGPoint positionInScene;


@property SKNode *world;




@end
