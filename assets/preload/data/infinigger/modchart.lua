function start(song) 
  
end
function setDefault(id)
	_G['defaultStrum'..id..'X'] = getActorAngle(id)
end
function update (elapsed)
    
  
end
function stepHit(step) 
    
    ---makes you seethe lole  
    if curStep == 1797 then 
        --hide em 
        setActorAlpha(0,7)
        setActorAlpha(0,6)
        setActorAlpha(0,5)
        setActorAlpha(0,4)
    end
    if curStep == 1802 then
        --x's
        setActorX(defaultStrum4X,7)
        setActorX(defaultStrum5X,6)
        setActorX(defaultStrum6X,5)
        setActorX(defaultStrum7X,4)
        for i=4,7 do
            tweenAngle(i,_G['defaultStrum'..i..'Angle']+180,0.000001,'setDefault')          
        end
    end
    if curStep == 1820 then
        --show em
        setActorAlpha(100,7)
        setActorAlpha(100,6)
        setActorAlpha(100,5)
        setActorAlpha(100,4)
      
    end

end      
  

function beatHit(beat) 

end



