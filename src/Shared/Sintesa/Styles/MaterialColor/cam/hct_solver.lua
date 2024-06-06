--!strict
--services
--packages
local viewing_conditions = require(script.Parent:WaitForChild("viewing_conditions"))
--modules
--types
--constants
--remotes
--variables
local kScaledDiscountFromLinrgb = {
    {
        0.001200833568784504,
        0.002389694492170889,
        0.0002795742885861124,
    },
    {
        0.0005891086651375999,
        0.0029785502573438758,
        0.0003270666104008398,
    },
    {
        0.00010146692491640572,
        0.0005364214359186694,
        0.0032979401770712076,
    },
}

local kLinrgbFromScaledDiscount = {
    {
        1373.2198709594231,
        -1100.4251190754821,
        -7.278681089101213,
    },
    {
        -271.815969077903,
        559.6580465940733,
        -32.46047482791194,
    },
    {
        1.9622899599665666,
        -57.173814538844006,
        308.7233197812385,
    },
}

local kYFromLinrgb = {0.2126, 0.7152, 0.0722};

local kCriticalPlanes = {
    0.015176349177441876, 0.045529047532325624, 0.07588174588720938,
    0.10623444424209313,  0.13658714259697685,  0.16693984095186062,
    0.19729253930674434,  0.2276452376616281,   0.2579979360165119,
    0.28835063437139563,  0.3188300904430532,   0.350925934958123,
    0.3848314933096426,   0.42057480301049466,  0.458183274052838,
    0.4976837250274023,   0.5391024159806381,   0.5824650784040898,
    0.6277969426914107,   0.6751227633498623,   0.7244668422128921,
    0.775853049866786,    0.829304845476233,    0.8848452951698498,
    0.942497089126609,    1.0022825574869039,   1.0642236851973577,
    1.1283421258858297,   1.1946592148522128,   1.2631959812511864,
    1.3339731595349034,   1.407011200216447,    1.4823302800086415,
    1.5599503113873272,   1.6398909516233677,   1.7221716113234105,
    1.8068114625156377,   1.8938294463134073,   1.9832442801866852,
    2.075074464868551,    2.1693382909216234,   2.2660538449872063,
    2.36523901573795,     2.4669114995532007,   2.5710888059345764,
    2.6777882626779785,   2.7870270208169257,   2.898822059350997,
    3.0131901897720907,   3.1301480604002863,   3.2497121605402226,
    3.3718988244681087,   3.4967242352587946,   3.624204428461639,
    3.754355295633311,    3.887192587735158,    4.022731918402185,
    4.160988767090289,    4.301978482107941,    4.445716283538092,
    4.592217266055746,    4.741496401646282,    4.893568542229298,
    5.048448422192488,    5.20615066083972,     5.3666897647573375,
    5.5300801301023865,   5.696336044816294,    5.865471690767354,
    6.037501145825082,    6.212438385869475,    6.390297286737924,
    6.571091626112461,    6.7548350853498045,   6.941541251256611,
    7.131223617812143,    7.323895587840543,    7.5195704746346665,
    7.7182615035334345,   7.919981813454504,    8.124744458384042,
    8.332562408825165,    8.543448553206703,    8.757415699253682,
    8.974476575321063,    9.194643831691977,    9.417930041841839,
    9.644347703669503,    9.873909240696694,    10.106627003236781,
    10.342513269534024,   10.58158024687427,    10.8238400726681,
    11.069304815507364,   11.317986476196008,   11.569896988756009,
    11.825048221409341,   12.083451977536606,   12.345119996613247,
    12.610063955123938,   12.878295467455942,   13.149826086772048,
    13.42466730586372,    13.702830557985108,   13.984327217668513,
    14.269168601521828,   14.55736596900856,    14.848930523210871,
    15.143873411576273,   15.44220572664832,    15.743938506781891,
    16.04908273684337,    16.35764934889634,    16.66964922287304,
    16.985093187232053,   17.30399201960269,    17.62635644741625,
    17.95219714852476,    18.281524751807332,   18.614349837764564,
    18.95068293910138,    19.290534541298456,   19.633915083172692,
    19.98083495742689,    20.331304511189067,   20.685334046541502,
    21.042933821039977,   21.404114048223256,   21.76888489811322,
    22.137256497705877,   22.50923893145328,    22.884842241736916,
    23.264076429332462,   23.6469514538663,     24.033477234264016,
    24.42366364919083,    24.817520537484558,   25.21505769858089,
    25.61628489293138,    26.021211842414342,   26.429848230738664,
    26.842203703840827,   27.258287870275353,   27.678110301598522,
    28.10168053274597,    28.529008062403893,   28.96010235337422,
    29.39497283293396,    29.83362889318845,    30.276079891419332,
    30.722335150426627,   31.172403958865512,   31.62629557157785,
    32.08401920991837,    32.54558406207592,    33.010999283389665,
    33.4802739966603,     33.953417292456834,   34.430438229418264,
    34.911345834551085,   35.39614910352207,    35.88485700094671,
    36.37747846067349,    36.87402238606382,    37.37449765026789,
    37.87891309649659,    38.38727753828926,    38.89959975977785,
    39.41588851594697,    39.93615253289054,    40.460400508064545,
    40.98864111053629,    41.520882981230194,   42.05713473317016,
    42.597404951718396,   43.141702194811224,   43.6900349931913,
    44.24241185063697,    44.798841244188324,   45.35933162437017,
    45.92389141541209,    46.49252901546552,    47.065252796817916,
    47.64207110610409,    48.22299226451468,    48.808024568002054,
    49.3971762874833,     49.9904556690408,     50.587870934119984,
    51.189430279724725,   51.79514187861014,    52.40501387947288,
    53.0190544071392,     53.637271562750364,   54.259673423945976,
    54.88626804504493,    55.517063457223934,   56.15206766869424,
    56.79128866487574,    57.43473440856916,    58.08241284012621,
    58.734331877617365,   59.39049941699807,    60.05092333227251,
    60.715611475655585,   61.38457167773311,    62.057811747619894,
    62.7353394731159,     63.417162620860914,   64.10328893648692,
    64.79372614476921,    65.48848194977529,    66.18756403501224,
    66.89098006357258,    67.59873767827808,    68.31084450182222,
    69.02730813691093,    69.74813616640164,    70.47333615344107,
    71.20291564160104,    71.93688215501312,    72.67524319850172,
    73.41800625771542,    74.16517879925733,    74.9167682708136,
    75.67278210128072,    76.43322770089146,    77.1981124613393,
    77.96744375590167,    78.74122893956174,    79.51947534912904,
    80.30219030335869,    81.08938110306934,    81.88105503125999,
    82.67721935322541,    83.4778813166706,     84.28304815182372,
    85.09272707154808,    85.90692527145302,    86.72564993000343,
    87.54890820862819,    88.3767072518277,     89.2090541872801,
    90.04595612594655,    90.88742016217518,    91.73345337380438,
    92.58406282226491,    93.43925555268066,    94.29903859396902,
    95.16341895893969,    96.03240364439274,    96.9059996312159,
    97.78421388448044,    98.6670533535366,     99.55452497210776,
};
local floor = math.floor 
local ceil = math.ceil
local pow = math.pow
local sin = math.sin
local cos = math.cos 
local abs = math.abs
--references

--local functions
local function MatrixMultiply(input : Vector3, matrix : {{number}}) 
    local a =
        input.X * matrix[0][0] + input.Y * matrix[0][1] + input.Z * matrix[0][2];
    local b =
        input.X * matrix[1][0] + input.Y * matrix[1][1] + input.Z * matrix[1][2];
    local c =
        input.X * matrix[2][0] + input.Y * matrix[2][1] + input.Z * matrix[2][2];
    return Vector3.new(a, b, c);
end

local function SanitizeRadians(angle : number)
    return ((angle + math.pi*8)%(math.pi*2))
end

local function trueDelinearized(rgb_component : number)
    local normalized = rgb_component / 100.0;
    local delinearized = 0.0;
    if (normalized <= 0.0031308) then
        delinearized = normalized * 12.92;
    else 
        delinearized = 1.055 * math.pow(normalized, 1.0 / 2.4) - 0.055;
    end
    return delinearized * 255.0;
end

local function chromaticAdaptation(component : number)
    local af = math.pow(math.abs(component), 0.42)
    return math.sign(component)*400*af/(af + 27.13)
end

local function HueOf(linrgb : Vector3)
    local scaledDiscount = MatrixMultiply(linrgb, kScaledDiscountFromLinrgb);
    
    local r_a = chromaticAdaptation(scaledDiscount.X)
    local g_a = chromaticAdaptation(scaledDiscount.Y)
    local b_a = chromaticAdaptation(scaledDiscount.Z)

    local a = (11*r_a + -12*g_a + b_a)/11

    local b = (r_a + g_a - 2*b_a)/9
    return math.atan2(b,a);
end

local function AreInCyclicOrder(a : number, b : number, c : number)
    local delta_a_b = SanitizeRadians(b - a);
    local delta_a_c = SanitizeRadians(c - a)
    return delta_a_b < delta_a_c
end

local function Intercept(source : number, mid : number, target : number)
    return (mid - source) / (target - source)
end

local function lerpPoint(source : Vector3, t : number, target : Vector3)
    return Vector3.new(
        source.X + (target.X - source.X)*t,
        source.Y + (target.Y - source.Y)*t,
        source.Z + (target.Z - source.Z)*t
    )
end

local function GetAxis(vector : Vector3, axis : number)
    if axis == 0 then
        return vector.X
    elseif axis == 1 then
        return vector.Y
    elseif axis == 2 then
        return vector.Z
    else
        return -1
    end
end

--[[
    /**
    * Intersects a segment with a plane.
    *
    * @param source The coordinates of point A.
    * @param coordinate The R-, G-, or B-coordinate of the plane.
    * @param target The coordinates of point B.
    * @param axis The axis the plane is perpendicular with. (0: R, 1: G, 2: B)
    * @return The intersection point of the segment AB with the plane R=coordinate,
    * G=coordinate, or B=coordinate
    */
]]
local function setCoordinate(source : Vector3, coordinate : number, target : Vector3, axis : number)
    local t = Intercept(GetAxis(source, axis), coordinate, GetAxis(target, axis))
    return lerpPoint(source, t, target)
end

local function isBounded(x : number)
    return if 0.0 <= x and x <= 100 then true else false
end

local function nthVertex(y : number, n : number)
    local k_r = kYFromLinrgb[1]
    local k_g = kYFromLinrgb[2]
    local k_b = kYFromLinrgb[3]

    local coord_a = if n%4 <= 1 then 0 else 100
    local coord_b = if n%2 == 0 then 0 else 100

    if (n < 4) then
        local g = coord_a
        local b = coord_b
        local r = (y - g*k_g - b*k_b) / k_r;
        if isBounded(r) then
            return Vector3.new(r, g, b)
        else
            return Vector3.new(-1,-1,-1)
        end
    elseif n < 8 then
        local b = coord_a;
        local r = coord_b;
        local g = (y - r * k_r - b * k_b) / k_g;
        if (isBounded(g)) then
            return Vector3.new(r, g, b);
        else 
            return Vector3.new(-1.0, -1.0, -1.0);
        end
    else
        local r = coord_a
        local g = coord_b
        local b = (y - r *k_r - g*k_g)/k_b;
        if isBounded(b) then
            return Vector3.new(r,g,b)
        else
            return Vector3.new(-1,-1,-1)
        end
    end
end

local function BisectToSegment(y : number, target_hue : number, out : {[number] : Vector3})
    local left = Vector3.new(-1, -1, -1)
    local right = left

    local left_hue = 0
    local right_hue = 0
    local initialized = false
    local uncut = true
    for n = 0, 12 - 1 do
        local mid = nthVertex(y, n)
        if mid.X < 0 then
            continue
        end
        local mid_hue = HueOf(mid)
        if not initialized then
            left = mid
            right = mid
            left_hue = mid_hue
            right_hue = mid_hue
            initialized = true
            continue
        end

        if (uncut or AreInCyclicOrder(left_hue, mid_hue, right_hue)) then
            uncut = false
            if AreInCyclicOrder(left_hue, target_hue, right_hue) then
                right = mid
                right_hue = mid_hue
            else
                left = mid
                left_hue = mid_hue
            end
        end
    end
    out[1] = left
    out[2] = right
end

local function Midpoint(a : Vector3, b : Vector3)
    return Vector3.new(
        (a.X + b.X)/2,
        (a.Y + b.Y)/2,
        (a.Z + b.Z)/2 
    )
end

local function CriticalPlaneBelow(x : number)
    return math.floor(x - 0.5)
end
local function CriticalPlaneAbove(x : number)
    return math.ceil(x - 0.5)
end

local function BisectToLimit(y : number, target_hue : number)
    local segment = {}
    BisectToSegment(y, target_hue, segment)
    local left = segment[1]
    local left_hue = HueOf(left)
    local right = segment[2]
    for axis = 0, 8 - 1 do
        if (GetAxis(left, axis) ~= GetAxis(right, axis)) then
            local l_plane = -1
            local r_plane = 255

            if GetAxis(left, axis) < GetAxis(right, axis) then
                l_plane = CriticalPlaneBelow(trueDelinearized(GetAxis(left, axis)))
                r_plane = CriticalPlaneAbove(trueDelinearized(GetAxis(right, axis)))
            else
                l_plane = CriticalPlaneAbove(trueDelinearized(GetAxis(left, axis)))
                r_plane = CriticalPlaneBelow(trueDelinearized(GetAxis(right, axis))) 
            end
            
            for i = 0, 8 - 1 do
                if (math.abs(r_plane - l_plane) <= 1) then
                    break
                else
                    local m_plane = math.floor((l_plane + r_plane)/2)
                    local mid_plane_coordinate = kCriticalPlanes[m_plane]
                    local mid = setCoordinate(left, mid_plane_coordinate, right, axis)
                    local mid_hue = HueOf(mid)
                    if AreInCyclicOrder(left_hue, target_hue, mid_hue) then
                        right = mid
                        r_plane = m_plane
                    else
                        left = mid
                        left_hue = mid_hue
                        l_plane = m_plane 
                    end
                end
            end
        end
    end
    return Midpoint(left, right)
end

local function InverseChromaticAdaptation(adapted : number)
    local adapted_abs = math.abs(adapted)
    local base = math.max(0, 27.13*adapted_abs/(400 - adapted_abs))
    return math.sign(adapted)*math.pow(base, 1/0.42)
end

local function FindResultByJ(hue_radians : number, chroma : number, y : number)
    local j = math.sqrt(y)*11

    local const_viewing_conditions = viewing_conditions.createDefault()
    local t_inner_coeff = 1/math.pow(1.64 - math.pow(0.29, const_viewing_conditions.background_y_to_white_point_y), 0.73)

    local e_hue = 0.25*(math.cos(hue_radians + 2) + 3.8)
    local p1 = e_hue*(50000/13)*const_viewing_conditions.n_c*const_viewing_conditions.ncb
    local h_sin = math.sin(hue_radians)
    local h_cos = math.cos(hue_radians)

    for iteration_round = 0, 5 - 1 do
        local j_normalized = j/100
        local alpha = if chroma == 0 or j == 0 then 0 else (chroma/math.sqrt(j_normalized))
        local t = math.pow(alpha*t_inner_coeff, 1/0.9)
        local ac = const_viewing_conditions.aw * pow(j_normalized, 1.0 / const_viewing_conditions.c / const_viewing_conditions.z);
        local p2 = ac / const_viewing_conditions.nbb;
        local gamma = 23.0 * (p2 + 0.305) * t /
            (23.0 * p1 + 11 * t * h_cos + 108.0 * t * h_sin);
        local a = gamma * h_cos;
        local b = gamma * h_sin;
        local r_a = (460.0 * p2 + 451.0 * a + 288.0 * b) / 1403.0;
        local g_a = (460.0 * p2 - 891.0 * a - 261.0 * b) / 1403.0;
        local b_a = (460.0 * p2 - 220.0 * a - 6300.0 * b) / 1403.0;
        local r_c_scaled = InverseChromaticAdaptation(r_a);
        local g_c_scaled = InverseChromaticAdaptation(g_a);
        local b_c_scaled = InverseChromaticAdaptation(b_a);

        local scaled = Vector3.new(r_c_scaled, g_c_scaled, b_c_scaled);
        local linrgb = MatrixMultiply(scaled, kLinrgbFromScaledDiscount);
        --// ===========================================================
        --// Operations inlined from Cam16 to avoid repeated calculation
        --// ===========================================================
        if (linrgb.X < 0 or linrgb.Y < 0 or linrgb.Z < 0) then
            return 0;
        end

        local k_r = kYFromLinrgb[1];
        local k_g = kYFromLinrgb[2];
        local k_b = kYFromLinrgb[3];

        local fnj = k_r * linrgb.X + k_g * linrgb.Y + k_b * linrgb.Z;
        if (fnj <= 0) then
            return 0;
        end
        if (iteration_round == 4) and (abs(fnj - y) < 0.002) then
            if (linrgb.X > 100.01 or linrgb.Y > 100.01 or linrgb.Z > 100.01) then
                return 0;
            end
            return ArgbFromLinrgb(linrgb);
        end
        --// Iterates with Newton method,
        --// Using 2 * fn(j) / j as the approximation of fn'(j)
        j = j - (fnj - y) * j / (2 * fnj);
    end
    return 0
end

function SolveToInt(double hue_degrees, double chroma, double lstar) 
    if (chroma < 0.0001 || lstar < 0.0001 || lstar > 99.9999) {
      return IntFromLstar(lstar);
    }
    hue_degrees = SanitizeDegreesDouble(hue_degrees);
    double hue_radians = hue_degrees / 180 * kPi;
    double y = YFromLstar(lstar);
    Argb exact_answer = FindResultByJ(hue_radians, chroma, y);
    if (exact_answer != 0) {
      return exact_answer;
    }
    Vec3 linrgb = BisectToLimit(y, hue_radians);
    return ArgbFromLinrgb(linrgb);
end

function SolveToCam(double hue_degrees, double chroma, double lstar) {
    return CamFromInt(SolveToInt(hue_degrees, chroma, lstar));
end
--class
local hct_solver = {}

return hct_solver