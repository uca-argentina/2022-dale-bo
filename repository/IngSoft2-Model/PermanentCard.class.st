Class {
	#name : #PermanentCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
PermanentCard >> applyStrategyFor: aSpaceship in: aGame using: aCardPlay [
	aGame turnSequence whoPlays = aSpaceship 
	ifFalse: [ aGame punishPlayer: aSpaceship ]
	ifTrue: [ aGame applyCardPlayFor: aCardPlay ]
]
