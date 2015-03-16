A BatchLoaderItem instance internally store a native Loader object to load medias.

When loading is complete you can acces to this the loader object via BatchLoaderItem.loader property.

You can listening for LoaderInfo events directly on BatchLoaderItem instance :

  * Event.INIT
  * Event.COMPLETE
  * ProgressEvent.PROGRESS
  * ErrorEvent.ERROR
  * Event.OPEN


> IOErrorEvent.IO\_ERROR and SecurityErrorEvent.SECURITY\_ERROR are listening on loaderInfo object and redispatched as a simple ErrorEvent.ERROR event.