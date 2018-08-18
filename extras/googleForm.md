# Webhook into Discord from Google Form

## The Setup

1. Create Google Form
1. Click the triple-dot icon in the top-right corner
1. Select 'Script Editor'
1. Add The Code (With necessary edits) and Click Save
1. Click 'Edit' and 'Current Project Triggers'
1. Add a new trigger: "onFormSubmit", "From form", "On form Submit"
1. Click Save

## The Code
```
function onFormSubmit(e) {
  var fields = [];

  // Makes sure at least 3 of the fields are populated
  if (e.response.getItemResponses().length < 3) { 
    return;
  }

  for (i = 0; i < e.response.getItemResponses().length; i++) {
    var response = e.response.getItemResponses()[i];
    var value_temp = response.getResponse();
    var value = (Array.isArray(value_temp) ? value_temp.join() : value_temp);

    fields.push({
      "name": response.getItem().getTitle(),
      "value": value,
      "inline": false
    });
  }

  var data = {
    "content": '<HEADLINE TEXT GOES HERE>',
    "embeds": [{
      "title": "**New form submission** — " + (e.source.getTitle() != null && e.source.getTitle().length > 0 ? e.source.getTitle() : "Untitled Form"),
      "type": "rich",
      "fields": fields
    }]
  };

  var options = {
    method: "post",
    payload: JSON.stringify(data),
    contentType: "application/json; charset=utf-8",
    muteHttpExceptions: true
  };

  Logger.log("Attempting to send:");
  Logger.log(JSON.stringify(data));

  var response = UrlFetchApp.fetch("<YOUR WEBHOOK GOES HERE>", options);
  Logger.log(response.getContentText());
  
};
```
