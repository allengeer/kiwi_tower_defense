--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:dfd9f53540f6ea45c41c5d4baa9750d3:9a553178d9c85c4cff3851cfd5c4d975:aa40cafc11f5dbcf93ca200ae9346589$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- Capsid
            x=4,
            y=280,
            width=240,
            height=220,

            sourceX = 8,
            sourceY = 8,
            sourceWidth = 262,
            sourceHeight = 233
        },
        {
            -- Kiwi
            x=4,
            y=4,
            width=256,
            height=268,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 254,
            sourceHeight = 268
        },
    },

    sheetContentWidth = 264,
    sheetContentHeight = 504
}

SheetInfo.frameIndex =
{

    ["Capsid"] = 1,
    ["Kiwi"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
