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
	aBoard := Board withAll: { 
			          noEffect.
			          noEffect.
			          noEffect }.
	self assert: aBoard numberOfBoxes > 0
]
