local SLOTS = 16
local x
local y
local z
DROPPED_ITEMS = {"minecraft:cobblestone", "minecraft:gravel", "minecraft:flint", "minecraft:stone", "minecraft:dirt",
                 "minecraft:redstone"}
function manageInv()
    turtle.select(1)
    for slot = 1, SLOTS, 1 do
        turtle.select(slot)
        local item = turtle.getItemDetail(slot)
        if (item["name"] ~= nil) then

            for filterIndex = 1, #DROPPED_ITEMS, 1 do
                if item["name"] == DROPPED_ITEMS[filterIndex] then
                    print(string.format("Dropping %s", DROPPED_ITEMS[filterIndex]))
                    turtle.dropDown()
                end
            end
        end
    end
end

function turnAntiClockWise()
    turtle.turnLeft()
    detectAndDig()
    turtle.forward()
    turtle.turnLeft()
end

function turnClockwise()
    turtle.turnRight()
    detectAndDig()
    turtle.forward()
    turtle.turnRight()
end

function increaseZ(n)
    if (n > 3) then

        local x = 0
        for i = 1, n - 3, 1 do
            turtle.up()
            turtle.digUp()
            x = x + 1
        end
        for i = 1, x, 1 do
            turtle.down()
        end
    else
        return
    end
end

function detectAndDig()
    while (turtle.detect()) do
        turtle.dig()
        turtle.digUp()
        turtle.digDown()
    end
end
function movementPath(n)
    mineNBlockForward(n)
    if (turtle.detectUp()) then
        turtle.digUp()
    end
    increaseZ(z)
    for i = 1, n - 1, 1 do
        if (i % 2 == 1) then
            turnAntiClockWise()
        else
            turnClockwise()
        end
        mineNBlockForward(n - 1)
    end
    manageInv()
end
--doesnt work for not equal parameters
function movementPathNotEqual(n, m)
    mineNBlockForwardNotEqual(n, m)
    for i = 1, n - 1, 1 do
        if (i % 2 == 1) then
            turnAntiClockWise()
        else
            turnClockwise()
        end
        mineNBlockForward(n - 1)
    end
    manageInv()
end
function mineNBlockForwardNotEqual(n, m) 
    for i = 1, n, 1 do
        detectAndDig()
        turtle.forward()
    end
end
function mineNBlockForward(n)
    for i = 1, n, 1 do
        detectAndDig()
        increaseZ(z)
        turtle.forward()
    end
end
function refuelTurtle()
    turtle.select(1)
    if (turtle.getFuelLevel() < 50) then
        print("Attempting refuel...")
        for slot = 1, SLOTS, 1 do
            turtle.select(slot)
            if (turtle.refuel(1)) then
                return true
            end
        end
        print("Failed to refuel...")
        return false
    else
        return true
    end
end
function start()
    print("\nEnter the x: ")
    x = tonumber(read())
    print("\nEnter the y: ")
    y = tonumber(read())
    print("\nEnter the z: ")
    z = tonumber(read())
    print(string.format("Mining %dx%d", x, y))

    if (not refuelTurtle()) then
        print("No more fuel, powering down...")
        return
    end
    if (x == y) then
        movementPath(x)
    else
        movementPathNotEqual(x, y)
    end
end

start()
