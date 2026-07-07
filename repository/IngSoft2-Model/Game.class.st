"
game
"
Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'board',
		'turnManager',
		'cardsInGame',
		'rewardAsignation',
		'lastCardPlayed',
		'spaceShipMoving',
		'dicesInGameBoard',
		'spaceShips',
		'winnerSystem'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Game class >> onBoard: aBoard
dices: someDices
spaceships: someSpaceShips
rules: aWinnerSystem
turnManager: aTurnManager
rewards: aRewardDistribution [

    ^ self new
        initializeWithBoard: aBoard
        dices: someDices
        spaceships: someSpaceShips
        rules: aWinnerSystem
        turnManager: aTurnManager
        rewards: aRewardDistribution

]

{ #category : 'action' }
Game >> applyRepeatEffectWith: aSpaceship [

	| spaceShip |
	spaceShip := spaceShips detect: [ :each | each = aSpaceship ].
	board applyEffectOfLastTileTo: spaceShip on: self
]

{ #category : 'action' }
Game >> cardsEffectsArePlayed [

	cardsInGame do: [ :card | card applyInstantaneousEffectIn: self ]
]

{ #category : 'accessing' }
Game >> cardsOf: aSpaceShip [

	^ (self spaceShipMatching: aSpaceShip) cardsInHand
]

{ #category : 'accessing' }
Game >> completedLapsBy: aSpaceShip [

	^ (self spaceShipMatching: aSpaceShip) currentLap
]

{ #category : 'accessing' }
Game >> currentFuleOf: aSpaceShip [

	^ (self spaceShipMatching: aSpaceShip) currentFule
]

{ #category : 'action' }
Game >> formsAlianceWith: anotherSpaceShip [

	| spaceShipToTeamUp |
	spaceShipToTeamUp := self spaceShipMatching: anotherSpaceShip.
	spaceShipMoving formAllyWith: spaceShipToTeamUp.
	spaceShipMoving sharesFuelWithAlly
]

{ #category : 'action' }
Game >> getsFreeFromJail: aSpaceship [

(self spaceShipMatching: aSpaceship) leavesJail 
]

{ #category : 'testing' }
Game >> hasActiveCard: cardToCancel [

	(cardsInGame includes: cardToCancel) ifFalse: [
		Error signal: 'That card is not being played' ]
]

{ #category : 'initialization' }
Game >> initializeWithBoard: aBoard dices: someDices spaceships: someSpaceShips rules: aWinnerSystem turnManager: aTurnManager rewards: aRewardDistribution [

	board := aBoard.
	turnManager := aTurnManager.
	dicesInGameBoard := someDices.
	cardsInGame := OrderedCollection new.
	rewardAsignation := aRewardDistribution.
	spaceShips := someSpaceShips.
	winnerSystem := aWinnerSystem.
	winnerSystem withPotentialWinner: spaceShips
]

{ #category : 'action' }
Game >> move: aSpaceShip forwardBy: rolledNumber [

	| totalPosition newPosition |
	totalPosition := aSpaceShip currentPosition + rolledNumber.
	newPosition := board
		               setLapsAndGetNewPositionFrom: totalPosition
		               for: aSpaceShip.
	aSpaceShip moveTo: newPosition consuming: rolledNumber.
	aSpaceShip hasFule
]

{ #category : 'action' }
Game >> move: aSpaceShip with: dices [

	| rolledNumber |
	winnerSystem thereIsAWinner ifTrue: [ ^ self ].


	rolledNumber := self rolledNumberSumOf: dices.
	spaceShipMoving := aSpaceShip.
	(aSpaceShip canMoveWith: rolledNumber) ifFalse: [ ^ self ].
	aSpaceShip leavesJail.
	self
		move: aSpaceShip
		forwardBy: rolledNumber + (self rollAdjustmentFor: aSpaceShip).
	board applySpecialTiletoA: aSpaceShip ofAll: spaceShips.
	self cardsEffectsArePlayed.
	rewardAsignation for: aSpaceShip with: dices
]

{ #category : 'action' }
Game >> playNextTurn [

	| spaceShip |
	spaceShip := turnManager spaceShipWhoseTurnItIsFrom: spaceShips.
	turnManager updateTurn: spaceShips.
	spaceShip verifyCanPlayAgain.
	spaceShip canPlay
		ifTrue: [ self move: spaceShip with: dicesInGameBoard ]
		ifFalse: [
			spaceShip losesTwoRounds.
			spaceShip rechargeFule ]
]

{ #category : 'action' }
Game >> playsInstantaneousCard: aCard [

	aCard canBePlayedIn: self.
	aCard applyInstantaneousEffectIn: self.

	lastCardPlayed := aCard
]

{ #category : 'action' }
Game >> playsPermanentCard: aCard [

	turnManager isAboutToPlay: spaceShipMoving.
	cardsInGame add: aCard.
	lastCardPlayed := aCard
]

{ #category : 'initialization' }
Game >> playsRedoCard: anInicialization targeting: targetSpaceship [

	| newCardToRedo |
	newCardToRedo := lastCardPlayed copy.



	newCardToRedo
		playedBy: anInicialization
		targeting: targetSpaceship
		in: self
]

{ #category : 'accessing' }
Game >> positionOf: aSpaceShip [

	^ (self spaceShipMatching: aSpaceShip) currentPosition
]

{ #category : 'removing' }
Game >> remove: cardToCancel [

	cardsInGame remove: cardToCancel
]

{ #category : 'action' }
Game >> reverseTurnOrderDueToCard [
turnManager reversedOrder 
]

{ #category : 'action' }
Game >> rollAdjustmentFor: aSpaceship [
  ^ cardsInGame sum: [ :card |
        card rollAdjustmentFor: aSpaceship
    ]

]

{ #category : 'action' }
Game >> rollAgainDueToDoubleCard [

| currentSpaceship |
currentSpaceship := turnManager spaceShipWhoseTurnItIsFrom: spaceShips.
self move: currentSpaceship with: dicesInGameBoard 
]

{ #category : 'accessing' }
Game >> rolledNumberSumOf: dices [

	^ (dices collect: [ :dice | dice rolledNumber ]) sum
]

{ #category : 'action' }
Game >> skipNextTurn [

	| spaceShip |
	spaceShip := turnManager spaceShipWhoseTurnItIsFrom: spaceShips.
	turnManager updateTurn: spaceShips.
	spaceShip losesOneRound.
	spaceShip rechargeFule
]

{ #category : 'action' }
Game >> skipTurnDueToCard [

turnManager updateTurn: spaceShips 
]

{ #category : 'accessing' }
Game >> spaceShipMatching: aSpaceShip [

	^ spaceShips detect: [ :each | each = aSpaceShip ]
]

{ #category : 'initialization' }
Game >> with: aSpaceship throws: aCard targeting: aTarget [

	spaceShipMoving := aSpaceship.
	aCard playedBy: aSpaceship targeting: aTarget in: self.
	aSpaceship removeCard: aCard
]
