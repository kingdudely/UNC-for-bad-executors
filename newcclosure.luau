-- Thanks for https://devforum.roblox.com/t/3560554/91

function newcclosure<T> (closure: T & (...any) -> (...any)): T
	return coroutine.wrap(@native function(...)
		local func

		func = function(...)
			return func(coroutine.yield(closure(...)))
		end

		func(...)
	end)
end
