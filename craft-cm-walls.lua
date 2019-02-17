local robot = require("robot")
local sides = require("sides")
local component = require("component")

local ic = component.inventory_controller

while true do
  print("Checking chest for items.")
  chest_size = ic.getInventorySize(sides.top)
  item_index = {}
  found = false
  for i=1,chest_size do
    item = ic.getStackInSlot(sides.top, i)
    if item then
      found = true
      item_index[item.name] = i
    else
      break
    end
  end

  if item_index["minecraft:iron_block"] then
    print("Found an iron block, making compact machine walls.")
    robot.select(1)
    ic.suckFromSlot(sides.top, item_index["minecraft:iron_block"], 1)
    robot.select(2)
    ic.suckFromSlot(sides.top, item_index["minecraft:redstone"], 2)

    robot.forward()
    robot.forward()
    robot.forward()
    robot.select(1)
    robot.place()
    robot.up()
    robot.select(2)
    robot.place()
    robot.down()
    robot.back()
    robot.back()
    robot.back()
    robot.drop(1)
    robot.back()

    os.sleep(1)

    robot.forward()
    robot.forward()
    robot.forward()
    while true do
      robot.select(1)
      done = robot.suck()
      if done then
        break
      end
    end
    robot.back()
    robot.back()
    robot.back()
    ic.dropIntoSlot(sides.top, 10)
  else
    print("No items found, sleeping.")
    os.sleep(1)
  end
end
