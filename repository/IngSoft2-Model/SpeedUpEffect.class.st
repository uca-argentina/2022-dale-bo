Class {
	#name : #SpeedUpEffect,
	#superclass : #BoxEffect,
	#instVars : [
		'state'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
SpeedUpEffect >> initialize [ 
	super initialize.
	state := NormalSpeedUpEffectState new.
]

{ #category : #action }
SpeedUpEffect >> reverse [
	state := state reverse.
]

{ #category : #action }
SpeedUpEffect >> triggeredBy: aSpaceship with: aGame [

	state triggeredBy: aSpaceship with: aGame.
]
