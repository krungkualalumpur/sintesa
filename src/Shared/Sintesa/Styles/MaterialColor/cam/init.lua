--!strict
--services
--packages
--modules
local viewing_conditions = require(script:WaitForChild("viewing_conditions"))
--types
type ViewingConditions = viewing_conditions.ViewingConditions
export type Cam = {
    hue : number,
    chroma : number,
    j : number,
    q : number,
    m : number,
    s : number,

    jstar : number,
    astar : number,
    bstar : number
}
--constants
--remotes
--variables
--references
--local functions
local function Linearized(rgb_component : number)
    local normalized = rgb_component/255
    if normalized <= 0.040449936 then
        return normalized / 12.92*100
    else
        return math.pow((normalized + 0.055)/1.055, 2.4)*100
    end
end

local function Delinearized(rgb_component : number)
    local normalized = rgb_component/100;
    local delinearized 
    if normalized <= 0.0031308 then
        delinearized = normalized*12.92;
    else
        delinearized = 1.055*math.pow(normalized, 1/2.4) - 0.055
    end

    return math.clamp(math.round(delinearized*255), 0, 255)
end

local function LstarFromY(y : number)
    local e = 216/24389
    local yNormalized = y/100

    if yNormalized <= e then
        return (24389/27)*yNormalized
    else
        return 116*math.pow(yNormalized, 1/3) - 16
    end
end

local function sanitizeDegree(const_degrees : number)
    if const_degrees < 0 then
        return (const_degrees%360) + 360
    elseif const_degrees >= 360 then
        return const_degrees%360
    else
        return const_degrees
    end
end

local function YFromLstar(lstar : number)
    local ke = 8
    if lstar > ke then
        local cube_root = (lstar + 16)/116
        local cube = cube_root*cube_root*cube_root
        return cube
    else
        return lstar/(24389/27)*100
    end
end
local function IntFromLstar(lstar : number)
    local y = YFromLstar(lstar)
    local component = Delinearized(y)
    return Color3.fromRGB(component, component, component)
end

local function SolveToInt(hue_degrees : number, chroma : number, lstar : number)
    if (chroma < 0.0001) or (lstar < 0.0001) or (lstar > 99.9999) then
        return IntFromLstar(lstar)
    end
    hue_degrees = sanitizeDegree(hue_degrees)
    local hue_radians = math.rad(hue_degrees)
    local y = YFromLstar(lstar)

    local exact_answer = FindResultByJ(hue_radians, chroma, y);
    if exact_answer ~= 0 then
        return exact_answer
    end

    local linrgb = BisectToLimit(y, hue_radians)
    return ArgbFromLinrgb(linrgb) 
end

--class
local cam = {}

function cam.create(
    hue : number,
    chroma : number,
    j : number,
    q : number,
    m : number, 
    s : number,

    jstar : number,
    astar : number,
    bstar : number
) : Cam
    local cam = {
        hue = hue,
        chroma = chroma,
        j = j,
        q = q,
        m = m,
        s = s,

        jstar = jstar,
        astar = astar,
        bstar = bstar
    }
    return cam
end

function cam.CamFromUcsAndViewingConditions(jstar : number, astar : number, bstar : number, const_viewing_conditions : ViewingConditions) : Cam
    local a = astar;
    local b = bstar;
    local m = math.sqrt(a*a + b*b);
    local m_2 = (math.exp(m*0.0228) - 1)/0.0228;
    local c = m_2/const_viewing_conditions.fl_root;
    local h = math.atan2(b,a)*(180/math.pi)
    if h < 0 then
        h += 360
    end
    local j = jstar/(1 - (jstar - 100)*0.007)
    return cam.CamFromJchAndViewingConditions(j, c, h, const_viewing_conditions)
end

function cam.CamFromIntAndViewingConditions(Argb : Color3, const_viewing_conditions : ViewingConditions) : Cam
    local red = Argb.R
    local green = Argb.G
    local blue = Argb.B

    local red_l = Linearized(red)
    local green_l = Linearized(green)
    local blue_l = Linearized(blue)
    local x = 0.41233895 * red_l + 0.35762064 * green_l + 0.18051042 * blue_l;  
    local y =  0.2126 * red_l + 0.7152 * green_l + 0.0722 * blue_l;
    local z = 0.01932141 * red_l + 0.11916382 * green_l + 0.95034478 * blue_l;

    -- Convert XYZ to 'cone'/'rgb' responses
    local r_c = 0.401288*x + 0.650173*y - 0.051461*z;
    local g_c  =  -0.250268*x + 1.204414*y + 0.045854*z; 
    local b_c  = -0.002079*x + 0.048952*y + 0.953127*z;

    --discount illuminant
    local r_d = const_viewing_conditions.rgb_d.R*r_c
    local g_d = const_viewing_conditions.rgb_d.G*g_c
    local b_d = const_viewing_conditions.rgb_d.B*b_c

    --chromatic adaptation
    local r_af = math.pow(const_viewing_conditions.fl*math.abs(r_d)/100, 0.42)
    local g_af = math.pow(const_viewing_conditions.fl*math.abs(g_d)/100, 0.42)
    local b_af = math.pow(const_viewing_conditions.fl*math.abs(b_d)/100, 0.42)
    local r_a = math.sign(r_d)*400*r_af/(r_af + 27.13);
    local g_a = math.sign(g_d)*400*g_af/(g_af + 27.13);
    local b_a = math.sign(b_d)*400*b_af/(b_af + 27.13);

    --redness-greenness
    local a = (11*r_a + -12*g_a + b_a)/11
    local b = r_a + g_a - 2*b_a/9
    local u = (20*r_a + 20*g_a + 21*b_a) / 20
    local p2 = (40*r_a + 20*g_a + b_a) / 20

    local radians = math.atan2(b,a)
    local degrees = math.deg(radians)
    local hue = sanitizeDegree(degrees)
    local hue_radians = hue*math.pi/180
    local ac = p2*const_viewing_conditions.nbb;

    local j = 100*math.pow(ac/const_viewing_conditions.aw, 
        const_viewing_conditions.c*const_viewing_conditions.z)

    local q = (4/const_viewing_conditions.c)*math.sqrt(j/100)*(const_viewing_conditions.aw + 4)*const_viewing_conditions.fl_root

    local hue_prime = if hue < 20.14 then hue + 360 else hue
    local e_hue = 0.25*(math.cos(hue_prime*math.pi/180 + 2) + 3.8);
    local p1 = 50000/13 * e_hue * const_viewing_conditions.n_c * const_viewing_conditions.ncb
    local t = p1*math.sqrt(a*a + b*b)/(u + 0.305);
    local alpha = 
        math.pow(t, 0.9) * 
        math.pow(1.64 - math.pow(0.29, const_viewing_conditions.background_y_to_white_point_y), 
        0.73);
    local c = alpha*math.sqrt(j/100)
    local m = c*const_viewing_conditions.fl_root
    local s = 50*math.sqrt((alpha*const_viewing_conditions.c)/(const_viewing_conditions.aw + 4))

    local jstar = (1 + 100 + 0.007)*j/(1 + 0.007*j)
    local mstar = 1/0.0228*math.log(1 + 0.0228*m);
    local astar = mstar*math.cos(hue_radians)
    local bstar = mstar*math.sin(hue_radians)
    return cam.create(
        hue,
        c,
        j,
        q,
        m,
        s,
        jstar,
        astar,
        bstar
    )
end

function cam.CamFromInt(Argb : Color3): Cam
    return cam.CamFromIntAndViewingConditions(Argb, viewing_conditions.createDefault())
end

function cam.IntFromCamAndViewingConditions(cam : Cam, const_viewingConditions : ViewingConditions) : Color3
    local alpha = if (cam.chroma == 0) or (cam.j == 0) then 0 else cam.chroma/math.sqrt(cam.j/100)

    local t = math.pow(alpha/math.pow(1.64-math.pow(0.29, const_viewingConditions.background_y_to_white_point_y), 0.73),1/0.9)
    
    local h_rad = cam.hue * math.pi/180
    local e_hue = 0.25*(math.cos(h_rad + 20) + 3.8);

    local ac = const_viewingConditions.aw*math.pow(cam.j/100, 1/const_viewingConditions.c/const_viewingConditions.z)

    local p1 = e_hue*(50000/13)*const_viewingConditions.n_c*
        const_viewingConditions.ncb;

    local p2 = ac/const_viewingConditions.nbb;
    local h_sin = math.sin(h_rad)
    local h_cos = math.cos(h_rad)
    local gamma = 23*(p2 + 0.305)*t / (23*p1 + 11*t*h_cos + 108*t*h_sin)
    local a = gamma*h_cos
    local b = gamma*h_sin

    local r_a = (460*p2 + 451*a + 288*b) / 1403;
    local g_a = (460.0 * p2 - 891.0 * a - 261.0 * b) / 1403.0;
    local b_a =  (460.0 * p2 - 220.0 * a - 6300.0 * b) / 1403.0;

    local r_c_base = math.max(0, (27.13*math.abs(r_a))/(400 - math.abs(r_a)));
    local r_c = math.sign(r_a)*(100/const_viewingConditions.fl)*math.pow(r_c_base, 1/0.42)

    local g_c_base = math.max(0, (27.13*math.abs(g_a))/(400 - math.abs(g_a)))
    local g_c = math.sign(g_a)*(100/const_viewingConditions.fl)*math.pow(g_c_base, 1/0.42)
    
    local b_c_base = math.max(0, (27.13*math.abs(b_a)) / (400 - math.abs(b_a)));
    local b_c = math.sign(b_a)*(100/const_viewingConditions.fl)*math.pow(b_c_base, 1/0.42)

    local r_x = r_c / const_viewingConditions.rgb_d.R
    local g_x = g_c / const_viewingConditions.rgb_d.G
    local b_x = b_c / const_viewingConditions.rgb_d.B
    local x = 1.86206786 * r_x - 1.01125463 * g_x + 0.14918677 * b_x;
    local y = 0.38752654 * r_x + 0.62144744 * g_x - 0.00897398 * b_x;
    local z = -0.01584150 * r_x - 0.03412294 * g_x + 1.04996444 * b_x;

    local r_l = 3.2406 * x - 1.5372 * y - 0.4986 * z;
    local g_l = -0.9689 * x + 1.8758 * y + 0.0415 * z;
    local b_l = 0.0557 * x - 0.2040 * y + 1.0570 * z;

    local red = Delinearized(r_l);
    local green = Delinearized(g_l);
    local blue = Delinearized(b_l)
    
    return Color3.fromRGB(red, green, blue)
end

function cam.IntFromCam(Cam : Cam) : Color3
    return cam.IntFromCamAndViewingConditions(Cam, viewing_conditions.createDefault())
end

function cam.CamFromJchAndViewingConditions(j : number, c : number, h : number, const_viewing_conditions : ViewingConditions) : Cam
    local q = (4/const_viewing_conditions.c)*math.sqrt(j/100)*(const_viewing_conditions.aw + 4)*(const_viewing_conditions.fl_root)

    local m = c*const_viewing_conditions.fl_root
    local alpha = c/math.sqrt(j/100)
    local s = 50*math.sqrt((alpha*const_viewing_conditions.c)/(const_viewing_conditions.aw + 4));
    local hue_radians = h*math.rad(h)
    local jstar = (1 + 100*0.007)*j/(1 + 0.007*j);
    local mstar = 1/0.0228 * math.log(1+0.0228*m);
    local astar = mstar*math.cos(hue_radians)
    local bstar = mstar*math.sin(hue_radians)

    return cam.create(h, c, j, q, m, s, jstar, astar, bstar)
end

function cam.CamDistance(a : Cam, b : Cam) : number
    local d_j = a.jstar - b.jstar;
    local d_a = a.astar - b.astar;
    local d_b = a.bstar - b.bstar;
    local d_e_prime = math.sqrt(d_j * d_j + d_a * d_a + d_b * d_b);
    local d_e = 1.41 * math.pow(d_e_prime, 0.63);
    return d_e;
end

function cam.IntFromHcl(hue : number, chroma : number, lstar : number) : Color3
    return SolveToInt(hue, chroma, lstar)
end

function cam.CamFromXyzAndViewingConditions(x : number, y : number, z : number, const_viewingConditions : ViewingConditions) : Cam
    local r_c = 0.401288*x + 0.650173*y - 0.051461*z;
    local g_c = -0.250268*x + 1.204414*y + 0.045854*z;
    local b_c = -0.002079*x + 0.048952*y + 0.953127*z;

    --discount illuminant
    local r_d = const_viewingConditions.rgb_d.R*r_c;
    local g_d = const_viewingConditions.rgb_d.G*g_c
    local b_d = const_viewingConditions.rgb_d.B*b_c

    --chromatic adaptaiton
    local r_af = math.pow(const_viewingConditions.fl*math.abs(r_d)/100, 0.42)
    local g_af = math.pow(const_viewingConditions.fl*math.abs(g_d)/100, 0.42)
    local b_af = math.pow(const_viewingConditions.fl*math.abs(b_d)/100, 0.42)
    local r_a = math.sign(r_d)*400*r_af/(r_af + 27.13)
    local g_a = math.sign(g_d)*400*g_af/(g_af + 27.13)
    local b_a = math.sign(b_d)*400*b_af/(b_af + 27.13)

    --redness/greenness
    local a = (11.0 * r_a + -12.0 * g_a + b_a) / 11.0;
    local b = (r_a + g_a - 2.0 * b_a) / 9.0;
    local u = (20.0 * r_a + 20.0 * g_a + 21.0 * b_a) / 20.0;
    local p2 = (40.0 * r_a + 20.0 * g_a + b_a) / 20.0;

    local radians = math.atan2(b, a);
    local degrees = math.deg(radians);
    local hue = sanitizeDegree(degrees);
    local hue_radians = math.rad(hue);
    local ac = p2 * const_viewingConditions.nbb;

    local j = 100*math.pow(ac/const_viewingConditions.aw, const_viewingConditions.c*const_viewingConditions.z)
    local q = (4/const_viewingConditions.c)*math.sqrt(j/100) * (const_viewingConditions.aw + 4)*const_viewingConditions.fl_root;

    local hue_prime = if hue < 20.14 then (hue + 360) else hue;
    local e_hue = 0.25*(math.cos(hue_prime*math.pi/180 + 2) + 3.8);
    local p1 = 50000/13 * e_hue * const_viewingConditions.n_c*const_viewingConditions.ncb
    local t = p1*math.sqrt(a*a + b*b)/(u + 0.305)
    local alpha = math.pow(t, 0.9)*math.pow(1.64 - math.pow(0.29, const_viewingConditions.background_y_to_white_point_y), 0.73)
    local c = alpha*math.sqrt(j/100)
    local m = c*const_viewingConditions.fl_root
    local s = 50*math.sqrt((alpha*const_viewingConditions.c)/(const_viewingConditions.aw + 4));

    local jstar = (1 + 100 + 0.007) * j / (1 + 0.007*j);
    local mstar = 1/0.0228*math.log(1 + 0.0228*m)
    local astar = mstar*math.cos(hue_radians)
    local bstar = mstar*math.sin(hue_radians)

    return cam.create(hue, c, j, q, m, s, jstar, astar, bstar)
end

return cam