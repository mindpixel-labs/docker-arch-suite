var ldap = require('ldapjs');

var server = ldap.createServer({
    strictDN: false
});

server.search('o=example', function(req, res, next) {
    var objects = [
        {
            dn: req.dn.toString(),
            attributes: {
                objectclass: ['user'],
                ou: 'users',
                o: 'example',
                cn: 'superadmin',
                username: 'superadmin',
                password: 'superadmin',
            }
        },
        {
            dn: req.dn.toString(),
            attributes: {
                objectclass: ['user'],
                ou: 'users',
                o: 'example',
                cn: 'admin',
                username: 'admin',
                password: 'admin',
            }
        }
    ]

    for (var i = 0; i<objects.length; i++) {
        if (req.filter.matches(objects[i].attributes)) {
            res.send(objects[i])
        }
    }

    res.end();
});

server.bind('ou=people, o=example', function(req, res, next) {
  console.log('bind DN: ' + req.dn.toString());
  console.log('bind PW: ' + req.credentials);
  res.end();
});

server.listen(1389, function() {
    console.log('LDAP server listening at %s', server.url);
});
