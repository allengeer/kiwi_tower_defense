local composer = require( "composer" )
local display = require("display")
local global = require("global")
local TD_model = require("TD_model")
local utils = require("utils")
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 
 
 
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
   
    background:setFillColor(0)

    -- local displayText = display.newText(backgroundGroup,"Select Level", 0, 20)
    
    -- displayText.anchorX=0
    -- displayText.anchorY=0
    utils.createText(backgroundGroup, "Episodes. . .", {0, 20})
    
    local buttons = {} 
    for i,v in ipairs(TD_model.episodes) do
        local button = utils.createButton(backgroundGroup, v.name, {10, i*60}, function (e) print (v.name .. " clicked" ) end)
        button.anchorY = 0
        button.anchorX = 0
        table.insert(buttons, button)

        for j=0,v.levels,1
        do
            local button = utils.createButton(backgroundGroup,j+1, {j*20 + 10, i*60+30}, function (e) print (v.name .. j .. " clicked" ) end)
            button.anchorY = 0
            button.anchorX = 0
            table.insert(buttons, button)
        end
    end

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