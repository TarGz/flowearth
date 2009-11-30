var close = true;

fl.outputPanel.clear();
fl.compilerErrors.clear();


for( doc in fl.documents ) {
	if( fl.documents[doc].path.replace( /\\/g, "/" ) == "${flapath}" ) 
		close = false;
}

var doc = fl.openDocument( "file:///${flapath}" );


doc.publish();

fl.outputPanel.save( "file:///${outputpath}", true, true );
fl.compilerErrors.save( "file:///${errorspath}", true, true );

if (close) fl.closeDocument(doc, false);
