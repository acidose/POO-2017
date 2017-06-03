!classDefinition: #DistanceTest category: #'Distance-Solution'!
TestCase subclass: #DistanceTest
	instanceVariableNames: 'meters centimeters kilometers oneMeter twoMeters threeMeters fourMeters fiveMeters oneThousandMeters fiveCentimeters oneHundredCentimeters oneKilometer oneCentimeter twoKilometers twoCentimeters threeCentimeters anotherMeter anotherTwoKilometers anotherThreeCentimeters oneFifthMeter twentyCentimeters zeroMeters minusOneKilometer tenMeters fifteenCentimeters'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceTest methodsFor: 'testing' stamp: 'PR 6/1/2017 21:15:05'!
test01CanCreateOneMeter
	| meters oneMeter |
	meters := Unit createMeter.
	oneMeter := Distance createWithValue: 1 withUnit: meters.
	
	self assert: oneMeter amount equals: 1.
	self assert: oneMeter unit equals: meters. ! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 6/1/2017 21:15:17'!
test02CanCreateFiveCentimeters
	| centimeters fiveCentimeters |
	centimeters := Unit createCentimeter.
	fiveCentimeters := Distance createWithValue: 5 withUnit: centimeters.
	
	self assert: fiveCentimeters amount equals: 5.
	self assert: fiveCentimeters unit equals: centimeters. 
! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 6/1/2017 21:15:34'!
test03CanCreateThreeKilometers
	| kilometers threeK |
	kilometers := Unit createKilometer.
	threeK := Distance createWithValue: 3 withUnit: kilometers.
	
	self assert: threeK value equals: 3.
	self assert: threeK unit equals: kilometers. ! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 5/30/2017 01:27:27'!
test04DistanceIsEqualToSameDistance
	self assert: oneMeter = anotherMeter.
	self assert: twoKilometers = anotherTwoKilometers.
	self assert: threeCentimeters = anotherThreeCentimeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 5/30/2017 01:28:21'!
test05DistanceIsEqualToSameDistanceInDifferentUnits
	self assert: oneMeter = oneHundredCentimeters.
	self assert: oneKilometer = oneThousandMeters.
	self assert: twentyCentimeters = oneFifthMeter.! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 5/30/2017 01:34:32'!
test06AddTwoDistancesWithSameUnitCorrectly
	self assert: oneMeter + fourMeters = fiveMeters.
	self assert: twoCentimeters + oneCentimeter = threeCentimeters.
	self assert: oneKilometer + oneKilometer = twoKilometers.! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 5/30/2017 01:36:16'!
test07AddTwoDistancesWithDifferentUnitsCorrectly
	self assert: oneMeter + oneHundredCentimeters = twoMeters.
	self assert: oneThousandMeters + oneKilometer = twoKilometers.! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 5/30/2017 16:53:12'!
test08SubstractTwoDistancesWithSameUnitsCorrectly
	self assert: oneMeter - oneMeter = zeroMeters.
	self assert: threeCentimeters - oneCentimeter = twoCentimeters.
	self assert: oneKilometer - twoKilometers = minusOneKilometer.! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 5/30/2017 16:56:12'!
test09SubstractTwoDistancesWithDifferentUnitsCorrectly
	self assert: oneMeter - oneHundredCentimeters = zeroMeters.
	self assert: oneThousandMeters - twoKilometers = minusOneKilometer.! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 5/30/2017 17:00:51'!
test10MultiplyDistanceByScalarCorrectly
	self assert: oneMeter * 5 = fiveMeters.
	self assert: oneKilometer * -1 = minusOneKilometer.
	self assert: twoCentimeters * 10 = twentyCentimeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 5/30/2017 17:03:35'!
test11MultiplyScalarByDistanceCorrectly
	self assert: 5 * oneMeter= fiveMeters.
	self assert: -1 * oneKilometer = minusOneKilometer.
	self assert: 10 * twoCentimeters = twentyCentimeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 5/30/2017 17:12:48'!
test12DivideDistanceByScalarCorrectly
	self assert: fourMeters / 4 = oneMeter.
	self assert: oneKilometer / -1 = minusOneKilometer.
	self assert: twoCentimeters / (1/10) = twentyCentimeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 5/30/2017 17:17:10'!
test13ADistanceIsGreaterThanAnotherDistanceWithSameUnit
	self assert: oneMeter > zeroMeters.
	self assert: threeCentimeters > oneCentimeter.
	self assert: twoKilometers > minusOneKilometer.! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 5/30/2017 17:19:20'!
test14ADistanceIsGreaterThanAnotherDistanceWithDifferentUnit
	self assert: oneMeter > oneCentimeter.
	self assert: twoKilometers > oneThousandMeters.
	self assert: threeCentimeters > minusOneKilometer.! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 5/30/2017 17:22:41'!
test15ADistanceIsLesserThanAnotherDistanceWithSameUnit
	self assert: zeroMeters < oneMeter.
	self assert: oneCentimeter < threeCentimeters.
	self assert: minusOneKilometer < twoKilometers.! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 5/30/2017 17:21:57'!
test16ADistanceIsLesserThanAnotherDistanceWithDifferentUnit
	self assert: oneCentimeter < oneMeter.
	self assert: oneThousandMeters < twoKilometers.
	self assert: minusOneKilometer < threeCentimeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 5/30/2017 18:55:12'!
test17CanIterateIntervalBetweenTwoDistances
	| aDistanceInterval sum |
	aDistanceInterval := oneMeter to: fourMeters.

	sum := zeroMeters.
	aDistanceInterval do: [ :aDistance | sum := sum + aDistance ].
	
	self assert: sum = tenMeters.
	
	! !


!DistanceTest methodsFor: 'initialization' stamp: 'PR 6/1/2017 20:30:52'!
setUp
	meters := Unit createMeter.
	centimeters := Unit createCentimeter.
	kilometers := Unit createKilometer.
	
	oneFifthMeter := Distance createWithValue: 1/5 withUnit: meters. 
	zeroMeters := Distance createWithValue: 0 withUnit: meters.
	oneMeter := Distance createWithValue: 1 withUnit: meters.
	anotherMeter := Distance createWithValue: 1 withUnit: meters.
	twoMeters := Distance createWithValue: 2 withUnit: meters.
	threeMeters := Distance createWithValue: 3 withUnit: meters.
	fourMeters := Distance createWithValue: 4 withUnit: meters.
	fiveMeters := Distance createWithValue: 5 withUnit: meters.
	tenMeters := Distance createWithValue: 10 withUnit: meters. 
	oneThousandMeters := Distance createWithValue: 1000 withUnit: meters. 
	
	oneCentimeter := Distance createWithValue: 1 withUnit: centimeters.
	twoCentimeters := Distance createWithValue: 2 withUnit: centimeters.
	threeCentimeters := Distance createWithValue: 3 withUnit: centimeters.
	anotherThreeCentimeters := Distance createWithValue: 3 withUnit: centimeters.
	fifteenCentimeters := Distance createWithValue: 15 withUnit: centimeters. 
	twentyCentimeters := Distance createWithValue: 20 withUnit: centimeters. 
	oneHundredCentimeters := Distance createWithValue: 100 withUnit: centimeters.
	
	minusOneKilometer := Distance createWithValue: -1 withUnit: kilometers.
	oneKilometer := Distance createWithValue: 1 withUnit: kilometers.
	twoKilometers := Distance createWithValue: 2 withUnit: kilometers.
	anotherTwoKilometers := Distance createWithValue: 2 withUnit: kilometers. 
	 ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DistanceTest class' category: #'Distance-Solution'!
DistanceTest class
	instanceVariableNames: 'meters centimeters fiveCentimeters fiveMeters fourMeters kilometers oneHundredCentimeters oneKilometer oneMeter oneThousandMeters threeMeters twoMeters'!


!classDefinition: #Distance category: #'Distance-Solution'!
Object subclass: #Distance
	instanceVariableNames: 'unit amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Distance methodsFor: 'intervals' stamp: 'PR 5/30/2017 17:47:25'!
to: aDistance 
	^DistanceInterval from: self to: aDistance.! !

!Distance methodsFor: 'intervals' stamp: 'PR 5/30/2017 18:17:01'!
to: aDistance by: aDistance2 
	^DistanceInterval from: self to: aDistance by: aDistance2.! !


!Distance methodsFor: 'arithmetic' stamp: 'PR 5/30/2017 17:02:52'!
* aSmallInteger 
	^Distance createWithValue: value*aSmallInteger withUnit: self unit.! !

!Distance methodsFor: 'arithmetic' stamp: 'PR 6/1/2017 21:14:05'!
+ aDistance 
	^Distance createWithValue: ((amount*unit ratio) + (aDistance amount*aDistance unit ratio))/ unit ratio withUnit: self unit. ! !

!Distance methodsFor: 'arithmetic' stamp: 'PR 6/1/2017 21:14:11'!
- aDistance 
	^Distance createWithValue: ((amount*unit ratio) - (aDistance amount*aDistance unit ratio))/ unit ratio withUnit: self unit. ! !

!Distance methodsFor: 'arithmetic' stamp: 'PR 5/30/2017 17:14:26'!
/ aSmallInteger 
	^Distance createWithValue: value/aSmallInteger withUnit: unit. ! !


!Distance methodsFor: 'comparing' stamp: 'PR 6/1/2017 21:14:16'!
< aDistance 
	^ (amount * unit ratio) < (aDistance amount * aDistance unit ratio).! !

!Distance methodsFor: 'comparing' stamp: 'PR 6/1/2017 21:14:21'!
= aDistance
	^(amount*unit ratio) = (aDistance amount * aDistance unit ratio).! !

!Distance methodsFor: 'comparing' stamp: 'PR 6/1/2017 21:14:31'!
> aDistance 
	^(amount*unit ratio) > (aDistance amount*aDistance unit ratio).! !


!Distance methodsFor: 'converting' stamp: 'PR 5/30/2017 17:04:10'!
adaptToNumber: aSmallInteger andSend: aSymbol 
	^self perform: aSymbol with: aSmallInteger.! !


!Distance methodsFor: 'initialization' stamp: 'PR 6/1/2017 23:01:27'!
printString
	| distanceAsString |
	distanceAsString := amount printString, ' ',unit printString.
	
	(amount > 1) ifTrue: [distanceAsString := distanceAsString, 's'].
	
	^distanceAsString.! !

!Distance methodsFor: 'initialization' stamp: 'PR 6/1/2017 21:20:53'!
withAmount: anAmount withUnit: aUnit
	amount := anAmount.
	unit := aUnit.! !


!Distance methodsFor: 'inspecting' stamp: 'PR 6/1/2017 21:12:13'!
amount
	^amount.! !

!Distance methodsFor: 'inspecting' stamp: 'PR 5/29/2017 21:03:25'!
unit
	^unit.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distance class' category: #'Distance-Solution'!
Distance class
	instanceVariableNames: 'unit value'!

!Distance class methodsFor: 'as yet unclassified' stamp: 'PR 6/1/2017 21:22:09'!
createWithValue: anAmount withUnit: aUnit
	^self new withAmount: anAmount withUnit: aUnit.! !


!classDefinition: #DistanceFactory category: #'Distance-Solution'!
Object subclass: #DistanceFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/1/2017 20:23:13'!
centimeter
	^Unit createCentimeter.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/1/2017 20:26:51'!
decameter
	^Unit createDecameter.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/1/2017 20:27:03'!
decimeter
	^Unit createDecimeter.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/1/2017 20:27:39'!
hectometer
	^Unit createHectometer.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/1/2017 20:27:58'!
kilometer
	^Unit createKilometer.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/1/2017 20:24:17'!
meter
	^Unit createMeter.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/1/2017 20:27:47'!
milimeter
	^Unit createMilimeter.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/1/2017 20:30:39'!
minusOneMeter
	^Distance createWithValue: -1 withUnit: Unit createMeter.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/1/2017 20:42:53'!
oneCentimeter 
	^Distance createWithValue: 1 withUnit: Unit createCentimeter.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/1/2017 20:42:58'!
oneHundredCentimeters 
	^Distance createWithValue: 100 withUnit: Unit createCentimeter.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/1/2017 20:30:44'!
oneMeter
	^Distance createWithValue: 1 withUnit: Unit createMeter.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/1/2017 20:43:01'!
twoHundredCentimeters
	^Distance createWithValue: 200 withUnit: Unit createCentimeter.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/1/2017 20:30:47'!
twoMeters
	^Distance createWithValue: 2 withUnit: Unit createMeter.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/1/2017 20:30:49'!
zeroMeters
	^Distance createWithValue: 0 withUnit: Unit createMeter.! !


!classDefinition: #DistanceInterval category: #'Distance-Solution'!
Object subclass: #DistanceInterval
	instanceVariableNames: 'interval unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceInterval methodsFor: 'accessing' stamp: 'PR 5/30/2017 18:28:03'!
at: anIndex
	^Distance createWithValue: (interval at: anIndex) withUnit: unit.! !


!DistanceInterval methodsFor: 'enumerating' stamp: 'PR 5/30/2017 18:31:22'!
do: aBlockClosure 
	1 to: interval size do: [ :i |
		aBlockClosure value: (self at:i )] ! !


!DistanceInterval methodsFor: 'initialization' stamp: 'PR 5/30/2017 17:49:20'!
withInterval: anInterval withUnit: anUnit 
	interval := anInterval.
	unit := anUnit.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DistanceInterval class' category: #'Distance-Solution'!
DistanceInterval class
	instanceVariableNames: ''!

!DistanceInterval class methodsFor: 'as yet unclassified' stamp: 'PR 6/1/2017 21:12:48'!
from: aDistance to: anotherDistance 
	^self new withInterval: (Interval from: aDistance amount to: anotherDistance amount) withUnit: aDistance unit.! !

!DistanceInterval class methodsFor: 'as yet unclassified' stamp: 'PR 6/1/2017 21:14:56'!
from: aDistance to: aDistance2 by: aDistance3 
	| anInterval |
	anInterval := (aDistance amount*aDistance unit ratio) to: (aDistance2 amount*aDistance2 unit ratio) by: (aDistance3 amount*aDistance3 unit ratio).
	
	^self new withInterval: anInterval withUnit: aDistance3 unit.! !


!classDefinition: #Unit category: #'Distance-Solution'!
Object subclass: #Unit
	instanceVariableNames: 'rate name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Unit methodsFor: 'inspecting' stamp: 'PR 6/1/2017 23:08:46'!
= anObject
	(anObject isKindOf: self class) ifFalse: [^False].
	
	^(self ratio = anObject ratio) and: [self name = anObject name].! !

!Unit methodsFor: 'inspecting' stamp: 'PR 6/1/2017 20:40:53'!
printString
	^name.! !

!Unit methodsFor: 'inspecting' stamp: 'PR 6/1/2017 20:40:48'!
ratio
	^rate.! !


!Unit methodsFor: 'initialization' stamp: 'PR 6/1/2017 20:40:33'!
initializeWithConvertionRate: aConvertionRate withName: aName.
	rate := aConvertionRate.
	name := aName.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Unit class' category: #'Distance-Solution'!
Unit class
	instanceVariableNames: 'ratio'!

!Unit class methodsFor: 'creation' stamp: 'PR 6/1/2017 21:07:27'!
createCentimeter
	^self newConvertionRate:1/100 named: 'centimeter'.! !

!Unit class methodsFor: 'creation' stamp: 'PR 6/1/2017 20:41:41'!
createDecameter
	^self newConvertionRate:10 named: 'decameter'.! !

!Unit class methodsFor: 'creation' stamp: 'PR 6/1/2017 20:41:50'!
createDecimeter
	^self newConvertionRate:1/10 named: 'decimeter'.! !

!Unit class methodsFor: 'creation' stamp: 'PR 6/1/2017 20:42:01'!
createHectometer
	^self newConvertionRate:100 named: 'hectometer'.! !

!Unit class methodsFor: 'creation' stamp: 'PR 6/1/2017 20:42:10'!
createKilometer
	^self newConvertionRate:1000 named: 'kilometer'.! !

!Unit class methodsFor: 'creation' stamp: 'PR 6/1/2017 20:42:20'!
createMeter
	^self newConvertionRate:1 named: 'meter'.! !

!Unit class methodsFor: 'creation' stamp: 'PR 6/1/2017 20:42:33'!
createMilimeter
	^self newConvertionRate:1/1000 named: 'milimeter'.! !

!Unit class methodsFor: 'creation' stamp: 'PR 6/1/2017 20:39:52'!
newConvertionRate: aConvertionRate named: aName.

	^self new initializeWithConvertionRate: aConvertionRate withName: aName.! !
