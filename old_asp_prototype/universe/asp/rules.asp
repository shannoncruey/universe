<html>
<head>
<link rel="stylesheet" href="../script/style_main.css" type="text/css">
</head>

<body>


<font size=+3><b>Rules</b></font>
<hr>
49-3.388 98-5.273

<P> Since this is a work in progress, there are not many rules  yet. However, there are certain restrictions imposed in order to make the game easier to manage and  develop. In no particular order:

<P>
<B>Rules</B>
<p>There are some fixed attributes for objects.  The required attributes will be set when a new object is created.  Examples are Shields and Weapons, all ships have them, it's just the rating that changes.  All objects have an XYZ location in space.  Objects are either Fixed or Mobile.  Fixed objects, (Stars, Planets, etc.) cannot move.  Mobile Objects can.
<p>
If you as a player choose to start out on a fixed location, you cannot move unless you board your ship.  If your ship is destroyed, you lose it.  You can reneter the game with a new basic ship, and there is a finite amount of time for you to reclaim your assets before they become publicly available for claim.
<p>
All players start 
with (1) ship. Players can define  all the details of their home star system, planets, moons, and other assets, within reason. (reason currently defined  as 3 stars (Trinary System), 5 planets, 5 space stations, and a dozen or so smaller objects.)
<p>
What a player&nbsp;does with&nbsp;their&nbsp;assets&nbsp;is entirely up to the player as of now.  As the beta of the game progresses, rules may be changed.
<p>
Transit is based on distance covered in 60 second 
intervals.&nbsp; When you enter transit, you will be given an ETA for your 
destination.&nbsp; At any time, you may stop transit by entering a new destination.&nbsp; (Soon  an "All Stop" command will be added under the Navigation Menu.
<p>
The game allows for the player to come up with whatever race and history that he/she desires.  A URL field is provided to link out to an external web site where you can blather on till the end of time about the great history of your race.  The game database will only store information that is relevant to game play, and frankly, most historical fluff is not.  History is encouraged, however, to add flavor to the game.
<p>
Sensor Logs are recorded when you do a sensor sweep.  Logs are a part of the player inventory, and the logs go with the player as you move from place to place.  Sensor logs can be traded.
<P>
You must be within 50 units of an object to do a trade.
<p>
Each Player has a Score and a level rating.  At the beginning of each level, the score is reset to zero.  As you interact with other players, your score goes up.  (For example, transferring goods to another player increases your score.  So does claiming objects or creating new commodities.)  When your score reaches a certain level, (1000 for now) you are promoted to the next level and your score resets to zero.
<p>
When you do a trade, you must transfer goods to another player.  Since this is a good faith act, the transferer gets a score increase upon transfer, and the transferee gets a score decrease.  When the transferee returns the favor by completing the transaction, his score decrement is cancelled and replaced with a score increase as well.  Therefore it is bad when a player chooses not to honor an agreement.
<P><b>Ideas:</b>
                                                                        
<P>Ships might be allowed to travel on autopilot in the 
future, but if you are not in command of a ship and it is attacked, your current 
skill level does not factor in to the battle equation. 
<P><BR>
                &nbsp;
<BR>
(I am thinking about having two kinds of travel in the typical scifi fashion, sub-light and FTL.  There will be a set distance that you cannot enter FTL transit within, (like the earth to the moon, maybe 1000 units)
<br>
What is the granularity for distance?  maybe 1 unit at sublight = 1 minute, 1 unit at ftl = 1 second?
<br>
Engines 
must be powered by fuel? Maybe,  but how does fuel factor in, and what do you do when you run out? Are  you stranded? Perhaps  you could recharge slowly. OR  perhaps fuel is not needed for sublight travel, but it is for ftl travel, so you could creep home like Voyager for the next 10 years. )
<br>
<br>
There are a few basic 
constants. Acquiring pieces of inventory will increase your capability in one of 
those basic areas. Some rules have to determine how much a user defined piece of 
inventory can increase capability. For example, all starship attributes affect a 
few basic things: mobility, defense, attack, sensors. Everything is based on 
energy. Your level is increased as you build these capabilities. <BR>
                                                                      

<br>
Habitable objects like planets and moons also have basic 
capabilities: Defense, Attack, Sensors, endless geothermal energy. Planets can 
also have abundant natural resources that can be used by factories and such to 
create more useful items. Players who choose to own refineries and factories 
gain experience by selling their stuff.<BR>
                                                   

<br>
(I think I 
will have to come up with some more basic things, like: factories...and then 
figure out what resources they need to produce their product. It looks like I 
have to design a basic economic system.)
<br>
Here's what I have decided to do.  Two tables, (assets and conversions) will control the economy.
There are only three macro types of assets, resources, energy, and converters.
Resources have a value that is a multiplier of the amount that a player has.  Therefore 
if it takes 100 resources to build an engine, then 10 units of platinum (value 10) will suffice 
whereas 20 units of aluminum (5) will be needed.
<br>
Additionally, there is a conversion loss when changing energy to resource or vice-versa.
  Again, platinum has a 1 to 1 ratio, and can be converted to energy with 0% loss.  However,
  Aluminum has a 3 to 1 ratio, meaning that 100 units of aluminum can be converted to 30
  units of energy.
<br>
The third kind of of assets are converters.  They do what you would think, they convert 
energy to resource or vice-versa.  Different classes of converters have different conversion 
times.  The total conversion time is calculated as follows:  the amount to be converted
times the converters conversion time.
  
<br>
The conversions table is a temporary table where users conversions will take place.
When a player initiates a conversion, the server will use this temp table to process the 
conversion until it is finished.  Then the players attributes will be updated.  In actuality,
the conversion happens when the user requests it.  The temp table just holds a timestamp
that specifies when the conversion will be applied.

<br><br>
Collecting resources from fixed objects is the same mechanism as converting.  
You have to be within range, and the collection will take a certain amount of time.
  (The converter that you have
is also used to convert the resource into a transportable format, even if no explicit
conversion is taking place.)
<br>
You cannot leave an object while a conversion is in progress.  If you do, the %
completed will be transferred to your inventory and the transaction will be stopped.
A percentage of your yield will be lost in the disconnect.
 </P></BODY></HTML>
