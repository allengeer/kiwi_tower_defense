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
            x=1,
            y=70,
            width=60,
            height=55,

            sourceX = 2,
            sourceY = 2,
            sourceWidth = 66,
            sourceHeight = 58
        },
        {
            -- Kiwi
            x=1,
            y=1,
            width=64,
            height=67,

        },
    },

    sheetContentWidth = 66,
    sheetContentHeight = 126
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
