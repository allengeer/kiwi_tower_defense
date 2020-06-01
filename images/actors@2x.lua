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
            x=2,
            y=140,
            width=120,
            height=110,

            sourceX = 4,
            sourceY = 4,
            sourceWidth = 131,
            sourceHeight = 117
        },
        {
            -- Kiwi
            x=2,
            y=2,
            width=128,
            height=134,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 127,
            sourceHeight = 134
        },
    },

    sheetContentWidth = 132,
    sheetContentHeight = 252
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
