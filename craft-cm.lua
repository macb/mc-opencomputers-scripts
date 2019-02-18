local robot = require("robot")
local sides = require("sides")
local component = require("component")

local ic = component.inventory_controller

local cmwalls = "compactmachines3:wallbreakable"

function index_inventory()
  local chest_size = ic.getInventorySize(sides.top)
  local item_index = {}
  for i=1,chest_size do
    item = ic.getStackInSlot(sides.top, i)
    if item then
      item_index[item.name] = i
    end
  end
  return item_index
end

function craft_wall()
  item_index = index_inventory()
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
  ic.dropIntoSlot(sides.down, 1)
  return true
end

function index_robot_inventory()
  local chest_size = robot.inventorySize()
  local item_index = {}
  for i=1,chest_size do
    item = ic.getStackInInternalSlot(i)
    if item then
      item_index[item.name] = i
    end
  end
  return item_index
end


function selectMachineWall()
  current_item = ic.getStackInInternalSlot(robot.select())
  if current_item and current_item.name == cmwalls then
    return
  end

  local item_index = index_robot_inventory()
  robot.select(item_index[cmwalls])
end

function placeMachineWall(side)
  selectMachineWall()
  robot.place(side)
end

function placeMiddleSections()
  placeMachineWall()
  robot.back()
  placeMachineWall()
  robot.back()
  placeMachineWall()
  robot.back()
  placeMachineWall()
  robot.back()
  placeMachineWall()

  for i=1,3 do
    robot.up()
    robot.turnAround()
    robot.back()
    robot.back()
    placeMachineWall()
    robot.back()
    robot.back()
    robot.back()
    robot.back()
    placeMachineWall()
  end

  robot.up()
  robot.turnAround()
  robot.back()
  robot.back()
  placeMachineWall()
  robot.back()
  placeMachineWall()
  robot.back()
  placeMachineWall()
  robot.back()
  placeMachineWall()
  robot.back()
  placeMachineWall()

  robot.up()
  robot.turnAround()
  robot.back()
  robot.back()
end

function craft_large_machine()
    item_index = index_inventory()
    ic.suckFromSlot(sides.top, item_index["minecraft:emerald_block"], 1)
    while true do
      if not item_index[cmwalls] then
        break
      end

      moved = ic.suckFromSlot(sides.top, item_index[cmwalls], 64)
      if moved then
        item_index = index_inventory()
      else
        break
      end
    end
    ic.suckFromSlot(sides.top, item_index["minecraft:ender_pearl"], 1)

    robot.forward()
    robot.forward()
    robot.forward()
    robot.forward()
    robot.forward()
    robot.forward()

    robot.turnLeft()
    robot.forward()

    -- back wall
    for i=1,5 do
      placeMachineWall()
      robot.back()
      placeMachineWall()
      robot.back()
      placeMachineWall()
      robot.back()
      placeMachineWall()
      robot.back()
      placeMachineWall()
      robot.up()
      robot.turnAround()
      robot.back()
      robot.back()
    end

    robot.turnRight()
    robot.forward()
    robot.turnLeft()
    robot.down()
    robot.down()
    robot.down()
    robot.down()
    robot.down()

    placeMiddleSections()

    robot.turnLeft()
    robot.forward()
    robot.turnRight()
    robot.down()
    robot.down()
    robot.down()
    robot.down()
    robot.down()

    placeMiddleSections()

    robot.turnRight()
    robot.forward()
    robot.turnLeft()
    robot.down()
    robot.down()
    robot.down()
    robot.down()
    robot.down()

    placeMiddleSections()

    robot.turnLeft()
    robot.forward()
    robot.turnRight()
    robot.down()
    robot.down()
    robot.down()
    robot.down()
    robot.down()

    for i=1,5 do
      placeMachineWall()
      robot.back()
      placeMachineWall()
      robot.back()
      placeMachineWall()
      robot.back()
      placeMachineWall()
      robot.back()
      placeMachineWall()
      robot.up()
      robot.turnAround()
      robot.back()
      robot.back()
    end

    robot.back()
    robot.turnLeft()
    robot.back()
    robot.down()
    robot.down()
    robot.down()
    robot.down()

    robot.swing()
    robot.forward()
    robot.forward()
    placeMachineWall()
    robot.up()

    robot_inventory = index_robot_inventory()
    robot.select(robot_inventory["minecraft:emerald_block"])
    robot.place()

    robot.down()
    robot.swing()
    robot.back()
    robot.back()
    placeMachineWall()

    robot.down()

    -- Finishing up
    robot_inventory = index_robot_inventory()
    robot.select(robot_inventory["minecraft:ender_pearl"])
    robot.drop()
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
    ic.dropIntoSlot(sides.down, 1)
    return true
end

while true do
  print("Checking chest for items.")
  local item_index = index_inventory()
  if item_index["minecraft:iron_block"] then
    print("Found an iron block, making compact machine walls.")
    done = craft_wall()
    if done then
      print("Finished crafting walls.")
    end
  elseif item_index["minecraft:emerald_block"] then
    print("Found an emerald block, making a large compact machine.")
    done = craft_large_machine()
    if done then
      print("Finished crafting large compact machine.")
    end
  else
    print("No items found, sleeping.")
    os.sleep(1)
  end
end
