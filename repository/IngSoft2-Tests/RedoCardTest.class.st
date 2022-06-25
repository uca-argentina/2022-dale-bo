Class {
	#name : #RedoCardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
RedoCardTest >> assert: aSpaceshipName isAt: aPositionNumber with: aLapNumber in: aGame [

	^ (aGame spaceshipOf: aSpaceshipName) position boxNumber
	  = aPositionNumber
]

{ #category : #tests }
RedoCardTest >> should: aBlock raise: anError withMessage: anErrorMessage [

	| tmp2 tmp3 |
	aBlock
		on: anError
		do: [ :error | 
			tmp2 := true.
			tmp3 := error messageText ].
	self
		assert: tmp2;
		assert: tmp3 equals: anErrorMessage
]

{ #category : #tests }
RedoCardTest >> testPabloPlaysARedoAfterACancelation [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deckForGame cancelationCard redoCard deckForCardGiver accelerationCard deckForAccelerationCardGiver |
    dieOne := LoadedDie with: 3.
    dieTwo := LoadedDie with: 2.
    dieThree := LoadedDie with: 1.
    aDiceCup := DiceCup withAll: { 
                        dieOne.
                        dieTwo.
                        dieThree }.
    cancelationCard := CancellationCard new.
    redoCard := RedoCard new.
    accelerationCard := AccelerationCard new.
    deckForCardGiver := Deck with: { redoCard }.
    deckForAccelerationCardGiver := Deck with: { accelerationCard }.
    deckForGame := Deck with: { cancelationCard }.
    boxSequence := (BoxesGenerator
                        generate: 16
                        for:
                        { (CardGiverEffect with:
                             deckForAccelerationCardGiver) }
                        with: { 100 }) boxSequence.
    boxSequence
        add: (CardGiverEffect with: deckForCardGiver)
        afterIndex: 12.
    game := SpaceRaceGame
                with: { 'Valen'. 'Pablo'. 'Seba' }
                boardWith: boxSequence
                distance: (Parsecs with: 200)
                laps: 2
                diceCup: aDiceCup
                and: deckForGame.
    game playATurn.
    game playATurn.
    game playATurn.
    accelerationCard
        playedOn: game
        by: 'Valen'.
    game playATurn.
    cancelationCard
        playedOn: game
        by: 'Pablo'
        to: 'Pablo'
        for: accelerationCard.
    game playATurn.
    redoCard
        playedOn: game
        by: 'Pablo'
        to: 'Seba'.
    self assert:'Pablo' isAt:13 with:1 in:game.
    game playATurn.
    self assert:'Seba' isAt:13 with:1 in:game.
]

{ #category : #tests }
RedoCardTest >> testPabloPlaysARedoAfterValenPlaysARepeat [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deckForGame repeatCard redoCard deckForCardGiver |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	repeatCard := RepeatCard new.
	redoCard := RedoCard new.
	deckForCardGiver := Deck with: { redoCard }.
	deckForGame := Deck with: { repeatCard }.
	boxSequence := (BoxesGenerator
		                generate: 16
		                for: { (CardGiverEffect with: deckForCardGiver) }
		                with: { 100 }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deckForGame.
	game playATurn.
	repeatCard
		playedOn: game
		by: 'Valen'
		to: 'Valen'.
	game playATurn.
	redoCard playedOn: game by:'Pablo'  to:'Pablo'.
	self assert: ((game spaceshipOf: 'Valen') hand ) hand size equals: 3.
	self assert: ((game spaceshipOf: 'Pablo') hand) hand size equals: 3.
	
]

{ #category : #tests }
RedoCardTest >> testPabloPlaysARedoAfterValenPlaysAnAccellerationCard [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deckForGame accellerationCard redoCard deckForCardGiver |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	accellerationCard := AccelerationCard  new.
	redoCard := RedoCard new.
	deckForCardGiver := Deck with: { redoCard }.
	deckForGame := Deck with: { accellerationCard }.
	boxSequence := (BoxesGenerator
		                generate: 16
		                for: { (CardGiverEffect with: deckForCardGiver) }
		                with: { 100 }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deckForGame.
	
	accellerationCard
		playedOn: game
		by: 'Valen'.
	game playATurn.
	game playATurn.
	game playATurn.
	game playATurn.
	redoCard playedOn: game by:'Pablo'  to:'Valen'.
	game playATurn.
	game playATurn.
	self assert: 'Seba' isAt:16 with:1 in:game.
	
	
	
]

{ #category : #tests }
RedoCardTest >> testPabloPlaysARedoCardAfterPabloPlaysAOverloadCard [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deckForGame deckForCardGiver overloadCard redoCard |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	overloadCard := OverloadCard new.
	deckForGame := Deck with: { overloadCard }.
	redoCard := RedoCard new.
	deckForCardGiver := Deck with: { redoCard }.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { (CardGiverEffect with: deckForCardGiver) }
		                with: { 100 }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deckForGame.
	game playATurn.
	game playATurn.
	game playATurn.
	game playATurn.
	self assert:'Seba' isAt:7 with:1 in:game.
	overloadCard
		playedOn: game
		by: 'Pablo'
		to: 'Seba'.
	redoCard
		playedOn: game
		by: 'Pablo'
		to: 'Seba'.
	game playATurn.
	game playATurn.
	self assert:'Seba' isAt:9 with:1 in:game.
]

{ #category : #tests }
RedoCardTest >> testPabloPlaysARedoWhenNoCardWasPlayedPreviously [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deckForGame cancelationCard redoCard deckForCardGiver |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	cancelationCard := CancellationCard new.
	redoCard := RedoCard new.
	deckForCardGiver := Deck with: { redoCard }.
	deckForGame := Deck with: { cancelationCard }.
	boxSequence := (BoxesGenerator
		                generate: 16
		                for: { (CardGiverEffect with: deckForCardGiver) }
		                with: { 100 }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deckForGame.
	game playATurn.
	self
		should: [ redoCard 
		playedOn: game
		by: 'Valen'
		to: 'Valen' ]
		raise: Error
		withMessage:
		'There are no cards played'.
	
]

{ #category : #tests }
RedoCardTest >> testPabloPlaysTwoRedoCardsAfterPlaysASpeedCard [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deckForGame redoCard deckForCardGiver aSpeedCard |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	redoCard := RedoCard new.
	aSpeedCard := SpeedCard new.
	deckForCardGiver := Deck with: { aSpeedCard }.
	deckForGame := Deck with: { redoCard }.
	boxSequence := (BoxesGenerator
		                generate: 16
		                for: { (CardGiverEffect with: deckForCardGiver) }
		                with: { 100 }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deckForGame.
	game playATurn.
	game playATurn.
	game playATurn.
	aSpeedCard
		playedOn: game
		by: 'Valen'
		to: 'Valen'.
	game playATurn.
	self assert:'Valen' isAt:14 with:1 in:game.
	self assert:'Pablo' isAt:7 with:1 in:game.
	redoCard
		playedOn: game
		by: 'Pablo'
		to: 'Pablo'.
	redoCard
		playedOn: game
		by: 'Pablo'
		to: 'Pablo'.
	game playATurn.
	self assert:'Pablo' isAt:15 with:1 in:game.
]

{ #category : #tests }
RedoCardTest >> testPabloTriesToPlaysARedoCardNotInHisTurnAfterPabloPlaysAOverloadCard [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deckForGame deckForCardGiver overloadCard redoCard |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	overloadCard := OverloadCard new.
	deckForGame := Deck with: { overloadCard }.
	redoCard := RedoCard new.
	deckForCardGiver := Deck with: { redoCard }.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { (CardGiverEffect with: deckForCardGiver) }
		                with: { 100 }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deckForGame.
	game playATurn.
	self assert:'Valen' isAt:7 with:1 in:game.
	overloadCard
		playedOn: game
		by: 'Pablo'
		to: 'Valen'.
	game playATurn.
	self
		should: [ redoCard
		playedOn: game
		by: 'Pablo'
		to: 'Valen'. ]
		raise: Error
		withMessage:
		'A permanent card cannot be played on another spaceship turn'
]
