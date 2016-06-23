require "logger"

log = Logger.new(File.open("mytest.log", mode: "a"))
log.level = Logger::INFO

log.debug("Created logger")
log.info("Program started")
log.warn("Nothing to do!")
