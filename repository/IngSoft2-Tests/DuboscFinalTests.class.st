Class {
	#name : #DuboscFinalTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #accessing }
DuboscFinalTests >> assert: aSpaceshipName isAt: aPositionNumber with: aLapNumber in: aGame [

	| spaceshipPosition |
	spaceshipPosition := aGame positionOf: aSpaceshipName.
	
	self assert: spaceshipPosition boxNumber equals: aPositionNumber.
	self assert: spaceshipPosition lapNumber equals: aLapNumber.
]

{ #category : #tests }
DuboscFinalTests >> sequenceOfNoEffectsOf: boardSize with: effectToBePlaced at: positionOfEffectToBePlaced [

	| boxSequence |
	boxSequence := OrderedCollection new.
	(boardSize-1) timesRepeat: [ boxSequence add: NoEffect new ].
	boxSequence
		add: effectToBePlaced
		afterIndex: positionOfEffectToBePlaced-1.
	^ boxSequence
]

{ #category : #tests }
DuboscFinalTests >> testSpaceshipAlphaLandsInASprintEffectAtBoxFiveAndMovesToPositionSevenCauseHeHasTwoCardsOnHand [

	| die game boxSequence |
	die := LoadedDie with: 4.
	boxSequence := self
		               sequenceOfNoEffectsOf: 10
		               with: (SprintEffect new)
		               at: 5.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { SpeedCard new }).
	game playATurn.
	self assert:'Spaceship Alpha' isAt:7 with:1 in: game.
	
	game giveTo: 'Spaceship Beta' card: (SpeedCard new). "BORRAR ESTO"
	game playATurn.
	self assert:'Spaceship Beta' isAt:8 with:1 in: game.
]
