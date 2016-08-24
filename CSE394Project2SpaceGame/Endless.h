//
//  Endless.h
//  CSE394Project2SpaceGame
//
//  Created by Sarah Jane on 4/30/15.
//  Copyright (c) 2015 Adam. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Endless : SKScene <SKPhysicsContactDelegate>



@property CGPoint playerdest;
@property SKSpriteNode *playerSprite;
@property CFTimeInterval previousTime;
@property CGPoint positionInScene;


@property SKNode *world;
@property NSMutableArray *zombies;
@property  SKLabelNode *myLabel;
@property int deadzombies;

@property int playerLife;
@property SKLabelNode *lifeLabel;

@end



