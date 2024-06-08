local mathutil = require(game.ReplicatedStorage.Shared.Sintesa.MathUtil)

local function round(n : number, r : number)
    return math.round(n/r)*r
end

while wait(0.1) do
    workspace.SpawnLocation.Position = Vector3.new(0,  0, 0)

    local curve = mathutil.cubic(0.05, 0.7, 0.1, 1)

    local interval = 0.01
    for x = 0, 1, interval do
        for i, point in pairs(curve) do
            local px = point[1] --math.round(x)
            local py = point[2]
           -- print(math.round(px/0.05)*0.05, math.round(x/0.05)*0.05)
            if round(px, interval) == round(x, interval) then
                --print(px, py)
                workspace.SpawnLocation.Position = Vector3.new(mathutil.lerp(0, 1, py),  0, mathutil.lerp(0, 1, py))*10
                break
            end
            --task.wait()
        end
        task.wait() 
    end    
end
