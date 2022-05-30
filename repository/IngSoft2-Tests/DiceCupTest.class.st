Class {
	#name : #DiceCupTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
DiceCupTest >> should: aBlock raise: anErrorClass whoseDescriptionIncludes: anErrorMessage [ 
	self
			should: aBlock
			raise: anErrorClass
			whoseDescriptionIncludes: anErrorMessage
			description: 'Test did not fail as expected'
]

{ #category : #tests }
DiceCupTest >> testDiceCupCannotBeEmpty [

	self
		should: [ DiceCup withAll: {  } ]
		raise: Error
		whoseDescriptionIncludes: 'DiceCup can´t be empty'
]

{ #category : #tests }
DiceCupTest >> testDiceCupRollShouldReturnTheSumOfTheRollOfAllDiceInIt [

	| dieOne dieTwo dieThree aDiceCup rollResult |
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 3.

	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.

	rollResult := aDiceCup roll.
	self assert: rollResult equals: 6
]

{ #category : #tests }
DiceCupTest >> testDieCannotBeCreatedWithNumberOfSidesMinorThanThree [

	self
		should: [ Die with: 2 ]
		raise: Error
		whoseDescriptionIncludes: 'Number of faces should be greater than 2'
]

{ #category : #tests }
DiceCupTest >> testDieRollResultIsBetweenOneAndNumberOfFaces [

	| numberOfSides die rollResult |
	numberOfSides := 6.
	die := Die with: numberOfSides.
	rollResult := die roll.
	self assert: (rollResult between: 1 and: numberOfSides)
]

{ #category : #tests }
DiceCupTest >> testLoadedDieCantBeLoadedWithNegativeNumber [

	self
		should: [ LoadedDie with: -1 ]
		raise: Error
		whoseDescriptionIncludes: 'Number of faces should be greater than 0'
]

{ #category : #tests }
DiceCupTest >> testLoadedDieCantBeLoadedWithZero [

	self
		should: [ LoadedDie with: 0 ]
		raise: Error
		whoseDescriptionIncludes: 'Number of faces should be greater than 0'
]

{ #category : #tests }
DiceCupTest >> testLoadedDieRollsOneWhenLoadedWithOne [

	| die rollResult |
	die := LoadedDie with: 1.
	rollResult := die roll.
	self assert: rollResult equals: 1
]
