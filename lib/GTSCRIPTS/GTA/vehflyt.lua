quaternionLib = {}

local pi = math.pi
local deg2rad = pi/180
local rad2deg = 180/pi
local abs   = math.abs
local sqrt  = math.sqrt
local exp   = math.exp
local log   = math.log
local sin   = math.sin
local cos   = math.cos
local min   = math.min
local max   = math.max
local acos  = math.acos
local atan = math.atan

--prints the quaternion
function quaternionLib:print()
    print(self:to_string())
end

--toasts the quaternion
function quaternionLib:toast()
    util.toast(self:to_string())
end
--toasts the quaternion
function quaternionLib:to_string()
    return "X:" .. self.x .. " Y:" .. self.y .. " Z:" .. self.z .. " W:" .. self.w
end
--function to create a new quaternion
function quaternionLib.new(x, y, z, w)
    q = {
        x = x or 1,
        y = y or 0,
        z = z or 0,
        w = w or 0
    }
    setmetatable(q, quaternionLib)
    quaternionLib.__index = quaternionLib
    return q
end

function quaternionLib:copy()
    return quaternionLib.new(self.x, self.y, self.z, self.w)
end

local q_pointer = memory.alloc(8 * 4)
function quaternionLib.from_entity(ent)
    ENTITY.GET_ENTITY_QUATERNION(ent, q_pointer, q_pointer + 8, q_pointer + 16, q_pointer + 24)
    return quaternionLib.new(
        memory.read_float(q_pointer),
        memory.read_float(q_pointer + 8),
        memory.read_float(q_pointer + 16),
        memory.read_float(q_pointer + 24))
end

--Wikipedia go brrrrrr
function quaternionLib.from_euler(x, y, z)
	x = x*deg2rad*0.5
	y = y*deg2rad*0.5
	z = z*deg2rad*0.5

    local cr = cos(x)
    local sr = sin(x)
    local cp = cos(y)
    local sp = sin(y)
    local cy = cos(z)
    local sy = sin(z)

    local q = quaternionLib.new()

	q.w = cr * cp * cy + sr * sp * sy;
    q.x = sr * cp * cy - cr * sp * sy;
    q.y = cr * sp * cy + sr * cp * sy;
    q.z = cr * cp * sy - sr * sp * cy;
	return q
end

--Wikipedia go brrrrrr
function quaternionLib:to_euler()
    local angles = v3.new()

    local sinr_cosp = 2 * (q.w * q.x + q.y * q.z);
    local cosr_cosp = 1 - 2 * (q.x * q.x + q.y * q.y);
    angles.x = atan(sinr_cosp, cosr_cosp) * rad2deg;

    local sinp = sqrt(1 + 2 * (q.w * q.y - q.x * q.z));
    local cosp = sqrt(1 - 2 * (q.w * q.y - q.x * q.z));
    angles.y = (2 * atan(sinp, cosp) - pi / 2) * rad2deg;

    local siny_cosp = 2 * (q.w * q.z + q.x * q.y);
    local cosy_cosp = 1 - 2 * (q.y * q.y + q.z * q.z);
    angles.z = atan(siny_cosp, cosy_cosp) * rad2deg;

    return angles;
end

--return the inverse of the given quaternion
function quaternionLib:inverse()
    local quat = quaternionLib.new(
        -self.x,
        -self.y,
        -self.z,
        self.w)

    return quat
end

-- function to multiply two quaternions
function quaternionLib:mul(q2)
    local w1, x1, y1, z1 = self.x, self.y, self.z, self.w
    local w2, x2, y2, z2 = q2.x, q2.y, q2.z, q2.w
    return quaternionLib.new(
        w1 * w2 - x1 * x2 - y1 * y2 - z1 * z2,
        w1 * x2 + x1 * w2 + y1 * z2 - z1 * y2,
        w1 * y2 + y1 * w2 + z1 * x2 - x1 * z2,
        w1 * z2 + z1 * w2 + x1 * y2 - y1 * x2
    )
end

function quaternionLib:from_entity_pointer(pointer)
    return quaternionLib.from_euler(entities.get_rotation(pointer):get())
end

function quaternionLib:mul_v3(vec)
    local new_vec = v3.new(vec)
    self:mul_v3_non_alloc(new_vec)
    return new_vec
end 


-- function to multiply a quaternion with a vector 3 (I stole this code. Sue me.)
local temp_store_vec = v3.new()
function quaternionLib:mul_v3_non_alloc(vec)
    local num   = self.x * 2 
    local num2  = self.y * 2 
    local num3  = self.z * 2 
    local num4  = self.x * num 
    local num5  = self.y * num2
    local num6  = self.z * num3 
    local num7  = self.x * num2
    local num8  = self.x * num3
    local num9  = self.y * num3
    local num10 = self.w * num
    local num11 = self.w * num2
    local num12 = self.w * num3

    temp_store_vec.x = vec.x
    temp_store_vec.y = vec.y
    temp_store_vec.z = vec.z
    vec.x = (((1 - (num5 + num6)) * temp_store_vec.x) + ((num7 - num12) * temp_store_vec.y)) + ((num8 + num11) * temp_store_vec.z)
    vec.y = (((num7 + num12) * temp_store_vec.x) + ((1 - (num4 + num6)) * temp_store_vec.y)) + ((num9 - num10) * temp_store_vec.z)
    vec.z = (((num8 - num11) * temp_store_vec.x) + ((num9 + num10) * temp_store_vec.y)) + ((1 - (num4 + num5)) * temp_store_vec.z)
end

-- rotate a quaternion by the given eulerAngles
function quaternionLib:rotate(x, y , z)
    --create a quaternion from the euler angles and multiply it with the given quaternion. Return the result
    return quaternionLib.from_euler(x, y, z):mul(self)
end

--#endregion
return quaternionLib
