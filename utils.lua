local display = require("display")
local P = {}   -- package

if _REQUIREDNAME == nil then
  utils = P
else
  _G[_REQUIREDNAME] = P
end
local print = print
local math = math
local tonumber = tonumber
setfenv(1, P)

-- COLOR UTILITIES
function hex (hex, alpha) 
	local redColor,greenColor,blueColor=hex:match('(..)(..)(..)')
	redColor, greenColor, blueColor = tonumber(redColor, 16)/255, tonumber(greenColor, 16)/255, tonumber(blueColor, 16)/255
	redColor, greenColor, blueColor = math.floor(redColor*100)/100, math.floor(greenColor*100)/100, math.floor(blueColor*100)/100
	if alpha == nil then
		return redColor, greenColor, blueColor
	elseif alpha > 1 then
		alpha = alpha / 100
	end
	return redColor, greenColor, blueColor, alpha
end

function rgb (r, g, b, alpha)
	local redColor,greenColor,blueColor=r/255, g/255, b/255
	redColor, greenColor, blueColor = math.floor(redColor*100)/100, math.floor(greenColor*100)/100, math.floor(blueColor*100)/100
	if alpha == nil then
		return redColor, greenColor, blueColor
	elseif alpha > 1 then
		alpha = alpha / 100
	end
	return redColor, greenColor, blueColor, alpha
end

function createText (group, text, location)
	local displayText = display.newText(group, text, location[1], location[2])
    
    displayText.anchorX=0
    displayText.anchorY=0
    return displayText
end

function createButton (group, text, location, handler, buttonSize)
	buttonSize = buttonSize or 28
	local button = display.newText(
	    {
	    	text = text,
	    	x = location[1],
	    	y = location[2],
	    	font = "Arial",
	    	fontSize = buttonSize,
	    	align = "center"
	    }
    )
    local paint = {
	    type = "gradient",
	    color1 = { 0, .25, 0 },
	    color2 = { 0, .1, 0 },
	    direction = "down"
	}
	 
	local rect = display.newRoundedRect( group, location[1], location[2], button.contentWidth+40, button.contentHeight+10, 10 )
	rect.fill = paint
	rect:addEventListener("tap", handler)
	group:insert(button)

    return button
end

function hasCollidedCircle( obj1, obj2 )
 

    if ( obj1 == nil ) then  -- Make sure the first object exists
        return false
    end
    if ( obj2 == nil ) then  -- Make sure the other object exists
        return false
    end
 
 	obj2.contentWidth = obj2.contentWidth or obj1.contentWidth
 	obj2.contentHeight = obj2.contentHeight or obj1.contentHeight
 	
    local dx = obj1.x - obj2.x
    local dy = obj1.y - obj2.y
 
    local distance = math.sqrt( dx*dx + dy*dy )
    local objectSize = (obj2.contentWidth/2) + (obj1.contentWidth/2)
 
    if ( distance < objectSize ) then
        return true
    end
    return false
end
return P