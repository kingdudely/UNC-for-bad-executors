function hookfunction(old, new)
    local envs = {
        getgenv(),
        getfenv(),
        _G
    }

    local env
    local oldName --[[, env]] = debug.getinfo(old).name or debug.info(old, "n")

    if type(name) ~= "string" or #name == 0 then -- (not name) or #name <= 0
        for _, selectedEnv in envs do
            for name, func in selectedEnv do
                if func == old then
                    env = selectedEnv
                    oldName = name

                    break
                end
            end
        end
    end

    if env then
        env[oldName] = new
    else
        warn("Enviornment not found")
    end
end
