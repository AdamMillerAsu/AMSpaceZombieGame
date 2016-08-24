//
//  Level1.m
//  CSE394   Project2  SpaceGame
//  Spring 2015
//  Created by Adam Miller on 4/30/15.
//  Copyright (c) 2015 Adam. All rights reserved.
//

#import "Level1.h"
#import "GameScene.h"
#import "Level2.h"
#import <math.h>

static const uint32_t projectileCategory     =  0x1 << 0;
static const uint32_t zombieCategory        =  0x1 << 1;
static const uint32_t playerCategory =  0x1 << 2;
static const uint32_t wallCategory =  0x1 << 3;
static const uint32_t upgradesCategory =  0x1 << 4;

@implementation Level1 







-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
    _world=[[SKNode alloc]init];
    _zombies = [[NSMutableArray alloc]init];
    
    self.physicsWorld.gravity = CGVectorMake(0,0);
    self.physicsWorld.contactDelegate =self;
    _lifeLabel = [SKLabelNode labelNodeWithText:@"Life: 3"];
    _lifeLabel.position = CGPointMake(500,615);
    _lifeLabel.zPosition=1;
    
    CGPoint center=CGPointMake(500,300); //'center pont' needs to change
    
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"Player"];
    SKTexture *texture = [atlas textureNamed:@"Player07.png"];
    _playerSprite = [SKSpriteNode spriteNodeWithTexture:texture];
    
    _playerSprite.xScale = 0.5;
    _playerSprite.yScale = 0.5;
    _playerSprite.position = center;
    
    _playerdest=_playerSprite.position;
    //playdest variable changes as the player swipes, it's updated whenever there is a move action
    

    
    _playerSprite.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_playerSprite.size.width/2];
    _playerSprite.physicsBody.dynamic = YES;
    _playerSprite.physicsBody.categoryBitMask = playerCategory;
    _playerSprite.physicsBody.contactTestBitMask = wallCategory;
    _playerSprite.physicsBody.contactTestBitMask = zombieCategory;
    _playerSprite.physicsBody.collisionBitMask = 8;
    _playerSprite.physicsBody.usesPreciseCollisionDetection = YES;
    
    
    [self addChild:_world];
    [_world addChild:_playerSprite];
    [self addChild:_lifeLabel];
    
    
    [self addZombie];
    [self addZombie];
    [self addZombie];
    
    _playerLife=3;
   
    SKTextureAtlas *upatlas = [SKTextureAtlas atlasNamed:@"projectiles"];
    SKTexture *uptexture = [upatlas textureNamed:@"slice02_02.png"];
    _upgrade=[SKSpriteNode spriteNodeWithTexture:uptexture];
    _upgrade.position=CGPointMake(400,200);
    
    _upgrade.physicsBody=[SKPhysicsBody bodyWithCircleOfRadius:_upgrade.size.width/2];
    _upgrade.physicsBody.dynamic = YES;
    _upgrade.physicsBody.categoryBitMask = upgradesCategory;
    _upgrade.physicsBody.contactTestBitMask = playerCategory;
    _upgrade.physicsBody.collisionBitMask = 8;
    _upgrade.physicsBody.usesPreciseCollisionDetection = YES;
    [_world addChild:_upgrade];
    
    
    /////////////////////////////////////////////////////////////
    //Messy Physics stuff that should have been added in a more//
    //But instead was added manually and needs to be cleaned ////
    /////////////////////////////////////////////////////////////
    
    
    SKTextureAtlas *wallatlas = [SKTextureAtlas atlasNamed:@"misc"];
    SKTexture *walltexture = [wallatlas textureNamed:@"slice01_011.png"];
    
    SKSpriteNode *WallSprite = [SKSpriteNode spriteNodeWithTexture:walltexture];
     SKSpriteNode *WallSprite1 = [SKSpriteNode spriteNodeWithTexture:walltexture];
     SKSpriteNode *WallSprite2 = [SKSpriteNode spriteNodeWithTexture:walltexture];
     SKSpriteNode *WallSprite3 = [SKSpriteNode spriteNodeWithTexture:walltexture];
     SKSpriteNode *WallSprite4 = [SKSpriteNode spriteNodeWithTexture:walltexture];
     SKSpriteNode *WallSprite5 = [SKSpriteNode spriteNodeWithTexture:walltexture];
     SKSpriteNode *WallSprite6 = [SKSpriteNode spriteNodeWithTexture:walltexture];
    
    WallSprite.position = CGPointMake(500,550);
    WallSprite1.position = CGPointMake(600,550);
    WallSprite2.position = CGPointMake(400,400);
    WallSprite3.position = CGPointMake(300,550);
    WallSprite4.position = CGPointMake(300,150);
    WallSprite5.position = CGPointMake(600,200);
    WallSprite6.position = CGPointMake(700,550);
    

    
   WallSprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(WallSprite.size.width+5, WallSprite.size.height+5)];
    WallSprite.physicsBody.dynamic = YES;
    WallSprite.physicsBody.categoryBitMask = wallCategory;
    WallSprite.physicsBody.contactTestBitMask = playerCategory;
    WallSprite.physicsBody.collisionBitMask = 3;
    WallSprite.physicsBody.usesPreciseCollisionDetection = YES;
    
  
        
        WallSprite1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(WallSprite.size.width+5, WallSprite.size.height+5)];
        WallSprite1.physicsBody.dynamic = YES;
        WallSprite1.physicsBody.categoryBitMask = wallCategory;
        WallSprite1.physicsBody.contactTestBitMask = playerCategory;
        WallSprite1.physicsBody.collisionBitMask = 3;
        WallSprite1.physicsBody.usesPreciseCollisionDetection = YES;
        
        WallSprite2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(WallSprite.size.width+5, WallSprite.size.height+5)];
        WallSprite2.physicsBody.dynamic = YES;
        WallSprite2.physicsBody.categoryBitMask = wallCategory;
        WallSprite2.physicsBody.contactTestBitMask = playerCategory;
        WallSprite2.physicsBody.collisionBitMask = 3;
        WallSprite2.physicsBody.usesPreciseCollisionDetection = YES;
    
        WallSprite3.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(WallSprite.size.width+5, WallSprite.size.height+5)];
        WallSprite3.physicsBody.dynamic = YES;
        WallSprite3.physicsBody.categoryBitMask = wallCategory;
        WallSprite3.physicsBody.contactTestBitMask = playerCategory;
        WallSprite3.physicsBody.collisionBitMask = 3;
        WallSprite3.physicsBody.usesPreciseCollisionDetection = YES;
    
        WallSprite4.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(WallSprite.size.width+5, WallSprite.size.height+5)];
        WallSprite4.physicsBody.dynamic = YES;
        WallSprite4.physicsBody.categoryBitMask = playerCategory;
        WallSprite4.physicsBody.contactTestBitMask = playerCategory;
        WallSprite4.physicsBody.collisionBitMask = 3;
        WallSprite4.physicsBody.usesPreciseCollisionDetection = YES;
    
    WallSprite5.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(WallSprite.size.width+5, WallSprite.size.height+5)];
        WallSprite5.physicsBody.dynamic = YES;
        WallSprite5.physicsBody.categoryBitMask = wallCategory;
        WallSprite5.physicsBody.contactTestBitMask = playerCategory;
        WallSprite5.physicsBody.collisionBitMask = 3;
        WallSprite5.physicsBody.usesPreciseCollisionDetection = YES;
    
        WallSprite6.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(WallSprite.size.width+5, WallSprite.size.height+5)];
        WallSprite6.physicsBody.dynamic = YES;
        WallSprite6.physicsBody.categoryBitMask = wallCategory;
        WallSprite6.physicsBody.contactTestBitMask = playerCategory;
        WallSprite6.physicsBody.collisionBitMask = 3;
        WallSprite6.physicsBody.usesPreciseCollisionDetection = YES;
    
    
   
    [_world addChild:WallSprite];
    [_world addChild:WallSprite1];
    [_world addChild:WallSprite2];
    [_world addChild:WallSprite3];
    [_world addChild:WallSprite4];
    [_world addChild:WallSprite5];
    [_world addChild:WallSprite6];
    
    
    _projatlas=[SKTextureAtlas atlasNamed:@"projectiles"];
    _projtexture = [_projatlas textureNamed:@"slice01_01.png"];
    
    /////////////////////////////////////////////////////////////
    //End Physics stuff//////////////////////////////////////////
    /////////////////////////////////////////////////////////////
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    
        
        //Touches Ended is configured so that when
        //The movement ends, the touchs object is checked
        //for the number of touches, if this exceeds 1 we
        //know that we're coming out of a swipe and not
        //just a tap, if it's just a tap, then we want
        //run the touches ended function to 'shoot' the projectile
    
        _playerdest=_playerSprite.position;
        [_playerSprite removeAllActions];
        
        UITouch *theTouch = [touches anyObject];
        if (theTouch.tapCount == 1) {
            
            
            
            

            SKSpriteNode *projectile= [SKSpriteNode spriteNodeWithTexture:_projtexture];
            
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
            
      
            
            [_world addChild:projectile];
            
      
            
            
            
        } else {
            
        }
        
        
        
        
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    

    
    UITouch *touch = [touches anyObject];
    _positionInScene = [touch locationInNode:self];
    

    
    int dY= _playerSprite.position.y-_positionInScene.y;
    int dX= _playerSprite.position.x-_positionInScene.x;

    
    
    double ang=atan2f(dY,dX)+M_PI_2;
   
    
   
    SKAction *actionMove=[SKAction moveTo:CGPointMake(_positionInScene.x,_positionInScene.y) duration:.5];
    _playerSprite.zRotation=ang;
    [_playerSprite runAction:actionMove];

    
    
    
    
}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    if(_previousTime)
    {}
    else
    {_previousTime=currentTime;}
    
    
    for (SKSpriteNode *zomb in _zombies) {
        
        if((fabs(zomb.position.x-_playerSprite.position.x)<300) && (fabs(zomb.position.y-_playerSprite.position.y)<300)){

        
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
    
    
    //some of the trig came from raywenderlich
    
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
    
    zombieSprite.position = CGPointMake(actualX,actualY);
    

    [_world addChild:zombieSprite];
    
  
    zombieSprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:zombieSprite.size]; // 1
    zombieSprite.physicsBody.dynamic = YES; // 2
    zombieSprite.physicsBody.categoryBitMask = zombieCategory; // 3
    zombieSprite.physicsBody.contactTestBitMask = projectileCategory; // 4
    zombieSprite.physicsBody.contactTestBitMask = playerCategory;
    zombieSprite.physicsBody.collisionBitMask = 1; // 5
    
    [_zombies addObject:zombieSprite];
    
    
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    //I believe some of this came from raywenderlich's ninja tutorial
  
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
    else if ((secondBody.categoryBitMask & upgradesCategory) != 0 &&
             (firstBody.categoryBitMask & playerCategory) != 0)
    {
        _projatlas=[SKTextureAtlas atlasNamed:@"projectiles"];
        _projtexture = [_projatlas textureNamed:@"slice02_02.png"];
        SKSpriteNode *remove = (SKSpriteNode *)secondBody.node;
        [remove removeFromParent];
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

