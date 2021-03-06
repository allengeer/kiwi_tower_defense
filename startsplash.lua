local composer = require( "composer" )
local display = require("display")
local global = require("global")
local utils = require("utils")
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 -- Tap listener function

 
 
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

    local splash = display.newImage(sceneGroup, "images/splash.png",  display.contentCenterX, display.contentCenterY)
    splash:scale(960/1024, 640/900)

    local playbutton utils.createButton (
        sceneGroup, 
        "Play Now", 
        {100, display.contentHeight - 100}, 
        function ( event )
            local object = event.target
            composer.gotoScene("selectlevel")
        end
    )
  
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