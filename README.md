# File IO test

Test to see if the file reading in C does some buffering or not.

Answer: setting the buffer size to 0 via `setvbuf(file , NULL , _IONBF , 0 );` can completely disable the buffering.
