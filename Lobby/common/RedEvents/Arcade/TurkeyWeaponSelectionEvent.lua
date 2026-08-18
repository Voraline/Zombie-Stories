return require(game.ReplicatedStorage.Packages.Red).SharedEvent("TurkeyWeaponSelection", function(p1)
	if typeof(p1) == "table" then
		return p1
	else
		return nil
	end
end)