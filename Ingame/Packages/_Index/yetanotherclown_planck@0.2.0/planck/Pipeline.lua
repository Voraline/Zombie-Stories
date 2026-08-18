local v_u_1 = require(script.Parent.DependencyGraph)
local v2 = require(script.Parent.Phase)
local v_u_3 = {}
v_u_3.__index = v_u_3
function v_u_3.__tostring(p4) -- name: __tostring
	return p4._name
end
function v_u_3.insert(p5, p6) -- name: insert
	p5.dependencyGraph:insert(p6)
	return p5
end
function v_u_3.insertAfter(p7, p8, p9) -- name: insertAfter
	local v10 = table.find(p7.dependencyGraph.nodes, p9)
	assert(v10, "Unknown Phase in Pipeline:insertAfter(_, unknown), try adding this Phase to the Pipeline.")
	p7.dependencyGraph:insertAfter(p8, p9)
	return p7
end
function v_u_3.insertBefore(p11, p12, p13) -- name: insertBefore
	local v14 = table.find(p11.dependencyGraph.nodes, p13)
	assert(v14, "Unknown Phase in Pipeline:insertBefore(_, unknown), try adding this Phase to the Pipeline.")
	p11.dependencyGraph:insertBefore(p12, p13)
	return p11
end
function v_u_3.new(p15) -- name: new
	-- upvalues: (copy) v_u_1, (copy) v_u_3
	local v16 = {
		["_name"] = nil,
		["_type"] = "pipeline",
		["dependencyGraph"] = nil,
		["_name"] = p15 or debug.info(2, "sl"),
		["dependencyGraph"] = v_u_1.new()
	}
	local v17 = v_u_3
	return setmetatable(v16, v17)
end
v_u_3.Startup = v_u_3.new():insert(v2.PreStartup):insert(v2.Startup):insert(v2.PostStartup)
return v_u_3