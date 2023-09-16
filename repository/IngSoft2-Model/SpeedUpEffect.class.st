Class {
	#name : #SpeedUpEffect,
	#superclass : #BoxEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
SpeedUpEffect >> changePolarity [
	^ SpeedUpReversedEffect new.
]

{ #category : #actions }
SpeedUpEffect >> triggeredBy: aSpaceship with: aGame [
	
	(aGame board) calculate: aSpaceship newpositionUsing: 4. 
	
]
