'use strict';

var request = require('request');

var opts = {
    uri: 'https://api.github.com' + '/users/' + process.argv[2] + '/events',
    json: true,
    method: 'GET',
    headers: {
        'User-Agent': 'nodejs script'
    }
}

request(opts, function (err, res, body) {
    if (err) throw new Error(err);

    var format = '[%s]: %s %s %s %s';

    for (var i = 0; i < body.length; i++) {
        console.log(format
            , body[i].created_at
            , body[i].type
            , body[i].actor.login
            , body[i].repo.name);
    }
});
