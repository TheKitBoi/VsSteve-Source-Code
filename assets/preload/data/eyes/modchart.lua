-- this gets called starts when the level loads.
function start(song) -- arguments, the song name
    print("Found the Modchart on (Eyes) - loading...")
        
    if curStep == 54 then
        showOnlyStrums = true -- remove all hud elements besides notes and strums
        for i=0,3 do
            tweenFadeIn(i,0,0.6)
        end
end

-- this gets called every frame
function update(elapsed) 
    local currentBeat = (songPos / 1000)*(bpm/60)
        for i=0,7 do
              setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin((currentBeat + i*0.25) * math.pi), i)
              setActorY(_G['defaultStrum'..i..'Y'] + 32 * math.cos((currentBeat + i*0.25) * math.pi), i)
    end
end

-- this gets called every beat
function beatHit(beat)
        
end

-- this gets called every step
function stepHit(step) -- arguments, the current step of the song (4 steps are in a beat)

    end
end