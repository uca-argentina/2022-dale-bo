Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
BoardTest >> should: block raise: classError whoseDescriptionIncludes: anErrorMessage [ 
	self 
		should: block
		raise: classError 
		whoseDescriptionIncludes: anErrorMessage
		description: 'Test did not fail as excepected'.
]

{ #category : #tests }
BoardTest >> testABoardMustHaveASpeedUpInSecondPositionAndMoveaShipToSixPosition [

	| aBoard dieOne  aDiceCup game speedUp |
	
	speedUp := SpeedUp new.	
	aBoard := Board withAll: {speedUp}.
	dieOne := LoadedDie with: 2.
	aDiceCup := DiceCup withAll: { 
			            dieOne }.
	game := Game
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        a: aBoard
		        and: aDiceCup.
	[game hasFinished] whileFalse:  [game playATurn].
	self assert: (game winner) equals: 'Valen'.
	self deny: (game winner) equals: 'Pablito'.
]

{ #category : #tests }
BoardTest >> testABoardMustHaveAtLeastOneBox [

	| aBoard box |
	
	box := Box new. 
	aBoard := Board withAll: { box }.
	self assert: aBoard numberOfBoxes > 0
]

{ #category : #tests }
BoardTest >> testABoardMustHaveAtLeastOneBoxWithNoEffect [

	| aBoard noEffect |
	
	noEffect := Box new. 
	aBoard := Board withAll: { noEffect. noEffect. noEffect}.
	self assert: aBoard numberOfBoxes > 0
]
