require "funcs"
require "Actor"

local TownScene  = class("TownScene",function()
	  return cc.Scene:create()
end)

function TownScene:ctor()
    self.visibleSize = cc.Director:getInstance():getVisibleSize()
    self.origin = cc.Director:getInstance():getVisibleOrigin()
end

function TownScene.create()
    local scene = TownScene.new()
    
    scene:initCamera()

    scene:createLayer()

    return scene
end

function TownScene:initCamera()
		local camera_1 = cc.Camera:createOrthographic(960,640,0,1000)
		camera_1:setCameraFlag(cc.CameraFlag.USER1)
		self:addChild(camera_1)
		
		self._camera3d = cc.Camera3D:create(0, 60, self.visibleSize.width/self.visibleSize.height, 1, 2000)
		self._camera3d:setCameraFlag(cc.CameraFlag.USER2)
		self._camera3d:setPosition3D(cc.vec3(self.visibleSize.width/2, self.visibleSize.height/2, 100))
		self._camera3d:setRotation3D(cc.vec3(-10, 0, 0))
    self:addChild(self._camera3d)
end

function TownScene:createLayer()
    
    --create layer
    self.layer = cc.Layer:create()
    
    --create Background
    self:addBackground()

    --create map
    self:addMap()
    
    self:addChild(self.layer)
    
    self:setEventListener()
end

function TownScene:addBackground()
		local background = cc.Sprite:create("chooseRole/cr_bk.jpg")
    background:setAnchorPoint(0.5,0.5)
    background:setPosition(self.origin.x + self.visibleSize.width/2, self.origin.y + self.visibleSize.height/2)
    background:setCameraMask(cc.CameraFlag.USER1)
    self.layer:addChild(background)
end

function TownScene:addMap()
		local file = "map/map001/map001.c3b"
		local knight = Actor.create()
		knight:init3D(file)
    knight:setTag(2)
    knight:setRotation3D({x=0,y=0,z=0})
    knight:setPosition3D({x=self.visibleSize.width*0.5,y=self.visibleSize.height*0.35,z=-180})  
    knight:setScale(15)
    knight:setCameraMask(cc.CameraFlag.USER2)
    self.layer:addChild(knight)
end

function TownScene:setEventListener()
    local listener = cc.EventListenerTouchAllAtOnce:create()

    listener:registerScriptHandler(function(touchs, event)
        if #touchs ~= 0 then
						cclog("touchtouchtouchtouchtouchtouch")
        end
    end, cc.Handler.EVENT_TOUCHES_MOVED)

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
end

return TownScene