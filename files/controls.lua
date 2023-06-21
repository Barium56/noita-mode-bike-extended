local entity_id = GetUpdatedEntityID()
local x, y, rot = EntityGetTransform(entity_id)
local controls_component = EntityGetFirstComponentIncludingDisabled(entity_id, "ControlsComponent")
local mutator_component = EntityGetFirstComponentIncludingDisabled(entity_id, "PhysicsJoint2MutatorComponent")
local up_down = ComponentGetValue2(controls_component, "mButtonDownUp")
local down_down = ComponentGetValue2(controls_component, "mButtonDownDown")
local left_down = ComponentGetValue2(controls_component, "mButtonDownLeft")
local right_down = ComponentGetValue2(controls_component, "mButtonDownRight")
local nx = math.cos(rot)
local ny = math.sin(rot)

local max_speed = 90
local leaning_power = 5

local val = ComponentGetValue2(mutator_component, "motor_speed")
if val then
  ComponentSetValue2(mutator_component, "motor_speed", val * 0.97)
  if up_down then
    ComponentSetValue2(mutator_component, "motor_speed", math.min(val + 1, max_speed))
    PhysicsApplyForce(entity_id, nx * 5, ny * 5)
  elseif down_down then
    ComponentSetValue2(mutator_component, "motor_speed", math.max(val - 1, -(max_speed/2)))
    PhysicsApplyForce(entity_id, nx * -5, ny * -5)
  end
  if left_down then
    PhysicsApplyTorque(entity_id, -leaning_power)
  elseif right_down then
    PhysicsApplyTorque(entity_id, leaning_power)
  end
end