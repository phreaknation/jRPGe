var fs = require('fs'),
    path = require('path'),
    async = require('async'),
    http = require('http'),
    url = require('url'),
    express = require('express'),
    socketio = require('socket.io'),
    jade = require('jade'),
    app = express(),
    server = http.createServer(app),
    io = socketio.listen(server, { log: false }),

    resourceDirectory = '../client/',
    serverPort = parseInt(process.env.PORT) || 8001,
    serverIP = process.env.HOST || process.env.IP || '0.0.0.0',
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

io.set('transports',['xhr-polling']);
io.set('log level', 1);

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

function getExtension(filename) {
    var ext = path.extname(filename || '').split('.');
    return ext[ext.length - 1];
}

function readJSON(file, callback) {
    fs.readFile(file, 'utf8', function (err, data) {
        if (err) {
            console.log('Error: ' + err);
        }
        callback(JSON.parse(data));
    });
}

function writeJSON(file, json, callback) {
    fs.writeFile(file, JSON.stringify(json), function (err,data) {
        if (err) {
            return console.log(err);
        }
        callback()
    });
}

app.get('/:pageName?', function(req, res) {
    var pageName = req.params.pageName || 'index';
    var url_parts = url.parse(req.url, true);
    var query = url_parts.query;

    if (req.params.page) {
        pageName = req.params.page;
    } else if (url_parts.pathname !== '/') {
        pageName = url_parts.pathname.slice(1);
    }
    console.log(pageName, req.params)
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
            res.set('Content-Type', content_types[getExtension(res.req.url)]);
            return res.end(html);
        }
    });
});

io.on('connection', function(socket) {
    readJSON(__dirname + '/assets/json/news.json', function(data) {
        socket.emit("news", data)
    });

    readJSON(__dirname + '/assets/json/status.json', function(data) {
        socket.emit("status", data)
    });

    readJSON(__dirname + '/assets/json/site.json', function(data) {
        socket.emit("setVisitorCount", data.visitors.count);
    });

    socket.on('setVisitorCookie', function() {
        readJSON(__dirname + '/assets/json/site.json', function(data) {
            data.visitors.count++;
            writeJSON(__dirname + '/assets/json/site.json', data, function() {
                socket.emit("setVisitorCookie");
            });
        });
    });
});
server.listen(serverPort, serverIP, function() {
    var addr = server.address();
    console.log('[SERVER] Listening at: ' + addr.address + ":" + addr.port);
});