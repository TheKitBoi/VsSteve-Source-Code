-- this gets called starts when the level loads.
function start(song) -- arguments, the song name
    print("Succesfully loaded (supo)... have fun ;)")
        
end

-- this gets called every frame
function update(elapsed) 

end

-- this gets called every beat
function beatHit(beat)

end

-- this gets called every step
function stepHit(step) -- arguments, the current step of the song (4 steps are in a beat)
    if curStep == 1 then
        showOnlyStrums = true -- remove all hud elements besides notes and strums
        for i=0,3 do
            tweenFadeIn(i,0,0.6)
    end
end