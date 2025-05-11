function hookfunction(old, new)
    local envs = {
        getgenv(),
        getfenv(),
        _G
    }

    for _, env in envs do
        for name, func in env do
            if func == old then
                env[name] = new
                return old
            end
        end
    end

    warn("Enviornment not found!")
end
