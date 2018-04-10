var fso = new ActiveXObject('Scripting.FileSystemObject');
var filePath = fso.GetAbsolutePathName(WScript.Arguments(0));
var pdfPath = filePath.replace(/\.xlsx?$/i, '.pdf');

var objExcel = null;
try {
	WScript.Echo(pdfPath);
	
	objExcel = new ActiveXObject('Excel.Application');
	objExcel.Visible = false;
	
	var objWorkbook = objExcel.Workbooks.Open(filePath);
	
	WScript.Echo('  saving');
	
	// var xlTypePDF = 57;
	// objWorkbook.SaveAs(pdfPath, xlTypePDF);
	objWorkbook.ExportAsFixedFormat(0, pdfPath);
	objWorkbook.Close(false);
	
	WScript.Echo('  done');
}
finally {
	if (objExcel != null) {
		objExcel.Quit();
	}
}