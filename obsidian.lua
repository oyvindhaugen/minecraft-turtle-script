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
function mineNBlockForward(n)
    for i = 1, n, 1 do
        detectAndDig()
        turtle.forward()
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
local i = tonumber(read())
movementPath(i)