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

function createButton (group, text, location, handler)

	local button = display.newText(text, location[1], location[2])
    

    local paint = {
	    type = "gradient",
	    color1 = { 0, .25, 0 },
	    color2 = { 0, .1, 0 },
	    direction = "down"
	}
	 
	local rect = display.newRect( group, location[1], location[2], button.contentWidth+40, button.contentHeight+10 )
	rect.fill = paint
	rect:addEventListener("tap", handler)
	group:insert(button)

    return button
end
return P