/* https config
fs = require('fs')
options = {
        key: fs.readFileSync('./key'),
        cert: fs.readFileSync('./cert')
}
*/
var path = require('path'),
    async = require('async'),
    http = require('http'),
    url = require('url'),
    express = require('express'),
    socketio = require('socket.io'),
    jade = require('jade'),
    app = express(),
    server = http.createServer(app),
    io = socketio.listen(server),

    resourceDirectory = '../client/',
    serverPort = process.env.PORT || 8001,
    serverIP = process.env.IP || '0.0.0.0',
    content_types = {
        "js": "application/javascript",
        "bmp": "image/bmp",
        "gif": "image/gif",
        "jpeg": "image/jpeg",
        "jpg": "image/jpeg",
        "png": "image/png",
        "css": "text/css",
        "html": "text/html",
        "txt": "text/plain"
    };

var allowCrossDomain = function(req, res, next) {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE');
    res.header('Access-Control-Allow-Headers', 'Content-Type');

    next();
};

app.set('views', __dirname + '/assets/jade/views');
app.set('view engine', 'jade');
app.use(express.static(path.resolve(__dirname, resourceDirectory)));
console.log(path.resolve(__dirname, resourceDirectory))
app.engine('jade', jade.__express);

/*
app.configure(function() {
    app.use(express.logger('dev'));
    app.use(allowCrossDomain);
    //app.use(express.favicon());
    //app.use(express.bodyParser());
    //app.use(express.methodOverride());
    //app.use(express.cookieParser('jkln2zdx8  2nla'));
    //app.use(express.session());
    //app.use(app.router);
    //
});
*/
console.log('[SERVER] Setting up application options');

// pm.once('open', function callback () {
//         // yay!
//         console.log('[SERVER] PM Database is opened!');
// });

function getExtension(filename) {
    var ext = path.extname(filename || '').split('.');
    return ext[ext.length - 1];
}

app.get('/:page?/*', function(req, res) {
    var pageName = 'index';
    var url_parts = url.parse(req.url, true);
    var query = url_parts.query;
    console.log(url_parts);

    if (req.param.page) {
        pageName = req.param.page;
    } else if (url_parts.pathname !== '/') {
        pageName = url_parts.pathname;
    }
    res.render(pageName, {}, function(err, html) {
        if (err) {
            var rendered = {
                "js": false,
                "bmp": false,
                "gif": false,
                "jpeg": false,
                "jpg": false,
                "png": false,
                "css": false,
                "html": true,
                "txt": true
            };
            //console.log(err);
            res.status(404);

            if (rendered[getExtension(res.req.url)] === true) {
                console.log(rendered[getExtension(res.req.url)]);
                res.redirect('/404'); // File doesn't exists
            } else {
                res.status(404).send('File Not Found');
            }
        } else {
            /*
            for (i in res) {
                if (typeof res[i] == "string") {
                    console.log(res[i])
                }
            }*/
            //console.log(res.req.url)
            res.set('Content-Type', content_types[getExtension(res.req.url)]);
            return res.end(html);
        }
    });
});

var messages = [];
var sockets = [];

io.on('connection', function(socket) {
    messages.forEach(function(data) {
        socket.emit('message', data);
    });

    sockets.push(socket);

    socket.on('disconnect', function() {
        sockets.splice(sockets.indexOf(socket), 1);
        updateRoster();
    });

    socket.on('message', function(msg) {
        var text = String(msg || '');

        if (!text)
            return;

        socket.get('name', function(err, name) {
            var data = {
                name: name,
                text: text
            };

            broadcast('message', data);
            messages.push(data);
        });
    });

    socket.on('identify', function(name) {
        socket.set('name', String(name || 'Anonymous'), function(err) {
            updateRoster();
        });
    });
});

function updateRoster() {
    async.map(
        sockets,
        function(socket, callback) {
            socket.get('name', callback);
        },
        function(err, names) {
            broadcast('roster', names);
        }
    );
}

function broadcast(event, data) {
    sockets.forEach(function(socket) {
        socket.emit(event, data);
    });
}

server.listen(serverPort, serverIP, function() {
    var addr = server.address();
    console.log('[SERVER] Listening at: ' + addr.address + ":" + addr.port);
});