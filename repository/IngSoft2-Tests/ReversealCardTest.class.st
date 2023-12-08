Class {
	#name : #ReversealCardTest,
	#superclass : #TestCase,
	#instVars : [
		'die',
		'reversealCard'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ReversealCardTest >> assert: aSpaceshipName isAt: aPositionNumber with: aLapNumber in: aGame [

	| spaceshipPosition |
	spaceshipPosition := aGame positionOf: aSpaceshipName.
	self assert: spaceshipPosition boxNumber equals: aPositionNumber.
	self assert: spaceshipPosition lapNumber equals: aLapNumber.
]

{ #category : #tests }
ReversealCardTest >> sequenceOfNoEffectsOf: boardSize with: effectToBePlaced at: positionOfEffectToBePlaced [

	| boxSequence |
	boxSequence := OrderedCollection new.
	(boardSize-1) timesRepeat: [ boxSequence add: NoEffect new ].
	boxSequence
		add: effectToBePlaced
		afterIndex: positionOfEffectToBePlaced-1.
	^ boxSequence
]

{ #category : #running }
ReversealCardTest >> setUp [
	super setUp.
	die:= LoadedDie with:6.
	reversealCard := ReversealCard new.
	
	"Put here a common initialization logic for tests"
]
