//
//  Game Scene.m
//  CSE394   Project2  SpaceGame
//  Spring 2015
//  Created by Adam Miller on 4/30/15.
//  Copyright (c) 2015 Adam. All rights reserved.
//
//

#import "GameScene.h"
#import "Level2.h"
#import "Level1.h"
#import "Endless.h"

//static const uint32_t projectileCategory     =  0x1 << 0;
//static const uint32_t zombieCategory        =  0x1 << 1;
//static const uint32_t playerCategory =  0x1 << 2;

@implementation GameScene


-(void)didMoveToView:(SKView *)view {
 
    
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"Player"];
    SKTexture *texture = [atlas textureNamed:@"Player01.png"];
    _buttonSprite = [SKSpriteNode spriteNodeWithTexture:texture];
    
    _buttonSprite.xScale = 0.5;
    _buttonSprite.yScale = 0.5;
    //buttonSprite.position = CGPointMake(self.scene.size.height-buttonSprite.size.height,self.scene.size.width-buttonSprite.size.width);
    
    _buttonSprite.position = CGPointMake(400,375);
    _buttonSprite.name=@"level1button";
    
    
    [self addChild:_buttonSprite];
    //self.scene.size.height/2
    
    
    
    
    SKTextureAtlas *atlas2 = [SKTextureAtlas atlasNamed:@"Player"];
    SKTexture *texture2 = [atlas2 textureNamed:@"Player01.png"];
    _buttonSprite2 = [SKSpriteNode spriteNodeWithTexture:texture2];
    
    _buttonSprite2.xScale = 0.5;
    _buttonSprite2.yScale = 0.5;
    //buttonSprite.position = CGPointMake(self.scene.size.height-buttonSprite.size.height,self.scene.size.width-buttonSprite.size.width);
    
    _buttonSprite2.position = CGPointMake(600,375);
    _buttonSprite2.name=@"level2button";
    
    
    [self addChild:_buttonSprite2];
    
    
    
    
    SKTextureAtlas *atlas3 = [SKTextureAtlas atlasNamed:@"Player"];
    SKTexture *texture3 = [atlas3 textureNamed:@"Player01.png"];
    _buttonSprite3 = [SKSpriteNode spriteNodeWithTexture:texture3];
    
    _buttonSprite3.xScale = 0.5;
    _buttonSprite3.yScale = 0.5;
    //buttonSprite.position = CGPointMake(self.scene.size.height-buttonSprite.size.height,self.scene.size.width-buttonSprite.size.width);
    
    _buttonSprite3.position = CGPointMake(500,250);
    _buttonSprite3.name=@"level3button";
    
    
     [self addChild:_buttonSprite3];
    
    
    SKLabelNode *buttonLabel1 = [SKLabelNode labelNodeWithText:@"Level 1"];
    buttonLabel1.position = CGPointMake(410,420);
    buttonLabel1.zPosition=1;
    
    SKLabelNode *buttonLabel2 = [SKLabelNode labelNodeWithText:@"Level 2"];
    buttonLabel2.position = CGPointMake(610,420);
    buttonLabel2.zPosition=1;
    
    SKLabelNode *buttonLabel3 = [SKLabelNode labelNodeWithText:@"Endless Mode"];
    buttonLabel3.position = CGPointMake(510,280);
    buttonLabel3.zPosition=1;
    
    [self addChild:buttonLabel1];
    [self addChild:buttonLabel2];
    [self addChild:buttonLabel3];
    
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
  
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        
        
        //SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        //if empty tile //update player dest
        //if swipe playerturn
        //
        
       CGPoint location = [touch locationInNode:self];
       SKNode *node = [self nodeAtPoint:location];
        
        UITouch *theTouch = [touches anyObject];
        if (theTouch.tapCount == 1) {
            
            if ([node.name isEqualToString:@"level1button"]) {
                
                Level1 *lvl1 =[[Level1 alloc]initWithSize: self.size];
                lvl1.scaleMode=SKSceneScaleModeAspectFill;
                [self.scene.view presentScene:lvl1];
                
                
            }
            else if([node.name isEqualToString:@"level2button"]) {
                
                Level2 *lvl2 =[[Level2 alloc]initWithSize: self.size];
                lvl2.scaleMode=SKSceneScaleModeAspectFill;
                [self.scene.view presentScene:lvl2];
                
            }
            else if([node.name isEqualToString:@"level3button"]) {
                
                Endless *endlss =[[Endless alloc]initWithSize: self.size];
                endlss.scaleMode=SKSceneScaleModeAspectFill;
                [self.scene.view presentScene:endlss];
                
            }
     
        }
    }
}
        

@end

