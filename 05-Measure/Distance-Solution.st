!classDefinition: #Distance category: #'Distance-Solution'!
Magnitude subclass: #Distance
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


!Distance methodsFor: 'arithmetic' stamp: 'PR 6/3/2017 20:27:15'!
* aSmallInteger 
	^Distance createWithValue: amount*aSmallInteger withUnit: self unit.! !

!Distance methodsFor: 'arithmetic' stamp: 'PR 6/1/2017 21:14:05'!
+ aDistance 
	^Distance createWithValue: ((amount*unit ratio) + (aDistance amount*aDistance unit ratio))/ unit ratio withUnit: self unit. ! !

!Distance methodsFor: 'arithmetic' stamp: 'PR 6/1/2017 21:14:11'!
- aDistance 
	^Distance createWithValue: ((amount*unit ratio) - (aDistance amount*aDistance unit ratio))/ unit ratio withUnit: self unit. ! !

!Distance methodsFor: 'arithmetic' stamp: 'PR 6/3/2017 20:27:21'!
/ aSmallInteger 
	^Distance createWithValue: amount/aSmallInteger withUnit: unit. ! !


!Distance methodsFor: 'comparing' stamp: 'PR 6/1/2017 21:14:16'!
< aDistance 
	^ (amount * unit ratio) < (aDistance amount * aDistance unit ratio).! !

!Distance methodsFor: 'comparing' stamp: 'PR 6/1/2017 21:14:21'!
= aDistance
	^(amount*unit ratio) = (aDistance amount * aDistance unit ratio).! !


!Distance methodsFor: 'converting' stamp: 'PR 5/30/2017 17:04:10'!
adaptToNumber: aSmallInteger andSend: aSymbol 
	^self perform: aSymbol with: aSmallInteger.! !

!Distance methodsFor: 'converting' stamp: 'PR 6/3/2017 20:42:47'!
convertTo: anUnit
	^Distance createWithValue:  (amount * unit ratio) / anUnit ratio withUnit: anUnit. ! !


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

!Distance methodsFor: 'inspecting' stamp: 'PR 6/3/2017 20:46:55'!
lesserUnit: aDistance 
(self unit ratio < aDistance unit ratio)ifTrue: [^self unit ] ifFalse: [^aDistance unit ]. ! !

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


!classDefinition: #DistanceTest category: #'Distance-Solution'!
TestCase subclass: #DistanceTest
	instanceVariableNames: 'factory'
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

!DistanceTest methodsFor: 'testing' stamp: 'PR 6/3/2017 20:28:41'!
test03CanCreateThreeKilometers
	| kilometers threeK |
	kilometers := Unit createKilometer.
	threeK := Distance createWithValue: 3 withUnit: kilometers.
	
	self assert: threeK amount equals: 3.
	self assert: threeK unit equals: kilometers. ! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 6/3/2017 21:48:11'!
test04DistanceIsEqualToSameDistance
	| anotherMeter anotherTwoKilometers anotherThreeCentimeters |
	
	anotherMeter := factory oneMeter copy.
	anotherTwoKilometers := factory twoKilometers copy.
	anotherThreeCentimeters := factory threeCentimeters copy.
	
	self assert: factory oneMeter = anotherMeter.
	self assert: factory twoKilometers = anotherTwoKilometers.
	self assert: factory threeCentimeters = anotherThreeCentimeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 6/3/2017 21:59:45'!
test05DistanceIsEqualToSameDistanceInDifferentUnits
	self assert: factory oneMeter = factory oneHundredCentimeters.
	self assert: factory oneKilometer = factory oneThousandMeters.
	self assert: factory twentyCentimeters = factory oneFifthMeter.! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 6/3/2017 22:01:44'!
test06AddTwoDistancesWithSameUnitCorrectly
	self assert: factory oneMeter + factory fourMeters = factory fiveMeters.
	self assert: factory twoCentimeters + factory oneCentimeter = factory threeCentimeters.
	self assert: factory oneKilometer + factory oneKilometer = factory twoKilometers.! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 6/3/2017 22:03:04'!
test07AddTwoDistancesWithDifferentUnitsCorrectly
	self assert: factory oneMeter + factory oneHundredCentimeters = factory twoMeters.
	self assert: factory oneThousandMeters + factory oneKilometer = factory twoKilometers.! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 6/3/2017 22:03:36'!
test08SubstractTwoDistancesWithSameUnitsCorrectly
	self assert: factory oneMeter - factory oneMeter = factory zeroMeters.
	self assert: factory threeCentimeters - factory oneCentimeter = factory twoCentimeters.
	self assert: factory oneKilometer - factory twoKilometers = factory minusOneKilometer.! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 6/3/2017 22:04:27'!
test09SubstractTwoDistancesWithDifferentUnitsCorrectly
	self assert: factory oneMeter - factory oneHundredCentimeters = factory zeroMeters.
	self assert: factory oneThousandMeters - factory twoKilometers = factory minusOneKilometer.! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 6/3/2017 22:05:09'!
test10MultiplyDistanceByScalarCorrectly
	self assert: factory oneMeter * 5 = factory fiveMeters.
	self assert: factory oneKilometer * -1 = factory minusOneKilometer.
	self assert: factory twoCentimeters * 10 = factory twentyCentimeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 6/3/2017 22:05:23'!
test11MultiplyScalarByDistanceCorrectly
	self assert: 5 * factory oneMeter= factory fiveMeters.
	self assert: -1 * factory oneKilometer = factory minusOneKilometer.
	self assert: 10 * factory twoCentimeters = factory twentyCentimeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 6/3/2017 22:05:37'!
test12DivideDistanceByScalarCorrectly
	self assert: factory fourMeters / 4 = factory oneMeter.
	self assert: factory oneKilometer / -1 = factory minusOneKilometer.
	self assert: factory twoCentimeters / (1/10) = factory twentyCentimeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 6/3/2017 22:05:49'!
test13ADistanceIsGreaterThanAnotherDistanceWithSameUnit
	self assert: factory oneMeter > factory zeroMeters.
	self assert: factory threeCentimeters > factory oneCentimeter.
	self assert: factory twoKilometers > factory minusOneKilometer.! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 6/3/2017 22:06:02'!
test14ADistanceIsGreaterThanAnotherDistanceWithDifferentUnit
	self assert: factory oneMeter > factory oneCentimeter.
	self assert: factory twoKilometers > factory oneThousandMeters.
	self assert: factory threeCentimeters > factory minusOneKilometer.! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 6/3/2017 22:06:16'!
test15ADistanceIsLesserThanAnotherDistanceWithSameUnit
	self assert: factory zeroMeters < factory oneMeter.
	self assert: factory oneCentimeter < factory threeCentimeters.
	self assert: factory minusOneKilometer < factory twoKilometers.! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 6/3/2017 22:06:28'!
test16ADistanceIsLesserThanAnotherDistanceWithDifferentUnit
	self assert: factory oneCentimeter < factory oneMeter.
	self assert: factory oneThousandMeters < factory twoKilometers.
	self assert: factory minusOneKilometer < factory threeCentimeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 6/3/2017 22:06:56'!
test17CanIterateIntervalBetweenTwoDistances
	| aDistanceInterval sum |
	aDistanceInterval := factory oneMeter to: factory fourMeters.

	sum := factory zeroMeters.
	aDistanceInterval do: [ :aDistance | sum := sum + aDistance ].
	
	self assert: sum = factory tenMeters.
	
	! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 6/3/2017 22:15:55'!
test18CanDoItIntervalBetweenTwoDistancesWithIdentiqueUnit
	| aDistanceInterval aDistanceIntervalComparate |
	
	aDistanceInterval := factory oneMeter to: factory fourMeters.
	aDistanceIntervalComparate := Interval from: 1 to: 4. 

	
	self assert: aDistanceIntervalComparate = aDistanceInterval interval .
	self assert: factory meter = aDistanceInterval  unit .
	
	! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 6/3/2017 22:16:49'!
test19CanDoItIntervalBetweenTwoDistancesWithDifferentUnit
    | aDistanceInterval aDistanceIntervalOneCentimeterToOneMeter intervalComparate intervalComparateOneCentimetersToOneMeter|
    
    aDistanceInterval := factory oneMeter to: factory oneKilometer .
    aDistanceIntervalOneCentimeterToOneMeter := factory oneCentimeter to: factory oneMeter.
    
    intervalComparate := Interval from: 1 to: 1000.
    
    intervalComparateOneCentimetersToOneMeter  := Interval from: 1 to: 100. 
         
    self assert: intervalComparate = aDistanceInterval interval.
    self assert: factory meter = aDistanceInterval unit. 
    self assert: intervalComparateOneCentimetersToOneMeter = aDistanceIntervalOneCentimeterToOneMeter interval.
    self assert: factory centimeter = aDistanceIntervalOneCentimeterToOneMeter unit.
	! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 6/3/2017 22:17:11'!
test20CanDoItIntervalNegativeBetweenTwoDistances
    | aDistanceIntervalOneKilometerToOneMeter aDistanceIntervalOneCentimeterToOneMeter intervalComparate intervalComparateOneCentimetersToOneMeter|
    
    aDistanceIntervalOneKilometerToOneMeter := factory oneKilometer to: factory oneMeter .
    aDistanceIntervalOneCentimeterToOneMeter := factory oneMeter to: factory oneCentimeter .
    
    intervalComparate := Interval from: 1000 to: 1.
    
    intervalComparateOneCentimetersToOneMeter  := Interval from: 100 to: 1. 
         
    self assert: intervalComparate = aDistanceIntervalOneKilometerToOneMeter interval.
    self assert: factory meter = aDistanceIntervalOneKilometerToOneMeter unit.
     
    self assert: intervalComparateOneCentimetersToOneMeter = aDistanceIntervalOneCentimeterToOneMeter interval.
    self assert: factory centimeter = aDistanceIntervalOneCentimeterToOneMeter unit.
	! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 6/3/2017 22:17:34'!
test21CanDoItIntervalWithStepAsParameterSmallestUnit
    | aDistanceIntervalOneKilometerToOneMeter aDistanceIntervalOneCentimeterToOneMeter intervalComparate intervalComparateOneCentimetersToOneMeter|
    
    aDistanceIntervalOneKilometerToOneMeter := factory oneMeter to: factory oneKilometer by: factory oneMeter.
    aDistanceIntervalOneCentimeterToOneMeter := factory oneCentimeter to: factory oneMeter by: factory oneCentimeter.
    
    intervalComparate := Interval from: 1 to: 1000.
    
    intervalComparateOneCentimetersToOneMeter  := Interval from: 1 to: 100. 
         
    self assert: intervalComparate = aDistanceIntervalOneKilometerToOneMeter interval.
    self assert: factory meter = aDistanceIntervalOneKilometerToOneMeter unit.
     
    self assert: intervalComparateOneCentimetersToOneMeter = aDistanceIntervalOneCentimeterToOneMeter interval.
    self assert: factory centimeter = aDistanceIntervalOneCentimeterToOneMeter unit.
! !

!DistanceTest methodsFor: 'testing' stamp: 'PR 6/3/2017 22:18:00'!
test22CanDoItIntervalWithStepAsParameterIntermediateUnit
    | aDistanceIntervalOneKilometerToOneMeter aDistanceIntervalOneCentimeterToOneMeter intervalComparate intervalComparateOneCentimetersToOneMeter |
    
    aDistanceIntervalOneKilometerToOneMeter := factory oneMeter to: factory oneKilometer by: factory oneDecameter .
    aDistanceIntervalOneCentimeterToOneMeter := factory oneCentimeter to: factory oneMeter by: factory oneDecimeter.
    
    intervalComparate := Interval from: 1/10 to: 100 by: 1.
    
    intervalComparateOneCentimetersToOneMeter  := Interval from: 1/10 to: 10 by:1. 
         
    self assert: intervalComparate = aDistanceIntervalOneKilometerToOneMeter interval.
    self assert: factory decameter = aDistanceIntervalOneKilometerToOneMeter unit.
     
    self assert: intervalComparateOneCentimetersToOneMeter = aDistanceIntervalOneCentimeterToOneMeter interval.
    self assert: factory decimeter = aDistanceIntervalOneCentimeterToOneMeter unit.
! !


!DistanceTest methodsFor: 'initialization' stamp: 'PR 6/3/2017 21:39:03'!
setUp
	factory := DistanceFactory new.
		
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
	 
	oneDecimeter := Distance createWithValue: 1 withUnit: decimeter.
	oneDecameter := Distance createWithValue: 1 withUnit: decameter.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DistanceTest class' category: #'Distance-Solution'!
DistanceTest class
	instanceVariableNames: 'meters centimeters fiveCentimeters fiveMeters fourMeters kilometers oneHundredCentimeters oneKilometer oneMeter oneThousandMeters threeMeters twoMeters'!


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

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/3/2017 22:02:29'!
fiveMeters
	^Distance createWithValue: 5 withUnit: Unit createMeter.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/3/2017 22:24:33'!
fourMeters
	^Distance createWithValue: 4 withUnit: Unit createMeter.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/1/2017 20:27:39'!
hectometer
	^Unit createHectometer.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/1/2017 20:27:58'!
kilometer
	^Unit createKilometer.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/3/2017 22:13:26'!
meter
	^Unit createMeter.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/1/2017 20:27:47'!
milimeter
	^Unit createMilimeter.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/3/2017 22:24:43'!
minusOneKilometer
	^Distance createWithValue: -1 withUnit: Unit createKilometer .! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/3/2017 22:24:48'!
minusOneMeter
	^Distance createWithValue: -1 withUnit: Unit createMeter.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/3/2017 22:24:56'!
oneCentimeter 
	^Distance createWithValue: 1 withUnit: Unit createCentimeter .! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/3/2017 22:25:06'!
oneDecameter
	^Distance createWithValue: 1 withUnit: Unit createDecameter.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/3/2017 22:25:18'!
oneDecimeter
	^Distance createWithValue: 1 withUnit: Unit createDecimeter.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/3/2017 22:25:30'!
oneFifthMeter
	^Distance createWithValue: 1/5 withUnit: Unit createMeter.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/3/2017 22:25:39'!
oneHundredCentimeters 
	^Distance createWithValue: 100 withUnit: Unit createCentimeter.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/3/2017 22:25:47'!
oneKilometer
	^Distance createWithValue: 1 withUnit: Unit createKilometer .! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/1/2017 20:30:44'!
oneMeter
	^Distance createWithValue: 1 withUnit: Unit createMeter.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/3/2017 22:28:19'!
oneThousandMeters
	^Distance createWithValue: 1000 withUnit: Unit createMeter. ! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/3/2017 22:07:20'!
tenMeters
	^Distance createWithValue: 10 withUnit: Unit createMeter.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/3/2017 22:28:35'!
threeCentimeters
	^Distance createWithValue: 3 withUnit: Unit createCentimeter .! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/3/2017 22:00:42'!
twentyCentimeters
	^Distance createWithValue: 20 withUnit: Unit createCentimeter .! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/3/2017 22:02:43'!
twoCentimeters
	^Distance createWithValue: 2 withUnit: Unit createCentimeter.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/3/2017 22:27:21'!
twoHundredCentimeters
	^Distance createWithValue: 200 withUnit: Unit createCentimeter.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/3/2017 22:28:41'!
twoKilometers
	^Distance createWithValue: 2 withUnit: Unit createKilometer.! !

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


!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'PR 6/3/2017 20:54:53'!
interval

	^interval ! !

!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'PR 6/3/2017 20:55:08'!
unit

	^unit ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DistanceInterval class' category: #'Distance-Solution'!
DistanceInterval class
	instanceVariableNames: ''!

!DistanceInterval class methodsFor: 'as yet unclassified' stamp: 'PR 6/3/2017 20:50:35'!
from: aDistance to: anotherDistance 

	|smallUnit aDistanceConvert anotherDistanceConvert|

	
	smallUnit := aDistance lesserUnit: anotherDistance .
	aDistanceConvert := aDistance convertTo: smallUnit .
	anotherDistanceConvert := anotherDistance  convertTo: smallUnit .
	
	^self new withInterval: (Interval from: aDistanceConvert amount to: anotherDistanceConvert amount) withUnit: smallUnit.
! !

!DistanceInterval class methodsFor: 'as yet unclassified' stamp: 'PR 6/3/2017 20:53:40'!
from: aDistance to: aDistance2 by: aDistance3 
	
	|aDistanceConvert aDistanceConvert2|
	
	aDistanceConvert := aDistance convertTo: aDistance3 unit .
	aDistanceConvert2 := aDistance2 convertTo: aDistance3 unit .
	
	^self new withInterval: (Interval from: aDistanceConvert amount to: aDistanceConvert2 amount by: aDistance3 amount ) withUnit: aDistance3 unit .
	! !


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
