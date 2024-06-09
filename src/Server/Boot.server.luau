local MathUtil = require(game.ReplicatedStorage.Shared.Sintesa.Utils.MathUtil)

local function round(n : number, r : number)
    return math.round(n/r)*r
end

while wait(0.1) do
    workspace.SpawnLocation.Position = Vector3.new(0,  0, 0)

    local curve = MathUtil.generateBezierFromPoints({{0,0}, {0.05, 0}, {0.133333, 0.06}, {0.16666, 0.4}, {0.2083333, 0.82}, {0.25, 1}, {1,1}})

    local interval = 0.01
    for x = 0, 1, interval do
        local y = curve:GetInterpolator(x)
        
        workspace.SpawnLocation.Position = Vector3.new(MathUtil.lerp(0, -10, y),  0, MathUtil.lerp(0, -10, y))
        task.wait() 
    end    
end
