--ive got soo many questions
local noteDefaultXs = {}
local noteDefaultYs = {}
local noteXs = {}
local noteYs = {}

function onCreate()
	for i = 0,3 do
	  noteDefaultXs[i] = -25+(i+4)*110
      if downscroll then
        noteDefaultYs[i] = 550
      else
        noteDefaultYs[i] = 60
      end
	  noteXs[i] = 0
	  noteYs[i] = 0
	end
	for i = 4,7 do
	  noteDefaultXs[i] = -25+i*110
      if downscroll then
        noteDefaultYs[i] = 550
      else
        noteDefaultYs[i] = 60
      end
	  noteXs[i] = 0
	  noteYs[i] = 0
	end
    
end
function onUpdate()
    for i = 0, 3 do
        setPropertyFromGroup('strumLineNotes',i,'alpha',0.2)
    end
	for i = 0,7 do
	  setPropertyFromGroup('strumLineNotes',i,'x',noteDefaultXs[i]+noteXs[i])
	  setPropertyFromGroup('strumLineNotes',i,'y',noteDefaultYs[i]+noteYs[i])
	end
end
function onUpdatePost()
	notesLength = getProperty('notes.length')
	songPos = getSongPosition()
	local currentBeat = (songPos/1000)*(bpm/60)
	for i1 = 0, notesLength, 1 do
		Thisnotex = getPropertyFromGroup('notes',i1,'x')
		Thisnotey = getPropertyFromGroup('notes',i1,'y')
		Thisnote = getPropertyFromGroup('notes',i1,'noteData')
		Thisnoteoriginx = noteDefaultXs[Thisnote]
		Thisnoteoriginy = getPropertyFromGroup('strumLineNotes',Thisnote,'y')
        if downscroll then
            setPropertyFromGroup('notes',i1,'x',10+Thisnoteoriginx+math.cos((Thisnotey*0.001+currentBeat)*math.pi)*-80)
        else
            setPropertyFromGroup('notes',i1,'x',10+Thisnoteoriginx+math.sin((Thisnotey*0.001+currentBeat)*math.pi)*80)

        end
        setPropertyFromGroup('notes',i1,'y',Thisnotey+math.sin((currentBeat*2)*math.pi)*50)
	end
end