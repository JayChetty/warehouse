## Overview
ItemFinder(item_finder.rb) instances provide an interface to load, search, find distances and locations of it's items.
The behaviour can be tailored using the strategy design pattern, to configure the keys to the locations,  the distance calculation and path finding algorithm.
By default keys are the index location the array,  distance calculation is difference in index number between first and last location, collections paths are the sorted order of the locations. 

Example in spec/integration_test satisfying the warehouse picker spec shown below. Here an ItemFinder is instantiated with a translator using the key mapping [a10..a1,c1..c10,b1..b10], and continues to use the default linear distance calculation and linear path finding.


### Warehouse Picker
We need an application to handle the picking of items from a warehouse distribution centre.

Our warehouse has three rows of racking (racks 'a, 'b', and 'c') located around a central loading bay where the fork-lift trucks maneuver - no pedestrians allowed!

Each row of racking has ten bays (numbered 1 to 10). The racks are arranged in a "U" shape, with the warehouse-pickers' entrance to the warehouse by rack 'a', bay '10', and the exit by rack 'b', bay '10'.

Here's an ASCII-art illustration to help visualize (but you must've been to a Scandinavian furniture store... you know how it looks):

```
>     c1 c2 c3 c4 c5 c6 c7 c8 c9 c10
>
> a1    __________________________   b1
> a2   |                         |   b2
> a3   |                         |   b3
> a4   | Loading bay...          |   b4
> a5   |                         |   b5
> a6   |                         |   b6
> a7   | Can't walk here.        |   b7
> a8   |                         |   b8
> a9   |                         |   b9
> a10  |                         |   b10
>
> >> entrance                     >> exit
```