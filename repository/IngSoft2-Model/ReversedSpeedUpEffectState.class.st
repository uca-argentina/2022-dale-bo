Class {
	#name : #ReversedSpeedUpEffectState,
	#superclass : #BoxEffectState,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
ReversedSpeedUpEffectState >> reverse [
	^ NormalSpeedUpEffectState new.
]

{ #category : #action }
ReversedSpeedUpEffectState >> triggeredBy: aSpaceship with: aGame [

	(aGame board) calculate: aSpaceship newpositionUsing: -4 
]
