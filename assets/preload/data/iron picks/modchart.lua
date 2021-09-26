-- this gets called starts when the level loads.
function start(song) -- arguments, the song name
    print("Succesfully loaded (Iron Picks)... have fun ;)")
        

end

-- this gets called every beat
function beatHit(beat)

end

-- this gets called every step
function stepHit(step) 
    -- Character changes lol -- im swag
    if curBeat == 190 then
        changeDadCharacter('alexpickaxemad') -- hoesmad
    end
end





function setDefault(id)
	_G['defaultStrum'..id..'X'] = getActorX(id)
end