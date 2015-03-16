# Introduction #

A batcher object is itself IBatchable. This mean that you can add a batcher to the queue of another parent batcher (and so on).

# Structure Example #

Here is a simple example of a batchers structure.

```

var mainBatcher   : Batcher;
var thumbsBatcher : Batcher;
var pictsBatcher  : Batcher;

buildStruct();

addLoadings();


function buildStruct() : void {

   mainBatcher    = new Batcher();
   thumbsBatcher  = new Batcher();
   pictsBatcher   = new Batcher();

   mainBatcher.addItem( thumbsBatcher );
   mainBatcher.addItem( pictsBatcher );

}

function addLoadings() : void {

   thumbsBatcher.addItem( 
                          createItem( "picts/thumb_01.jpg" )
                         );
   thumbsBatcher.addItem( 
                          createItem( "picts/thumb_02.jpg" )
                         );
   thumbsBatcher.addItem( 
                          createItem( "picts/thumb_03.jpg" )
                         );

   pictsBatcher.addItem( 
                          createItem( "picts/pict_01.jpg" )
                         );
   pictsBatcher.addItem( 
                          createItem( "picts/pict_02.jpg" )
                         );
   pictsBatcher.addItem( 
                          createItem( "picts/pict_03.jpg" )
                         );

}




function createItem( url : String ) : BatchLoaderItem {        
    var request : URLRequest = new URLRequest( url );
    return new BatchLoaderItem( request );
}

```


## Handle completion ##

Using the previous structure, here is different way to handle completion on batchers structure.

```

mainBatcher.addEventListener( Event.COMPLETE, overallComplete );
mainBatcher.addEventListener( BatchEvent.ITEM_COMPLETE, onItemComplete );

thumbsBatcher.addEventListener( BatchEvent.ITEM_COMPLETE, onThumbComplete );
pictsBatcher.addEventListener( BatchEvent.ITEM_COMPLETE, onPictComplete );

mainBatcher.start();

function overallComplete ( e : Event ) : void {
   // 1
   trace( "All medias are loaded" );
}

function onItemComplete ( e : BatchEvent ) : void {
   // 2
   trace( e.item );
}

function onThumbComplete ( e : BatchEvent ) : void {
   // 3
   var item : BatchLoaderItem = event.item as BatchLoaderItem;
   addChild( item.loader );
}

function onPictComplete ( e : BatchEvent ) : void {
   // 4
   var item : BatchLoaderItem = event.item as BatchLoaderItem;
   addChild( item.loader );
}

```

1. Handle overall completion.
> Listen Event.COMPLETE event on the root batcher let you handle the overall completion of all items.

2. Handle all descendant items completion
> Each time an item complete in a batchers structure, a BatchEvent.ITEM\_COMPLETE bubbles in the parents batchers.
> The _onItemComplete_ method will trace :
    * [BatchLoaderItem](object.md) //picts/thumb\_01.jpg
    * [BatchLoaderItem](object.md) //picts/thumb\_02.jpg
    * [BatchLoaderItem](object.md) //picts/thumb\_03.jpg
    * [Batcher](object.md) //thumbBatcher
    * [BatchLoaderItem](object.md) //picts/pict\_01.jpg
    * [BatchLoaderItem](object.md) //picts/pict\_02.jpg
    * [BatchLoaderItem](object.md) //picts/pict\_03.jpg
    * [Batcher](object.md) //pictBatcher

3. / 4. We add BatchEvent.ITEM\_COMPLETE on each sub batcher to specificaly handle completion of thumbs and picts

## Handle errors ##

Using the previous structure, here is different way to handle errors on batchers structure.

```
mainBatcher.addEventListener( ErrorEvent.ERROR, onError );
pictsBatcher.addEventListener( BatchErrorEvent.ITEM_ERROR, onPictError );

function onError ( e : BatchErrorEvent ) : void {
   trace( e.item );
}

function onPictError ( e : BatchErrorEvent ) : void {
   trace( "error while loading picture" );
   trace( e.item );
}

```

Listening ErrorEvent.ERROR on the root batcher let you handle all errors happening in the structure.

As well as ITEM\_COMPLETE and all bubbling events, you can specifically listen Error on sub batchers.

## Handle progression ##
Using the previous structure, here is different way to handle progression on batchers structure.

```

mainBatcher.addEventListener( ProgressEvent.PROGRESS, onProgress );
pictsBatcher.addEventListener( ProgressEvent.PROGRESS, onPictsProgress );

function onProgress ( e : ProgressEvent ) : void {
   trace( "overall progression : "+( e.bytesLoaded/e.bytesTotal ) );
}

function onPictsProgress ( e : ProgressEvent ) : void {
   trace( "picts progression : "+( e.bytesLoaded/e.bytesTotal ) );
}


```

When any item dispatch a ProgressEvent.PROGRESS, the parent batcher compute is own progression an redispatch an event (and so on). Note that the leaf item must dispatch the first ProgressEvent to initiate the progress bubbling. BatchLoaderItem and BatchURLLoaderItem dispatch this event.

### weight property ###
The progress value of a batcher is based on the sum of all added IBatchable's weigth.
Built-in items (BatchLoaderItem , BatchURLLoaderItem) have a weight set to 1 by default.

Note that _bytesLoaded_ property is an abstract value and do noy represent real bytes. _bytesTotal_ is always equal to 10000.

## Handle status ##

//todo