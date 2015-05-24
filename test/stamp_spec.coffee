# Hubot classes
Robot = require("hubot/src/robot")
TextMessage = require("hubot/src/message").TextMessage
# Load assertion methods to this scope
chai = require 'chai'
expect = chai.expect

describe 'stamp', ->
  robot   = null
  user    = null
  adapter = null
  process.env.HUBOT_STAMPS = "{\"doki\": \"dokidoki\", \"pon\": \"ponpon\"}"

  beforeEach (done) ->
    robot = new Robot(null, 'mock-adapter', false, 'hubot')

    robot.adapter.on 'connected', ->
      require('../scripts/stamp')(robot)
      user = robot.brain.userForId '1',
        name: 'sammy'
        room: '#stamp'
      adapter = robot.adapter
      done()
    robot.run()

  afterEach -> robot.shutdown()

  it 'responds "stp doki"', (done) ->
    adapter.on 'send', (envelope, strings) ->
      expect(strings[0]).to.equal('dokidoki')
      done()

    adapter.receive(new TextMessage(user, 'stp doki'))

  it 'responds "stamp pon"', (done) ->
    adapter.on 'send', (envelope, strings) ->
      expect(strings[0]).to.equal('ponpon')
      done()

    adapter.receive(new TextMessage(user, 'stamp pon'))

  it 'responds "stp list"', (done) ->
    adapter.on 'send', (envelope, strings) ->
      expect(strings[0]).to.equal('doki,pon')
      done()

    adapter.receive(new TextMessage(user, 'stp list'))

  it 'responds "stamp list"', (done) ->
    adapter.on 'send', (envelope, strings) ->
      expect(strings[0]).to.equal('doki,pon')
      done()

    adapter.receive(new TextMessage(user, 'stamp list'))

  it 'responds "Nothing keyword"', (done) ->
    adapter.on 'send', (envelope, strings) ->
      expect(strings[0]).to.equal('No stamp for Nothing')
      done()

    adapter.receive(new TextMessage(user, 'stp Nothing'))
