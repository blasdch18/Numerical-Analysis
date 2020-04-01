function loadFromServer(option) {
    var xhReq = new XMLHttpRequest();

    xhReq.open("GET", "http://localhost/cgi-bin/GetFuntion.cgi?f=" + option, false);
    xhReq.send();
    var Result = xhReq.responseText;
    return Result;

}