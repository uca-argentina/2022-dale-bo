Class {
	#name : #NormalSpeedUpEffectState,
	#superclass : #BoxEffectState,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
NormalSpeedUpEffectState >> reverse [
	^ ReversedSpeedUpEffectState new.
]

{ #category : #action }
NormalSpeedUpEffectState >> triggeredBy: aSpaceship with: aGame [

	(aGame board) calculate: aSpaceship newpositionUsing: 4 
]
