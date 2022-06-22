Class {
	#name : #PositionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PositionTest >> sequenceOfNoEffectsOf: boardSize with: effectToBePlaced at: positionOfEffectToBePlaced [

	| boxSequence |
	boxSequence := OrderedCollection new.
	boardSize timesRepeat: [ boxSequence add: NoEffect new ].
	boxSequence
		add: effectToBePlaced
		afterIndex: positionOfEffectToBePlaced.
	^ boxSequence
]

{ #category : #tests }
PositionTest >> should: aBlock raise: anError withMessage: anErrorMessage [

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
PositionTest >> testCreation [

	| dieOne dieTwo dieThree aDiceCup boxSequence game |
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 2.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	boxSequence := self
		               sequenceOfNoEffectsOf: 13
		               with: NoEffect new
		               at: 10.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: (Deck with: { SpeedCard new }).
	game playATurn.
	self assert: ((game spaceshipOf: 'Valen') position) boxNumber equals: 6.
]

{ #category : #tests }
PositionTest >> testPositionHasAValidShipName [

	self
		should: [ 
			Spaceship
				of: 'V'
				at: 0
				distance: 0
				laps: 0
				cards: {  }
				and: {  } ]
		raise: Error
		withMessage: 'Ship name must have a name longer than one character'
]
