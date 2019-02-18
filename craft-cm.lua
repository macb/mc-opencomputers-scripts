local robot = require("robot")
local sides = require("sides")
local component = require("component")

local ic = component.inventory_controller

local cmwalls = "compactmachines3:wallbreakable"

local function craft_wall()
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
    return true
end

local function index_robot_inventory()
  local chest_size = robot.inventorySize()
  local item_index = {}
  for i=1,chest_size do
    item = ic.getStackInInternalSlot(i)
    if item then
      item_index[item.name] = i
    else
      break
    end
  end
  return item_index
end


local function selectMachineWall()
  if ic.getStackInInternalSlot(robot.select()).name == cmwalls then
    return
  end

  local item_index = index_robot_inventory()
  robot.select(item_index[cmwalls])
end

local function placeMachineWall(side)
  selectMachineWall()
  robot.place(side)
end

local function craft_large_machine()
    item_index = index_inventory()
    ic.suckFromSlot(sides.top, item_index["minecraft:emerald_block"], 1)
    while ic.suckFromSlot(sides.top, item_index[cmwalls], 64) do
    end
    ic.suckFromSlot(sides.top, item_index["minecraft:ender_pearl"], 1)

    robot.forward()
    robot.forward()
    robot.forward()
    robot.forward()
    robot.forward()

    robot.turnLeft()
    robot.forward()
    robot.forward()
    robot.turnAround()

    placeMachineWall(sides.left)
    robot.forward()
    placeMachineWall(sides.left)
    robot.forward()
    placeMachineWall(sides.left)
    robot.forward()
    placeMachineWall(sides.left)
    robot.forward()
    placeMachineWall(sides.left)

    robot.turnAround()
    robot.up()

    placeMachineWall(sides.right)
    placeMachineWall(sides.down)
    robot.forward()
    placeMachineWall(sides.back)
    placeMachineWall(sides.right)
    placeMachineWall(sides.down)
    robot.forward()
    placeMachineWall(sides.right)
    placeMachineWall(sides.down)
    robot.forward()
    placeMachineWall(sides.right)
    placeMachineWall(sides.down)
    robot.forward()
    placeMachineWall(sides.right)
    placeMachineWall(sides.down)
    
    robot.turnAround()
    robot.up()

    placeMachineWall(sides.left)
    robot.forward()
    placeMachineWall(sides.back)
    placeMachineWall(sides.left)
    robot.forward()
    placeMachineWall(sides.left)
    robot.forward()
    placeMachineWall(sides.left)
    robot.forward()
    placeMachineWall(sides.left)

    robot.turnAround()
    robot.up()

    placeMachineWall(sides.up)
    placeMachineWall(sides.right)
    robot.forward()
    placeMachineWall(sides.up)
    placeMachineWall(sides.back)
    placeMachineWall(sides.right)
    robot.forward
    placeMachineWall(sides.up)
    placeMachineWall(sides.right)
    robot.forward()
    placeMachineWall(sides.up)
    placeMachineWall(sides.right)
    robot.forward()
    placeMachineWall(sides.up)
    placeMachineWall(sides.right)

    robot.turnAround()
    robot.up()


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
      robot.select(item_index["minecraft:ender_pearl"])
      done = robot.suck()
      if done then
        break
      end
    end
    robot.back()
    robot.back()
    robot.back()
    ic.dropIntoSlot(sides.top, 10)
    return true
end

local function index_inventory()
  local chest_size = ic.getInventorySize(sides.top)
  local item_index = {}
  for i=1,chest_size do
    item = ic.getStackInSlot(sides.top, i)
    if item then
      item_index[item.name] = i
    else
      break
    end
  end
  return item_index
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
