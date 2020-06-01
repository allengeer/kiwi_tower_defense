local composer = require( "composer" )
 
local scene = composer.newScene()
local display = require("display")
local global = require("global")
local TD_model = require("TD_model")
local utils = require("utils")
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
local actorsSheetInfo = require("images.actors")
local actorsSheet = graphics.newImageSheet( "images/actors.png", actorsSheetInfo:getSheet() )
local enemiesGroup

local enemies = { } 
local gameTime = 0 
local currentLevel = TD_model:getCurrentLevel()

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
function gameLoop ()
    gameTime = gameTime + 50

    if gameTime % 1000 == 0 then
        enemyIndex = gameTime / 1000
        if enemyIndex <= #currentLevel.enemies then
            if string.sub(currentLevel.enemies, enemyIndex, enemyIndex) ~= "X" then
                local covid = display.newImage(enemiesGroup, actorsSheet, actorsSheetInfo:getFrameIndex("Capsid"), 20, display.contentCenterY)
                table.insert(enemies, covid)
            end
        end
    end
    
    for i,v in ipairs(enemies) do
        v:translate(5,0)

        if v.x - v.contentWidth/2 > display.contentWidth then
            v:removeSelf()
            table.remove( enemies, i )
        end
    end

end

function onCollision () 

end
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    enemiesGroup = display.newGroup(sceneGroup)
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    local background = display.newImage(sceneGroup, "images/Level 1.png", display.contentCenterX, display.contentCenterY)
    
    -- local kiwi = display.newImage(sceneGroup, actorsSheet, actorsSheetInfo:getFrameIndex("Kiwi"), display.contentCenterX, display.contentCenterY)
    -- local covid = display.newImage(sceneGroup, actorsSheet, actorsSheetInfo:getFrameIndex("Capsid"), 100, display.contentCenterY)
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        physics.start()
        Runtime:addEventListener( "collision", onCollision )
        gameLoopTimer = timer.performWithDelay( 50, gameLoop, 0 )
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
        Runtime:removeEventListener( "collision", onCollision )
        physics.pause()
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