-- this gets called starts when the level loads.
function start(song) -- arguments, the song name
    print("Succesfully loaded (Dev battle)... have fun ;)")
        

end

-- this gets called every frame
function update(elapsed) 
    local currentBeat = (songPos / 1000)*(bpm/60)
        for i=0,7 do
        setActorY(defaultStrum0Y + 10 * math.cos((currentBeat + i*3.76) * math.pi), i)
    end
end

-- this gets called every beat
function beatHit(beat)

end

-- this gets called every step
function stepHit(step) 
    if curStep == 64 then
        for i = 4, 7 do -- go to the center
            tweenPosXAngle(i, _G['defaultStrum'..i..'X'] - 275,getActorAngle(i) + 0, 0.6, 'setDefault')
        end
    end
    if curStep == 64 then
        strumLine1Visible = false -- removes the first line of notes and strums lol
        for i=0,3 do
            tweenFadeIn(i,0,0.1)
        end
    end

    if curStep == 64 then
        setCamZoom(1.2)
    end
    -- Character changes lol -- im swag
    if curStep == 303 then
        changeDadCharacter('tiagoswag') -- fancy and swag me
    end
    -- gonna be a lot of shit copy paste... idk how to do this the efficient way... is there even one?$
    if curStep == 308 then
        changeDadCharacter('tiago') -- bacc to normal me
    end
    if curStep == 399 then
        changeDadCharacter('tiagoswag') -- fancy and swag me
    end
    if curStep == 404 then
        changeDadCharacter('tiago') -- bacc to normal me
    end
    if curStep == 431 then
        changeDadCharacter('tiagoswag') -- fancy and swag me
    end
    if curStep == 436 then
        changeDadCharacter('tiago') -- bacc to normal me
    end
    if curStep == 524 then
        changeDadCharacter('tiagoswag') -- fancy and swag me
    end
    if curStep == 575 then
        changeDadCharacter('tiago') -- bacc to normal me
    end
    if curStep == 651 then
        changeDadCharacter('tiagoswag') -- fancy and swag me
    end
    if curStep == 703 then
        changeDadCharacter('tiago') -- bacc to normal me
    end
    if curStep == 1040 then
        changeDadCharacter('tiagoswag') -- fancy and swag me
    end
    if curStep == 1136 then
        changeDadCharacter('tiago') -- bacc to normal me
    end
    if curStep == 1288 then
        changeDadCharacter('tiagoswag') -- fancy and swag me
    end
    if curStep == 1343 then
        changeDadCharacter('tiago') -- bacc to normal me
    end
    if curStep == 1549 then
        changeDadCharacter('tiagoswag') -- fancy and swag me
    end
    if curStep == 1766 then
        changeDadCharacter('tiago') -- bacc to normal me
    end
    if curStep == 1792 then
        changeDadCharacter('tiagoswag') -- fancy and swag me
    end
    if curStep == 1795 then
        changeDadCharacter('tiago') -- bacc to normal me
    end
    if curStep == 1808 then
        changeDadCharacter('tiagoswag') -- fancy and swag me
    end
    if curStep == 1811 then
        changeDadCharacter('tiago') -- bacc to normal me
    end
    if curStep == 1824 then
        changeDadCharacter('tiagoswag') -- fancy and swag me
    end
    if curStep == 1827 then
        changeDadCharacter('tiago') -- bacc to normal me
    end
    if curStep == 1840 then
        changeDadCharacter('tiagoswag') -- fancy and swag me
    end
    if curStep == 1843 then
        changeDadCharacter('tiago') -- bacc to normal me
    end
    if curStep == 2047 then
        changeDadCharacter('tiagoswag') -- fancy and swag me
    end
    if curStep == 2072 then
        changeDadCharacter('tiago') -- bacc to normal me
    end
end





function setDefault(id)
	_G['defaultStrum'..id..'X'] = getActorX(id)
end