#Register time syncronizing service
w32tm /register
net start w32time
w32tm /resync