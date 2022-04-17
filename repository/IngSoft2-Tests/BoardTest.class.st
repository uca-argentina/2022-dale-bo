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
BoardTest >> testABoardCannotHaveLessThanOneBox [
	
	self 
		should: [Board with: 0]
		raise: Error	
		whoseDescriptionIncludes: 'A board must have at least one box'.
]

{ #category : #tests }
BoardTest >> testABoardMustHaveAtLeastOneBox [
	
	| aBoard |
	
	aBoard := Board with: 1.
	self assert: aBoard boxes > 0.
]

{ #category : #tests }
BoardTest >> testTheLastPositionOfABoardMustBeTheTotalNumberOfBoxes [
	
	| aBoard boxes|
	
	boxes := 15.
	aBoard := Board with: boxes.
	self assert: aBoard lastPosition equals: 15.
]
