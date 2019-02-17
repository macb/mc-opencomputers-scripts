# mc-opencomputers-scripts
Some scripts I use for opencomputers


## craft-cm-walls
This script will craft CM walls given a compact machine setup as seen in ![](https://i.imgur.com/a6ASYdf.png).

- A chest above the robot.
- A charger behind it.
- An ME interface attached to the chest with a processing recipe (1 block of iron, 2 redstone = 16 walls).

When it sees a block of iron in the chest it will collect 1 block and 2 redstone from it. It will move forward 3 spots and then place the block of iron, move up 1 block, place the redstone, move down 1 block and back 3 blocks, then toss the other redstone to start the transformation. It will then move in and loot the drop (it will hang forever if it never gets to loot so be sure nothing else collects). Then it moves back and deposits the walls back into the chest above.
