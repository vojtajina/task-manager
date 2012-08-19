# bypass auth during development
match = /token=([^\&]*)/.exec window.location.search
if match
  console.log 'By passing auth, using ', match[1]
  onAuthLibLoad = -> null
  handleAuthorized match[1]
