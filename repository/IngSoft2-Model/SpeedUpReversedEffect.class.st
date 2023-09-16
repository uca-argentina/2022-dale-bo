Class {
	#name : #SpeedUpReversedEffect,
	#superclass : #BoxEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
SpeedUpReversedEffect >> changePolarity [
	^ SpeedUpEffect new.
]

{ #category : #actions }
SpeedUpReversedEffect >> triggeredBy: aSpaceship with: aGame [
	(aGame board) calculateForSpaceshipsExcept: aSpaceship newpositionUsing: 4.
]
