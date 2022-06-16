Class {
	#name : #RedoCardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

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
		                with: { 1 }) boxSequence.
	boxSequence
		add: (CardGiverEffect with: deckForCardGiver)
		afterIndex: 12.
	game := Game
		        spaceships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deckForGame.
	game playATurn.
	game playATurn.
	game playATurn.
	accelerationCard
		playedUsing: game
		by: 'Valen'
		to: ''
		for: accelerationCard.
	game playATurn.
	cancelationCard
		playedUsing: game
		by: 'Pablo'
		to: 'Pablo'
		for: accelerationCard.
	game playATurn.
	redoCard
		playedUsing: game
		by: 'Pablo'
		to: 'Seba'
		for: accelerationCard.
	self assert: (game positionOfShip: 'Pablo') boxNumber equals: 13.
	game playATurn.
	self assert: (game positionOfShip: 'Seba') boxNumber equals: 13
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
		                with: { 1 }) boxSequence.
	game := Game
		        spaceships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deckForGame.
	game playATurn.
	repeatCard
		playedUsing: game
		by: 'Valen'
		to: 'Valen'
		for: repeatCard.
	game playATurn.
	redoCard playedUsing: game by:'Pablo'  to:'Pablo'  for:redoCard.
	self assert: (game positionOfShip: 'Valen') hand size equals: 3.
	self assert: (game positionOfShip: 'Pablo') hand size equals: 3.
	
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
		                with: { 1 }) boxSequence.
	game := Game
		        spaceships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deckForGame.
	
	accellerationCard
		playedUsing: game
		by: 'Valen'
		to: ''
		for: accellerationCard.
	game playATurn.
	game playATurn.
	game playATurn.
	game playATurn.
	redoCard playedUsing: game by:'Pablo'  to:'Valen'  for:redoCard.
	game playATurn.
	game playATurn.
	self assert: (game positionOfShip:'Seba') boxNumber equals: 16.
	
	
	
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
		                with: { 1 }) boxSequence.
	game := Game
		        spaceships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deckForGame.
	game playATurn.
	game playATurn.
	game playATurn.
	game playATurn.
	self assert: (game positionOfShip: 'Seba') boxNumber equals: 7.
	overloadCard
		playedUsing: game
		by: 'Pablo'
		to: 'Seba'
		for: overloadCard.
	redoCard
		playedUsing: game
		by: 'Pablo'
		to: 'Seba'
		for: redoCard.
	game playATurn.
	game playATurn.
	self assert: (game positionOfShip: 'Seba') boxNumber equals: 9
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
		                with: { 1 }) boxSequence.
	game := Game
		        spaceships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deckForGame.
	game playATurn.
	self
		should: [ redoCard 
		playedUsing: game
		by: 'Valen'
		to: 'Valen'
		for: redoCard . ]
		raise: Error
		withMessage:
		'There is no cards played to apply redo'.
	
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
		                with: { 1 }) boxSequence.
	game := Game
		        spaceships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deckForGame.
	game playATurn.
	game playATurn.
	game playATurn.
	aSpeedCard
		playedUsing: game
		by: 'Valen'
		to: 'Valen'
		for: aSpeedCard.
	game playATurn.
	self assert: (game positionOfShip: 'Valen') boxNumber equals: 14.
	self assert: (game positionOfShip: 'Pablo') boxNumber equals: 7.
	redoCard
		playedUsing: game
		by: 'Pablo'
		to: 'Pablo'
		for: redoCard.
	redoCard
		playedUsing: game
		by: 'Pablo'
		to: 'Pablo'
		for: redoCard.
	game playATurn.
	self assert: (game positionOfShip: 'Pablo') boxNumber equals: 15.
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
		                with: { 1 }) boxSequence.
	game := Game
		        spaceships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deckForGame.
	game playATurn.
	self assert: (game positionOfShip: 'Valen') boxNumber equals: 7.
	overloadCard
		playedUsing: game
		by: 'Pablo'
		to: 'Valen'
		for: overloadCard.
	game playATurn.
	self
		should: [ redoCard
		playedUsing: game
		by: 'Pablo'
		to: ''
		for: redoCard. ]
		raise: Error
		withMessage:
		'A permanent card cannot be played on another spaceship turn'
]
