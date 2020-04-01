/**
 * @author Christian Ortiz
 */



function Request() {
    this.parameters = new Array();
    this.Index = 0;
    this.server = "http://localhost/cgi-bin/secant.exe";
    this.run = Execute;
    this.add = Add;
}

function Add(name, value) {
    this.parameters[this.Index] = new Pare(name, value);
    this.Index++;
}

function Execute() {
    var URL = this.server;
    try {
        if (window.XMLHttpRequest) {
            var httpRequest = new XMLHttpRequest();
        } else if (window.ActiveXObject) {
            var httpRequest = new ActiveXObject('Microsoft.XMLHTTP');
        }
    } catch (e) {
        alert('Error al crear la conexión :\n' + e);
        return;
    }


    try {
        var TheVar = "?1";
        for (var i in this.parameters) {
            TheVar = TheVar + '&' + this.parameters[i].name + '=' + this.parameters[i].value;
        }
        httpRequest.open("GET", URL + TheVar, false, null, null);
        httpRequest.send('');
    } catch (e) {
        alert('algún error ha ocurrido tratandose de comunicar al servidor: ' + e);
        return false;
    }
    switch (httpRequest.readyState) {
        case 1, 2, 3:
            alert('Estado erróneo: ' + httpRequest.status);
            return false;
            break;
        case 4:
            if (httpRequest.status != 200) {
                alert('El servidor responde con un código de estado erróneo: ' + httpRequest.status);
                return false;
            } else {
                var Answer = httpRequest.responseText;
            }
            break;
    }
    return Answer;
}

function Pare(name, value) {
    this.name = name;
    this.value = value;
}