'use strict';

var request = require('request');

var opts = parseOptions(process.argv[2]);
sendRequest(opts, function (out) {
    console.log(out)
});

/*
 * Verify param is present, and just return it.
 * TODO
 *   Check for multiple params, and check validity
 *   as well as presence.
 */
function parseParams(params) {
    if (! params) {
        console.log('Usage: nodejs gevents.js <user-name>');
        process.exit(0);
    }

    return params;
}

function parseOptions(opts) {

    // org or users, resource, query topic
    var who = '/users'
      , where = '/' + opts
      , what  = '/events'

    var options = {
        uri: 'https://api.github.com'
          + who
          + where
          + what,
        json: true,
        method: 'GET',
        headers: {
            'User-Agent': 'nodejs script'
        }
    }

    return options;
}

function sendRequest(opts, callback) {

    var format = '[%s]: %s %s %s';
    var bod    = [];

    request(opts, function (error, res, body) {
        if (error) throw new Error(error);

        for (var i = 0; i < body.length; i++) {
            /*
            * TODO return something like this as JSON
            * for caller consumption (useful for servers).
            */
            bod.push([ body[i].created_at
            , body[i].type
            , body[i].actor.login
            , body[i].repo.name]);
        }

        callback(bod);

    });
}

