Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardTest >> should: aBlock raise: anError withMessage: anErrorMessage [

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
CardTest >> testADeckCannotBeCreatedWithNoCards [

	 self
		should: [Deck with: {} ]
		raise: Error
		withMessage: 'A deck must have at least one card'
	


]

{ #category : #tests }
CardTest >> testPlayerLandsInABoxAndReceivesACard [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deck |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	deck := Deck with: { 
			        SpeedCard new.
			        OverloadCard new }.
	boxSequence := (BoxesGenerator
		                generateWithOnly: (CardGiverEffect new)
		                at: 6
		                of: 10) boxSequence.
	game := Game
		        spaceships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: 200
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	game playATurn.

	self assert: (game positionOfShip: 'Valen') numberOfCards equals: 3
]

{ #category : #tests }
CardTest >> testPlayerLandsInABoxAndReceivesASpeedCard [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deck |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	deck := Deck with: { SpeedCard new }.
	boxSequence := (BoxesGenerator
		                generateWithOnly: (CardGiverEffect new)
		                at: 6
		                of: 10) boxSequence.
	game := Game
		        spaceships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: 200
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	game playATurn.
	(game positionOfShip: 'Valen')
		playACard: SpeedCard new
		to: (game positionOfShip: 'Pablo').
	game playATurn.

	self assert: (game positionOfShip: 'Pablo') boxNumber equals: 8
]

{ #category : #tests }
CardTest >> testPlayerLandsInABoxAndReceivesAnOverloadCard [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deck |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	deck := Deck with: { OverloadCard new }.
	boxSequence := (BoxesGenerator
		                generateWithOnly: (CardGiverEffect new)
		                at: 6
		                of: 10) boxSequence.
	game := Game
		        spaceships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: 200
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	game playATurn.
	(game positionOfShip: 'Valen')
		playACard: OverloadCard new
		to: (game positionOfShip: 'Pablo').
	game playATurn.

	self assert: (game positionOfShip: 'Pablo') boxNumber equals: 5
]

{ #category : #tests }
CardTest >> testValenTriesToPlayACardThatIsNotInHisHand [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deck |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	deck := Deck with: { SpeedCard new }.
	boxSequence := (BoxesGenerator
		                generateWithOnly: (CardGiverEffect new)
		                at: 6
		                of: 10) boxSequence.
	game := Game
		        spaceships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: 200
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	game playATurn.
	self
		should: [ 
			(game positionOfShip: 'Valen')
				playACard: OverloadCard new
				to: (game positionOfShip: 'Pablo') ]
		raise: Error
		withMessage: 'The spaceship does not have this card'
]
