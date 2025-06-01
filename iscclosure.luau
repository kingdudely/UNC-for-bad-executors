function iscclosure(func)
    return debug.info(func, "s") == "[C]"
end
