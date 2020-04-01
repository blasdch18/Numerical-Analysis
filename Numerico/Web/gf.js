function OnclicGraph() {
    //Clear canvas
    var doc = document;
    var canvas = doc.getElementById("myCanvas");
    var context = canvas.getContext('2d');
    context.clearRect(0, 0, canvas.width, canvas.height);
    //End clear canvas

    //Value of itemselected from combo
    selected = doc.getElementById('f').selectedIndex;
    doc.getElementById("fx").value = loadFromServer(selected);
    SetGraphics(doc.getElementById("fx").value);

    x = doc.getElementById("x").value;
    if (!isNaN(x)) {
        doc.getElementById("fdx").value = eval(doc.getElementById("fx").value);
    }

}

function OnclicGraphPoints() {
    var doc = document;
    var canvas = doc.getElementById("myCanvas");
    var context = canvas.getContext('2d');
    var GetPoints = -1;
    context.clearRect(0, 0, canvas.width, canvas.height);
    var Points = loadFromServer(GetPoints);
    SetGraphicsByPoints(Points);

}