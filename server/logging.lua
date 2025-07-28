function LogEvent(eventName, details)
    print(('[Jagd-Log] %s: %s'):format(eventName, details or "Keine Details"))
end
