# Introduction #
Flowearth provide a simple way to synchronize a Nodes structure to the segment of the browser URL.


# SWFAddressConnector #

Here's a simple example of connection of a Nodes structure to swfAddress.

```
... build descriptor (see "the Node object" chapter )
//
// 1
//
var mainDevice : Node = new Node( descriptor );
trace( mainDevice.getId()  ); // --> "main"

//
// 2
//
nodeSystem.addDevice( mainDevice );

//
// 3
//
var swfAddressConnector : SWFAddressConnector = new SWFAddressConnector();			
swfAddressConnector.connectNode( mainNode );			
swfAddressConnector.connectAddress();


```


  1. build the structure based on descriptor
  1. add root node of the structrue to the nodeSystem. Note that nodes register in a SWFAddressConnector must be device of nodeSystem
  1. SWFAddress sync :
    * create a SWFAddressConnector
    * add a device node ( node register as root node in nodeSystem )
    * start sync with js/swfAddress