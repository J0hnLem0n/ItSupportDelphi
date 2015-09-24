var net = require("net");
var clientPeopleSockets = [];
var serverPort = 8124;
var idClientPeople = 1000000000;

var server = net.createServer(function(socket) {
	//генерация ид пользователей
	idClientPeople = idClientPeople +1;
	//присваивание ид сокету
	socket.socketId = idClientPeople;
	clientPeopleSockets.push(socket);

    console.log('Клиент подключился id: '+idClientPeople);

	socket.on('data', function (data) {
		//убираем всякие переносы сторки и т.д могут быть ошибки криво все
		var dataClient = data.toString('utf8'); 
		dataClientNew = dataClient.replace(/[\r\n]/m,'');//***************** del
		dataClientNew = dataClientNew.substring(0, dataClient.length - 1);//********** del
		var coordMouse = dataClientNew.substr(0,5);//************ del
		var commandItString = dataClient.split(',');
		//console.log(commandItString[0]);
		//console.log(coordMouse);
// вывод объекта в консоль console.log(JSON.stringify(data, null, 4));
//jsonDate = JSON.stringify(data, null, 4);
//console.log(jsonDate);
		//-----------------------------------------------------------------
		if (commandItString[0] == 'hello') {
			for(i=0; i<clientPeopleSockets.length; i++) {
				if (clientPeopleSockets[i].socketId == idClientPeople) {
					clientPeopleSockets[i].write(clientPeopleSockets[i].socketId+'\n');
				} 
			}
		}
		else if (commandItString[0] == 'helloIt') {
			for(i=0; i<clientPeopleSockets.length; i++) {
				if (clientPeopleSockets[i].socketId == commandItString[1]) {
					clientPeopleSockets[i].remouteUserId = idClientPeople; //ид пользователя суппорт
					console.log('id: '+clientPeopleSockets[i].socketId+'--> '+' remouteUserId: '+clientPeopleSockets[i].remouteUserId);
				} 
			}
		}
		else if (commandItString[0] == 'getMouseCoord') {
			for(i=0; i<clientPeopleSockets.length; i++) {
				if (clientPeopleSockets[i].socketId == commandItString[1]) {
					clientPeopleSockets[i].write(clientPeopleSockets[i].mouseCoord+'\n');
				} 
			}
		}
		//test------------------------------------------------
		else if (commandItString[0] == 'coordMouse') {
			console.log('send coord');
			for(i=0; i<clientPeopleSockets.length; i++) {
				if (clientPeopleSockets[i].socketId == commandItString[1]) {
					clientPeopleSockets[i].mouseCoord = commandItString[2];
				} 
			}
		}
		else if (commandItString[0] == 'getImage') {
			console.log('dasd');
			for(i=0; i<clientPeopleSockets.length; i++) {
				if (clientPeopleSockets[i].socketId == '1000000001') {
					console.log(clientPeopleSockets[i].screenImage)
					clientPeopleSockets[i].write(clientPeopleSockets[i].screenImage);	
				} 
			}
		}
		else {
			for(i=0; i<clientPeopleSockets.length; i++) {
				if (clientPeopleSockets[i].socketId == '1000000002') {
					clientPeopleSockets[i].write(data);
				} 
			}
		}
		//----------------------------------------------
	});
	socket.on('end', function () {
        var i = clientPeopleSockets.indexOf(socket);
        clientPeopleSockets.splice(i, 1);
    });
});
server.listen(serverPort, function() {
    console.log('Сервер запущен на порту '+serverPort);
});