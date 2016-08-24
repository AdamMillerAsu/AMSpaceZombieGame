//
//  Level2.m
//  CSE394   Project2  SpaceGame
//  Spring 2015
//  Created by Adam Miller on 4/30/15.
//  Copyright (c) 2015 Adam. All rights reserved.
//
//

#import "Level2.h"

static const uint32_t projectileCategory     =  0x1 << 0;
static const uint32_t zombieCategory        =  0x1 << 1;
static const uint32_t playerCategory =  0x1 << 2;

@implementation Level2






-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
    _world=[[SKNode alloc]init];
    
    self.physicsWorld.gravity = CGVectorMake(0,0);
    self.physicsWorld.contactDelegate =self;
    //SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    CGPoint center=CGPointMake(500,300); //'center pont' needs to change
    
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"Player"];
    SKTexture *texture = [atlas textureNamed:@"Player01.png"];
    _playerSprite = [SKSpriteNode spriteNodeWithTexture:texture];
    
    _playerSprite.xScale = 0.5;
    _playerSprite.yScale = 0.5;
    _playerSprite.position = center;
    
    _playerdest=_playerSprite.position;
    
    //SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
    
    //[sprite runAction:[SKAction repeatActionForever:action]];
    
    _playerSprite.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_playerSprite.size.width/2];
    _playerSprite.physicsBody.dynamic = YES;
    _playerSprite.physicsBody.categoryBitMask = playerCategory;
    _playerSprite.physicsBody.contactTestBitMask = zombieCategory;
    _playerSprite.physicsBody.collisionBitMask = 0;
    _playerSprite.physicsBody.usesPreciseCollisionDetection = YES;
    
    
    [self addChild:_world];
    [_world addChild:_playerSprite];
    
    [self addZombie];
    //[self addZombie];
    //[self addZombie];
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    //for (UITouch *touch in touches) {
        //CGPoint location = [touch locationInNode:self];
        
        //SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        //if empty tile //update player dest
        //if swipe playerturn
        //
        // _playerdest=[touch locationInNode:self];
        
        
        
        
        
   //
   // }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
   // for (UITouch *touch in touches) {
        
        
        //SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        //if empty tile //update player dest
        //if swipe playerturn
        //
        _playerdest=_playerSprite.position;
        [_playerSprite removeAllActions];
        
        UITouch *theTouch = [touches anyObject];
        if (theTouch.tapCount == 1) {
            
            
            
            
            SKTextureAtlas *projatlas = [SKTextureAtlas atlasNamed:@"projectiles"];
            SKTexture *projtexture = [projatlas textureNamed:@"slice02_02.png"];
            SKSpriteNode *projectile= [SKSpriteNode spriteNodeWithTexture:projtexture];
            
            projectile.position=_playerSprite.position;
            projectile.zRotation=_playerSprite.zRotation;
            
            
            projectile.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_playerSprite.size.width/2];
            projectile.physicsBody.dynamic = YES;
            projectile.physicsBody.categoryBitMask = projectileCategory;
            projectile.physicsBody.contactTestBitMask = zombieCategory;
            projectile.physicsBody.collisionBitMask = 1;
            projectile.physicsBody.usesPreciseCollisionDetection = YES;
            
            // Create the actions
            SKAction * actionproj= [SKAction moveTo:CGPointMake(_positionInScene.x, _positionInScene.y) duration:.2];
            SKAction *endaction=[SKAction removeFromParent];
            
            [projectile runAction:[SKAction sequence:@[actionproj,endaction]]];
            
            // SKAction * actionMoveDone = [SKAction removeFromParent];
            //[zombieSprite runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
            
            [_world addChild:projectile];
            
            // _previousTime=currentTime;
            
            
            
            
        } else {
            
        }
        
        
        
        
    //}
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // SKNode *player = [self childNodeWithName:@"player"];
    
    UITouch *touch = [touches anyObject];
    _positionInScene = [touch locationInNode:self];
    
    
    
    // Determine the angle of rotation using trig
    
    int dY= _playerSprite.position.y-_positionInScene.y;
    int dX= _playerSprite.position.x-_positionInScene.x;
    //int Hyp = sqrt(Adj^2 + Opp^2);
    
    
    double ang=atan2f(dY,dX)+M_PI_2;
    NSLog(@"angle %f",ang);
    
    // Create the actions
    
    
    
    SKAction *actionMove=[SKAction moveTo:CGPointMake(_positionInScene.x,_positionInScene.y) duration:.5];
    _playerSprite.zRotation=ang;
    [_playerSprite runAction:actionMove];
    //[_playerSprite runAction:actionRotate];
    
    
    
    
    
}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    if(_previousTime)
    {}
    else
    {_previousTime=currentTime;}
    
    NSLog(@"time:%f",currentTime);
    NSLog(@"prev%f",_previousTime);
    if(currentTime-_previousTime>.6)
    {
        
        
        
        
        
        
        
    }
    
    if((_playerSprite.position.x ==_playerdest.x) && (_playerdest.y== _playerSprite.position.y))
    {}
    else
    {
        
        
    }
    
    // _previousTime=currentTime;
    
}

- (void)addZombie {
    
    
    
    
    //sprite from texure
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"Zombie"];
    SKTexture *texture = [atlas textureNamed:@"Zombie_176.png"];
    SKSpriteNode *zombieSprite= [SKSpriteNode spriteNodeWithTexture:texture];
    
    
    // Determine where to spawn the monster along the Y axis
    //int minY = zombieSprite.size.height / 2;
    //int maxY = self.frame.size.height - zombieSprite.size.height / 2;
    //int rangeY = maxY - minY;
    //int actualY = (arc4random() % rangeY) + minY;
    
    // Create the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    zombieSprite.position = CGPointMake(_playerSprite.position.x+50 , _playerSprite.position.y-50);
    [_world addChild:zombieSprite];
    
    // Determine speed of the monster
    //int minDuration = 2.0;
    //int maxDuration = 4.0;
   // int rangeDuration = maxDuration - minDuration;
   // int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    
    zombieSprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:zombieSprite.size]; // 1
    zombieSprite.physicsBody.dynamic = YES; // 2
    zombieSprite.physicsBody.categoryBitMask = zombieCategory; // 3
    zombieSprite.physicsBody.contactTestBitMask = projectileCategory; // 4
    zombieSprite.physicsBody.collisionBitMask = 1; // 5
    
    
    // Create the actions
    //SKAction * actionMove = [SKAction moveTo:CGPointMake(-zombieSprite.size.width/2, actualY) duration:actualDuration];
    // SKAction * actionMoveDone = [SKAction removeFromParent];
    //[zombieSprite runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
    
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    
    // 1
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    // 2
    if ((firstBody.categoryBitMask & projectileCategory) != 0 &&
        (secondBody.categoryBitMask & zombieCategory) != 0)
    {
        [self projectile:(SKSpriteNode *) firstBody.node didCollideWithZombie:(SKSpriteNode *) secondBody.node];
        
        
        //  Level2 *leveltwo=[[Level2 alloc]init];
        //  [self.scene.view presentScene:]
       // SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionDown duration:1.0];
        Level2 *lvl2 =[[Level2 alloc]initWithSize: self.size];
        lvl2.scaleMode=SKSceneScaleModeAspectFill;
        [self.scene.view presentScene:lvl2];
        
    }
}

- (void)projectile:(SKSpriteNode *)projectile didCollideWithZombie:(SKSpriteNode *)monster {
    NSLog(@"Hit");
    [projectile removeFromParent];
    [monster removeFromParent];
}


- (void)didSimulatePhysics{
    _world.position = CGPointMake(-(_playerSprite.position.x-(self.size.width/2)), -(_playerSprite.position.y-(self.size.height/2)));
}



@end

