"
jail
"
Class {
	#name : 'Jail',
	#superclass : 'TileEffect',
	#instVars : [
		'maxRollNeeded'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Jail class >> in: aPosition needingMaximumRoll: aValue [

	^ self new initializeJailWith: aPosition needingMaximumRoll: aValue
]

{ #category : 'action' }
Jail >> applyConsequenceTo: allSpaceShips onBoardOfSize: aBoard [

	| aSpaceShip |
	aSpaceShip := allSpaceShips detect: [ :spaceShip |
		              spaceShip currentPosition = tilePosition ].
	aSpaceShip hasToRoll: maxRollNeeded
]

{ #category : 'action' }
Jail >> applyEffectToSpecific: spaceship on: board [

	spaceship hasToRoll: maxRollNeeded
]

{ #category : 'initialization' }
Jail >> initializeJailWith: aPosition needingMaximumRoll: aValue [

	tilePosition := aPosition.
	maxRollNeeded := aValue
]

{ #category : 'validating' }
Jail >> validateCreationIn: boardSize and: maximumRolledNumber [

	super validateCreationIn: boardSize and: maximumRolledNumber.

	maxRollNeeded = maximumRolledNumber ifFalse: [
		Error signal:
			'rhe jail needed number has to be the dice max number possible.' ]
]
