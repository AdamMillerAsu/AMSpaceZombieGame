//
//  Level1.m
//  CSE394   Project2  SpaceGame
//  Spring 2015
//  Created by Adam Miller on 4/30/15.
//  Copyright (c) 2015 Adam. All rights reserved.
//
//


#import "Level1.h"
#import "GameScene.h"
#import "Level2.h"
#import <math.h>
#import "Endless.h"

static const uint32_t projectileCategory     =  0x1 << 0;
static const uint32_t zombieCategory        =  0x1 << 1;
static const uint32_t playerCategory =  0x1 << 2;

@implementation Endless




-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
    _world=[[SKNode alloc]init];
    _zombies = [[NSMutableArray alloc]init];
    
    
    _lifeLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    _lifeLabel.text=@"Life:10";
    _lifeLabel.fontSize = 13;
    _lifeLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                      CGRectGetMidY(self.frame)+250);
    _lifeLabel.zPosition=1;
    
    self.physicsWorld.gravity = CGVectorMake(0,0);
    self.physicsWorld.contactDelegate =self;
    //SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    CGPoint center=CGPointMake(500,300); //'center pont' needs to change
    
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"Player"];
    SKTexture *texture = [atlas textureNamed:@"Player07.png"];
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
    [self addChild:_lifeLabel];
    [_world addChild:_playerSprite];
    
    
    _myLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
     _deadzombies=0;
    _myLabel.text = @"Zombies Killed: 0 ";
   
    _myLabel.fontSize = 13;
    _myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame)+200);
    
    [self addChild:_myLabel];
    
       _playerLife=10;
    
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
        
        
                
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
            SKTexture *projtexture = [projatlas textureNamed:@"slice01_01.png"];
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
        
        
        
   //
   // }
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
    
    
    for (SKSpriteNode *zomb in _zombies) {
        
        if((fabs(zomb.position.x-_playerSprite.position.x)<1000) && (fabs(zomb.position.y-_playerSprite.position.y)<1000)){
            
            
            int dY= zomb.position.y-_playerSprite.position.y;
            int dX= zomb.position.x-_playerSprite.position.x;
            //int Hyp = sqrt(Adj^2 + Opp^2);
            
            
            double ang=atan2f(dY,dX)+M_PI_2;
            zomb.zRotation=ang;
            
            
            int movex=0;
            int movey=0;
            
            if(_playerSprite.position.x>zomb.position.x)
            {movex=1;}
            else if(_playerSprite.position.x==zomb.position.x)
            {movex=0;}
            else
            {movex=-1;}
            
            if(_playerSprite.position.y>zomb.position.y)
            {movey=1;}
            else if(_playerSprite.position.y==zomb.position.y)
            {movey=0;}
            else
            {movey=-1;}
            
            
            
            SKAction *actionchase=[SKAction moveByX:movex y:movey duration:1];
            // SKAction *actionchase=[SKAction moveBy:CGVectorMake(movex, movey) duration:1];
            [zomb runAction:actionchase];
            
        }
        
    }
    
    
    
    if(currentTime-_previousTime>3)
    {
        
        
        
        
        [self addZombie];
        
       _previousTime=currentTime;
        
        
    }
    
    if((_playerSprite.position.x ==_playerdest.x) && (_playerdest.y== _playerSprite.position.y))
    {}
    else
    {
        
        
    }
    
    
 
    NSString *string = [NSString stringWithFormat:@"Life: %d", _playerLife];
    _lifeLabel.text = string;
    
    if(_playerLife<=0){
        
        NSString *string2 = [NSString stringWithFormat:@"YOU ARE DEAD"];
        _lifeLabel.text = string2;
        //SKAction *fade= [SKAction fadeAlphaBy:100.00 duration:2.0];
        SKAction *fade = [SKAction fadeOutWithDuration:2.0];
        
        
        
        [_world runAction:fade ];
        
        
        SKAction *waits=[SKAction waitForDuration:3];
        [self runAction:waits completion:^
         {
             GameScene *gs =[[GameScene alloc]initWithSize: self.size];
             gs.scaleMode=SKSceneScaleModeAspectFill;
             //[self.scene.view presentScene:gs transition:fade];
             //self.scene.view.paused=YES;
             
             [self.scene.view presentScene:gs];
         }];
        
    }
   
    
}

- (void)addZombie {
    
    
    
    
    //sprite from texure
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"Zombie"];
    SKTexture *texture = [atlas textureNamed:@"Zombie_176.png"];
    SKSpriteNode *zombieSprite= [SKSpriteNode spriteNodeWithTexture:texture];
    
    
    
    int minY = 0+zombieSprite.size.height;
    int maxY = self.frame.size.height - zombieSprite.size.height / 2;
    int minX = 0+zombieSprite.size.height;
    int maxX = self.frame.size.height - zombieSprite.size.height / 2;
    int rangeY = maxY - minY;
    int rangeX = maxX - minX;
    int actualX = (arc4random() % rangeX) + minX;
    int actualY = (arc4random() % rangeY) + minY;
    
    
    // Create the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    zombieSprite.position = CGPointMake(actualX,actualY);
    [_world addChild:zombieSprite];
    [_zombies addObject:zombieSprite];
    
    // Determine speed of the monster
    //int minDuration = 2.0;
    //int maxDuration = 4.0;
    //int rangeDuration = maxDuration - minDuration;
    //int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    
    zombieSprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:zombieSprite.size]; // 1
    zombieSprite.physicsBody.dynamic = YES; // 2
    zombieSprite.physicsBody.categoryBitMask = zombieCategory; // 3
    zombieSprite.physicsBody.contactTestBitMask = projectileCategory; // 4
    zombieSprite.physicsBody.collisionBitMask = 1; // 5
    
    [_zombies addObject:zombieSprite];
    
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
        
        

        
    }
    else if ((firstBody.categoryBitMask & zombieCategory) != 0 &&
             (secondBody.categoryBitMask & playerCategory) != 0)
    {
        
        _playerLife--;
    }
    
    
    
}

- (void)projectile:(SKSpriteNode *)projectile didCollideWithZombie:(SKSpriteNode *)monster {
    NSLog(@"Hit");
    [projectile removeFromParent];
    [monster removeFromParent];
    _deadzombies++;
    _playerLife++;
    
    NSString *string = [NSString stringWithFormat:@"Zombies Killed: %d", _deadzombies];
    _myLabel.text = string;
}


- (void)didSimulatePhysics{
    _world.position = CGPointMake(-(_playerSprite.position.x-(self.size.width/2)), -(_playerSprite.position.y-(self.size.height/2)));
}



@end





