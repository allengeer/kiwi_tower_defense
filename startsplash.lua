local composer = require( "composer" )
local display = require("display")
local colcov = require("convertcolor")
local global = require("global")
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 -- Tap listener function
local function playListener( event )
    local object = event.target
    print("TAP")
    composer.gotoScene("selectlevel")
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    
end
 
 
-- show()
function scene:show( event )
    
    local sceneGroup = self.view
    local phase = event.phase

    local backgroundGroup = display.newGroup(sceneGroup)
    local background = display.newRect(backgroundGroup,display.contentCenterX, display.contentCenterY,display.contentWidth,display.contentHeight)
    local backgroundGradient = {
        type="gradient",
        color1={colcov.rgb(130,69,25)}, 
        color2={ 0 }, 
        direction="down"
    }
    background:setFillColor(backgroundGradient)

    local displayText = display.newText(backgroundGroup,"Tower Defense Framework " .. global.version, 0, 20)
    
    displayText.anchorX=0
    displayText.anchorY=0

    local playbutton = display.newText(backgroundGroup, "Play Now", display.contentCenterX, display.contentCenterY)
    playbutton:addEventListener("tap", playListener)
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
       
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        composer.removeScene("startsplash")
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