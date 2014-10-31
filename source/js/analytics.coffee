Platform.isReady () ->
  trackingID = '<insert tracking ID here>'
  if window.isWebView
    ga 'create', trackingID,  
      'storage': 'none'
      'clientId': device.uuid

    ga('set', 'checkProtocolTask', null); 
  else
    ga 'create', trackingID, 'auto'