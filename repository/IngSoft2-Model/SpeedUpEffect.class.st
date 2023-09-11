Class {
	#name : #SpeedUpEffect,
	#superclass : #BoxEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
SpeedUpEffect >> initialize [
	polarity:= true.
]

{ #category : #actions }
SpeedUpEffect >> triggeredBy: aSpaceship with: aGame [
	
	polarity ifTrue: [ (aGame board) calculate: aSpaceship newpositionUsing: 4 ] ifFalse:  [ (aGame board) calculateForSpaceshipsExcept: aSpaceship newpositionUsing: 4 ]. 
	
]
