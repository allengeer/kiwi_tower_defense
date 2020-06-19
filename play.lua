local composer = require( "composer" )
local physics = require( "physics" )
local scene = composer.newScene()
local display = require("display")
local global = require("global")
local TD_model = require("TD_model")
local utils = require("utils")
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local pathLength
local pathRate

local actorsSheetInfo = require("images.actors")
local actorsSheet = graphics.newImageSheet( "images/actors.png", actorsSheetInfo:getSheet() )
local enemiesGroup
local defenseGroup 
local uiGroup
local laserGroup

local enemies
local defenses
local gameTime 

-- EVENT Handlers

local function createDefense ( defenseType, x, y )
    for i = 1,#defenses do
        if utils.hasCollidedCircle(defenses[i], {x = x, y = y}) then
            return
        end
    end
    local defense = display.newImage(defenseGroup, actorsSheet, actorsSheetInfo:getFrameIndex("Kiwi"), x , y)
    table.insert(defenses, defense)
     print (defenseGroup.numChildren)
end

local function fireLaserBeam ( defense, target )
    if target.x and target.y then 
        if not defense.laser then
            local laser = display.newLine( laserGroup, defense.x-7, defense.y-27, target.x, target.y )
            laser:setStrokeColor( 0, 1, 0 )
            laser.strokeWidth = 5
            defense.laser = laser
            target.health = target.health - 10
            if target.health <= 0 then
                defense.target = nil
            end
        end
    else
        defense.target = nil
    end
    -- print (laserGroup.numChildren)
end

local function aquireTarget ( defense )
    local bestDistance = 10000
    local best = nil
    for i,v in ipairs(enemies) do
        local nextDistance = math.sqrt( (v.x-defense.x) * (v.x-defense.x) + (v.y-defense.y) * (v.y-defense.y) )
        
        if nextDistance < bestDistance then
            bestDistance = nextDistance
            best = v
        end
    end
    return best
end

local function distance (pt1, pt2) 
    return math.sqrt( (pt2[1] - pt1[1]) * (pt2[1] - pt1[1]) + (pt2[2] - pt1[2]) * (pt2[2] - pt1[2]) )
end

local function setVelocity( defense )
    
    local deltax = TD_model:getCurrentLevel().path[defense.destinationIndex][1]-defense.x
    local deltay = TD_model:getCurrentLevel().path[defense.destinationIndex][2]-defense.y

    local distanceLeg = distance(TD_model:getCurrentLevel().path[defense.destinationIndex], {defense.x, defense.y})
    local legTime = distanceLeg / pathRate
    defense:setLinearVelocity(deltax / legTime, deltay / legTime)
end



local function totalPathDistance( path )
    local total = 0
    for i = 2,#path do
        total = total + distance(path[i], path[i-1])
    end
    return total
end

local function enemyDie( enemy ) 

end

local function enemyScore( enemy ) 

end
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
function gameLoop ()
    gameTime = gameTime + 50
    local enemyIndex = gameTime / 2000
    if gameTime % 2000 == 50 then
        if enemyIndex <= #TD_model:getCurrentLevel().enemies then
            if string.sub(TD_model:getCurrentLevel().enemies, enemyIndex, enemyIndex) ~= "X" then
                local covid = display.newImage(enemiesGroup, actorsSheet, actorsSheetInfo:getFrameIndex("Capsid"), TD_model:getCurrentLevel().path[1][1], TD_model:getCurrentLevel().path[1][2])
                covid.health = 100
                covid.destinationIndex = 2
                table.insert(enemies, covid)
                physics.addBody( covid, "kinematic", {  } )
                setVelocity(covid)
            end
        end
    end
    
    for i,v in ipairs(enemies) do
        if v.health <= 0 then
            v:removeSelf()
            enemyDie(v)
            table.remove(enemies,i)
        elseif v.x - v.contentWidth/2 > display.contentWidth then
            v:removeSelf()
            enemyScore(v)
            table.remove( enemies, i )
        end

        if v.destinationIndex < #TD_model:getCurrentLevel().path and distance({v.x, v.y}, TD_model:getCurrentLevel().path[v.destinationIndex]) < 10 then
            v.destinationIndex = v.destinationIndex + 1
            setVelocity(v)
        end
    end
    if gameTime % 125 == 0 then
        for i,v in ipairs(defenses) do
            if not v.laser then
                if not v.target then 
                    v.target = aquireTarget(v)
                end
                if v.target then
                    fireLaserBeam(v, v.target)
                end
            elseif v.laser then
                display.remove(v.laser)
                v.laser = nil
            end
        end
    end

    if enemyIndex > #TD_model:getCurrentLevel().enemies and #enemies == 0 then
        composer.gotoScene("selectlevel")
    end


end

function onBackgroundTouch( event )
     if ( event.phase == "began" ) then
        -- Code executed when the button is touched
        -- Invisible
        print( "object touched = " .. tostring(event.target) )  -- "event.target" is the touched object
    elseif ( event.phase == "moved" ) then
        -- Code executed when the touch is moved over the object
        -- Translate
        print( "touch location in content coordinates = " .. event.x .. "," .. event.y )
    elseif ( event.phase == "ended" ) then
        createDefense("1", event.x, event.y)
        print( "touch ended on object " .. tostring(event.target) )
    end
    return true  -- Prevents tap/touch propagation to underlying objects
end

function onCollision () 

end
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    -- local kiwi = display.newImage(sceneGroup, actorsSheet, actorsSheetInfo:getFrameIndex("Kiwi"), display.contentCenterX, display.contentCenterY)
    -- local covid = display.newImage(sceneGroup, actorsSheet, actorsSheetInfo:getFrameIndex("Capsid"), 100, display.contentCenterY)
    if ( phase == "will" ) then
        local maploc = "images/" .. TD_model:getCurrentEpisode().prefix .. "/" .. TD_model:getCurrentLevel().name .. ".png"

        local background = display.newImage(sceneGroup, maploc, display.contentCenterX, display.contentCenterY)
        background:addEventListener("touch", onBackgroundTouch)
        uiGroup = display.newGroup(sceneGroup)
        
        pathLength = totalPathDistance( TD_model:getCurrentLevel().path )
        pathRate = pathLength / TD_model:getCurrentLevel().levelTime

        -- Code here runs when the scene is still off screen (but is about to come on screen)
         laserGroup = display.newGroup(sceneGroup)
        enemiesGroup = display.newGroup(sceneGroup)
        defenseGroup = display.newGroup(sceneGroup)
       
        enemies = { } 
        defenses = { }
        gameTime = 0 

        physics.start()

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        -- physics.start()
        -- Runtime:addEventListener( "collision", onCollision )
        gameLoopTimer = timer.performWithDelay( 25, gameLoop, 0 )
        print (sceneGroup.numChildren)

    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        timer.cancel( gameLoopTimer )
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        -- Runtime:removeEventListener( "collision", onCollision )
        -- physics.pause()

        enemiesGroup:removeSelf()
        defenseGroup:removeSelf()
        laserGroup:removeSelf()

    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene