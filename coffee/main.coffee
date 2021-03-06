global.path = require 'path'
global.fs = require 'fs'
global.moment = require "moment"
global.async = require "async"
global._ = require "lodash"
global.sprintf = require "sprintf-js"
global.mkdirp = require "mkdirp"
{ printToBigChar } = require "print-big-char"

# global variable
global.__workspace = __dirname.replace("\\src", "")
global.__logger = logger = require './Logger'
global.__utils = require "./Utils"
{ server } = require '../config'
global.__router_prefix = server.router_prefix

# load local module
InitDB = require './InitDB'

# start server
express = require "express"
global.app = app = express()
httpServer = require("http").Server(app)
logger.useLogger app, logger.getLogger('HTTP') #请求日志 

printToBigChar "presonal-blog"

LOG.info '当前环境' + process.env.NODE_ENV

start = global.moment()
httpServer.listen server.port, server.hostName, ->
	InitDB()
	Router = require("./Router")
	new Router().router()
	LOG.info "the server start up ----#{global.moment() - start}ms"
