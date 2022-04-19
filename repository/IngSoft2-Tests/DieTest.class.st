Class {
	#name : #DieTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
DieTest >> should: aBlock raise: anErrorClass whoseDescriptionIncludes: anErrorMessage [ 
	self
			should: aBlock
			raise: anErrorClass
			whoseDescriptionIncludes: anErrorMessage
			description: 'Test did not fail as expected'
]

{ #category : #tests }
DieTest >> testDieCannotBeCreatedWithNumberOfSidesMinorThanThree [
	self 
		should: [ Die with: 2 ]
		raise: Error
		whoseDescriptionIncludes: 'Number of faces should be greater than 2'.
]

{ #category : #tests }
DieTest >> testDieRollResultIsBetweenOneAndNumberOfFaces [
	| numberOfSides die rollResult | 
	numberOfSides := 6.
	die := Die with: numberOfSides.
	rollResult := die roll.
	self assert: (rollResult between: 1 and: numberOfSides) 
]
