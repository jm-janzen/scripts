#!/usr/bin/nodejs

'use strict';

try {
    var opts = parseOptions(process.argv[2]);
} catch (e) {
    console.error('Must enter a user name to query!');
    process.exit(1);
}

var request = require('request');

sendRequest(opts, function (out) {
    out.forEach(function (v, i, a) {
        console.log('%s on %s\n  %s'
          , a[i][1]
          , new Date(a[i][0])
          , a[i][3]);
    });
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
    if (! opts) throw new Error('No options provided');

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
            bod.push([ body[i].created_at
            , body[i].type
            , body[i].actor.login
            , body[i].repo.name]);
        }

        callback(bod);

    });
}

