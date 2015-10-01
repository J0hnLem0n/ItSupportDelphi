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
//вывод объекта в консоль console.log(JSON.stringify(data, null, 4));
//jsonDate = JSON.stringify(data, null, 4);
//console.log(jsonDate);
		//-----------------------------------------------------------------
		if (commandItString[0] == '100') {
			for(i=0; i<clientPeopleSockets.length; i++) {
				if (clientPeopleSockets[i].socketId == idClientPeople) {
					clientPeopleSockets[i].write(clientPeopleSockets[i].socketId+'\n');
				} 
			}
		}
		else if (commandItString[0] == '101') {
			for(i=0; i<clientPeopleSockets.length; i++) {
				if (clientPeopleSockets[i].socketId == commandItString[1]) {
					clientPeopleSockets[i].remouteUserId = idClientPeople; //ид пользователя суппорт записывается в объект пользователя к которому подключаются
					console.log('id: '+clientPeopleSockets[i].socketId+'--> '+' remouteUserId: '+clientPeopleSockets[i].remouteUserId);
				} 
			}
		}
		//test------------------------------------------------
		else if (commandItString[0] == '102') {
			for(i=0; i<clientPeopleSockets.length; i++) {
				if (clientPeopleSockets[i].socketId == commandItString[1]) {
					clientPeopleSockets[i].write('102'+commandItString[2]+'\n');
				} 
			}
		}
		else if (commandItString[0] == '103') {
			for(i=0; i<clientPeopleSockets.length; i++) {
				if (clientPeopleSockets[i].socketId == commandItString[1]) {
					clientPeopleSockets[i].write('103'+commandItString[2]+'\n');
				} 
			}
		}
		else if (commandItString[0] == '104') {
			for(i=0; i<clientPeopleSockets.length; i++) {
				if (clientPeopleSockets[i].socketId == commandItString[1]) {
					clientPeopleSockets[i].write('104'+commandItString[2]+'\n');
				} 
			}
		}
		else if (commandItString[0] == '105') {
			for(i=0; i<clientPeopleSockets.length; i++) {
				if (clientPeopleSockets[i].socketId == commandItString[1]) {
					clientPeopleSockets[i].write('105'+commandItString[2]+'\n');
				} 
			}
		}
		else if (commandItString[0] == '106') {
			for(i=0; i<clientPeopleSockets.length; i++) {
				if (clientPeopleSockets[i].socketId == commandItString[1]) {
					clientPeopleSockets[i].write('106'+commandItString[2]+'\n');
				} 
			}
		}
		else if (commandItString[0] == '107') {
			for(i=0; i<clientPeopleSockets.length; i++) {
				if (clientPeopleSockets[i].socketId == commandItString[1]) {
					clientPeopleSockets[i].write('107'+commandItString[2]+'\n');
				} 
			}
		}
		else if (commandItString[0] == '108') {
			for(i=0; i<clientPeopleSockets.length; i++) {
				if (clientPeopleSockets[i].socketId == commandItString[1]) {
					clientPeopleSockets[i].write('108'+commandItString[2]+'\n');
				} 
			}
		}
		else if (commandItString[0] == '109') {
			for(i=0; i<clientPeopleSockets.length; i++) {
				if (clientPeopleSockets[i].socketId == commandItString[1]) {
					clientPeopleSockets[i].write('109'+commandItString[2]+'\n');
				} 
			}
		}
		/*else if (commandItString[0] == '110') {
			for(i=0; i<clientPeopleSockets.length; i++) {
				if (clientPeopleSockets[i].socketId == commandItString[1]) {
					clientPeopleSockets[i].write('110'+commandItString[2]+'\n');
				} 
			}
		}*/
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