--!strict
--services
--packages
--modules
--types
export type ViewingConditions = {
    adapting_luminance : number,
    background_lstar : number;
    surround : number;
    discounting_illuminant : boolean;
    background_y_to_white_point_y : number;
    aw : number;
    nbb : number;
    ncb : number;
    c : number;
    n_c : number;
    fl : number;
    fl_root : number;
    z : number;
  
    white_point : Vector3;
    rgb_d : Color3; 
}
--constants
local K_WHITE_POINT_D65 = Vector3.new(95.047, 100.0, 108.883)
--remotes
--variables
--references
--local functions
local function lerp(a : number, b : number, alpha : number)
    return a + (b - a)*alpha
end
local function YFromLstar(lstar : number)
    local ke = 8
    if lstar > ke then
        local cube_root = (lstar + 16)/116
        local cube = cube_root*cube_root*cube_root
        return cube*100
    else
        return lstar/(24389/27)*100
    end
end
--class
local viewing_conditions = {}

function viewing_conditions.createDefault() : ViewingConditions

    return {
        adapting_luminance = 11.725676537,
        background_lstar = 50,
        surround = 2,
        discounting_illuminant = false,
        background_y_to_white_point_y = 0.184186503,
        aw = 29.981000900,
        nbb = 1.016919255,
        ncb = 1.016919255,
        c = 0.689999998,
        n_c = 1.00,
        fl = 0.388481468,
        fl_root = 0.789482653,
        z = 1.909169555, 

        white_point = K_WHITE_POINT_D65,
        rgb_d = Color3.fromRGB(1.021177769, 0.986307740, 0.933960497)
    }
end

function viewing_conditions.create(
    const_white_point : Vector3,
    const_adapting_luminance : number,
    const_background_lstar : number,
    const_surround : number,
    const_discounting_illuminant : boolean)
    
    local viewingCondition = viewing_conditions.createDefault()
    local background_lstar_corrected = if const_background_lstar < 30 then 30 else const_background_lstar
    local rgb_w = Vector3.new(
        0.401288 * const_white_point.X + 0.650173 * const_white_point.Y -
          0.051461 * const_white_point.Z,
      -0.250268 * const_white_point.X + 1.204414 * const_white_point.Y +
          0.045854 * const_white_point.Z,
      -0.002079 * const_white_point.X + 0.048952 * const_white_point.Y +
          0.953127 * const_white_point.Z
    )
    local f = 0.8 + (const_surround/10)
    local c = if f > 0.9 then lerp(0.59, 0.69, (f - 0.9)*10) else lerp(0.525, 0.59, (f - 0.8)*10)

    local d = if const_discounting_illuminant == true then 1 else (f*(1 - (1/3.6)*math.exp((-const_adapting_luminance - 42)/92)))
    d = if d > 1 then 1 elseif d < 0 then 0 else d

    local nc = f
    local rgb_d = Vector3.new(
        d*(100/rgb_w.X) + 1 - d,
        d*(100/rgb_w.Y) + 1 - d,
        d*(100/rgb_w.Z) + 1 - d
    )
    
    local k = 1/(5*const_adapting_luminance + 10)
    local k4 = k*k*k*k;
    local k4f = 1 - k4
    local fl = (k4*const_adapting_luminance) + 
                        (0.1*k4f*k4f*math.pow(5*const_adapting_luminance, 1/3))
    local fl_root = math.pow(fl, 0.25)
    local n = YFromLstar(background_lstar_corrected)/const_white_point.Y
    local z = 1.48 + math.sqrt(n)
    local nbb = 0.725/math.pow(n, 0.2)
    local ncb = nbb
    local rgb_a_factors = Vector3.new(
        math.pow(fl*rgb_d.X*rgb_w.X/100, 0.42),
        math.pow(fl*rgb_d.Y*rgb_w.Y/100, 0.42),
        math.pow(fl*rgb_d.Z*rgb_w.Z/100, 0.42)
    )

    local rgb_a = Vector3.new(
        400*rgb_a_factors.X/(rgb_a_factors.X + 27.13),
        400*rgb_a_factors.Y/(rgb_a_factors.Y + 27.13),
        400*rgb_a_factors.Z/(rgb_a_factors.Z + 27.13)
    )

    local aw = (40*rgb_a.X + 20*rgb_a.Y + rgb_a.Z)/ 20 * nbb

    viewingCondition.adapting_luminance = const_adapting_luminance
    viewingCondition.aw = aw
    viewingCondition.background_lstar = background_lstar_corrected
    viewingCondition.background_y_to_white_point_y = n
    viewingCondition.c = c
    viewingCondition.discounting_illuminant = const_discounting_illuminant
    viewingCondition.fl = fl
    viewingCondition.fl_root = fl_root
    viewingCondition.n_c = nc 
    viewingCondition.nbb = nbb 
    viewingCondition.ncb = ncb 
    viewingCondition.rgb_d = Color3.fromRGB(rgb_d.X, rgb_d.Y, rgb_d.Z)
    viewingCondition.surround = const_surround
    viewingCondition.white_point = Vector3.new(const_white_point.X, const_white_point.Y, const_white_point.Z)
    viewingCondition.z = z

    return viewingCondition
end


function viewing_conditions.defaultWithBackgroundLStar(const_background_lstar : number)
    return viewing_conditions.create(K_WHITE_POINT_D65, (200/math.pi*YFromLstar(50)/100), const_background_lstar, 2, false)
end

return viewing_conditions