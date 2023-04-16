# test-nrcp

This script counts the frequency of URL parameters in a set of logfiles.

To run the script, modify the input in 'run.rb' then execute :
```sh
ruby run.rb
```
By default, the input is :
>path = './logs/*'
>parameter = 'id'
>size = 5


If you modify the code, please make sure to run the test :
```sh
ruby test/test.rb
```
