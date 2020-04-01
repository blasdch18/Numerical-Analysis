<html>
	<head>
		<meta name="author" content="Vargas Sarmiento Yimi"/>
		<meta name="description" content="Guia 1 HTML/JavaScript - ADSI 259128"/>
		<style>
			body {
				background-color: #DCDCDC;
			}
			#plano {
				font-family: Tahoma, Verdana, Arial;
				font-size: 12px;
				color: #000000;
				background-color: transparent;
				border-width: 0;
			}
		</style>
		<script>
			function OkSize(colA, filB) {
				if (colA == filB) {
					return true;
				} else {
					return false;
				}
			}

		function genMatrices(filA, colA, filB, colB) {
                c=new String();
                e=document.getElementById('divMatrices');
                c+='<table name"tblMatrices" id="tblMatrices" border=1>';
                c+='<tr>';
 
                c+='<td align="center" valing="middle">';
                c+='<table name="tblMtzA">';
                for ( i = 0; i < filA; i++) {
                    c+='<tr>';
                    for ( j = 0; j < colA; j++) {
                        c+='<td><input type="text" size="1" maxlength="2"/></td>';
                    }
                    c+='</tr>';
                }
                c+='</table>';
                c+='</td>';
 
                c+='<td align="center" valign="middle">';
                c+='<table name="tblMtzB">';
                for ( i = 0; i < filB; i++) {
                    c+='<tr>';
                    for ( j = 0; j < colB; j++) {
                        c+='<td><input type="text" size="1" maxlength="2"/></td>';
                    }
                    c+='</tr>';
                }
                c+='</table>';
                c+='</td>';
 
                c+='<td align="center" valign="middle">';
                c+='<table name="tblMtzR">';
                for ( i = 0; i < filA; i++) {
                    c+='<tr>';
                    for ( j = 0; j < colB; j++) {
                        c+='<td><input type="text" size="1" maxlength="2"/></td>';
                    }
                    c+='</tr>';
                }
                c+='</table>';
                c+='</td>';
 
                c+='</tr>';
                c+='</table>';
                
                //var matrices = document.getElementById('tblMatrices');
                //document.getElementById('divMatrices').innerHTML = matrices;
                e.innerHTML=c;
 
            }

			function OpeMultp(filA, colA, filB, colB) {
				if (OkSize(colA, filB) == false) {
					alert('No se puede multiplicar')
					document.frmArreglo4.txtMtzAfil.focus
				} else {
					genMatrices(filA, colA, filB, colB)
				}
			}

		</script>
	</head>
	<body>
		<form name="frmArreglo4" id="frmArreglo4">
			<h3 align="center">Arreglos 4</h3>
			<p align="center">
				Escriba el c&oacute;digo necesario para multiplicar dos matrices y generar el resultado.
				<br/>
				Tenga encuenta los criterios de validaci&oacute;n para multiplicar dos matrices.
			</p>
			<hr/>
			<h2 align="center">MULTIPLICACION DE MATRICES</h2>
			<table align="center" border="1">
				<tr>
					<td>
					<table>
						<tr>
							<td align="center" colspan="4"><b>Matriz A</b></td>
						</tr>
						<tr>
							<td>Filas:</td><td>
							<input name="txtMtzAfil" type="text" size="1" maxlength="2" value="2"/>
							</td><td>Columnas:</td><td>
							<input name="txtMtzAcol" type="text" size="1" maxlength="2" value="4"/>
						</tr>
					</table></td>
					<td>
					<table>
						<tr>
							<td align="center" colspan="4"><b>Matriz B</b></td>
						</tr>
						<tr>
							<td>Filas:</td><td>
							<input name="txtMtzBfil" type="text" size="1" maxlength="2" value="4"/>
							</td><td>Columnas:</td><td>
							<input name="txtMtzBcol" type="text" size="1" maxlength="2" value="3"/>
							</td>
						</tr>
					</table></td>
				</tr>
			</table>
			<br />
			<div align="center">
				<input name="btnMultiplicar" type="button" value="Generar Matrices" onclick="OpeMultp(txtMtzAfil.value, txtMtzAcol.value, txtMtzBfil.value, txtMtzBcol.value)"/>
			</div>
			<br/>
			<div id="divMatrices"> </div>
		</form>
	</body>
</html>