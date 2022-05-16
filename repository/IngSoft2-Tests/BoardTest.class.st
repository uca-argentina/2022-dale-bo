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
BoardTest >> testABoardHasRandomGeneratedBoxes [

	| randomBoxes aBoard box |
	box := Box parsecs:2.
	randomBoxes := (BoxesGenerator generateWith:10 and:200) boxSequence.
	aBoard:= Board withAll: randomBoxes  and: 2.
	self assert: (aBoard boxes) size equals:10.
]

{ #category : #tests }
BoardTest >> testABoardMustHaveAtLeastOneBox [

	self
		should: [Board withAll: { }  and: 2]
		raise: Error
		whoseDescriptionIncludes: 'A board must have at least one box'
]

{ #category : #tests }
BoardTest >> testABoardMustHaveAtLeastOneBoxWithNoEffect [

	| aBoard noEffect |
	noEffect := Box parsecs:2.
	aBoard := Board withAll: { 
			          noEffect.
			          noEffect.
			          noEffect }  and: 2.
	self assert: aBoard lastPosition  > 0
]

{ #category : #tests }
BoardTest >> testABoardMustHaveAtLeastOneLap [
	| noEffect |
	noEffect := Box parsecs:2.
	self
		should: [Board withAll: {noEffect }  and: 0]
		raise: Error
		whoseDescriptionIncludes: 'A board must have at least one lap'
]
