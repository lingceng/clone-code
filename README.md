CLoneCode
============
ruby1.9.3 required

###Run to get help
    ruby cc.rb

###Basic usage
replace all files under HelloWorld directory from **HelloWorld** to **WellDone** 

    ruby --encoding=utf-8 cc.rb -f HelloWorld -t WellDone -d 'demo/**/*'

####Here is the magic
some **similar words** will be replaced:
* HelloWorld --> *WellDone*
* helloWorld --> *wellDone*
* helloworld --> *welldone*
* HELLOWORLD --> *HELLOWORLD*
* hello_world --> *well_done*

`--encoding=utf-8` specify the encoding to **utf-8** when the file contains UTF-8 sequence  
other option may be **gbk**

###Options
- **-f** specify the word which replace *from*  using *camel case*  
  eg.
  - `-f hello`  
  - `-f helloWorld`
  - `-f HelloWorld`

- **-t** specify the word which replace *to*  using *camel case*

- **-d** specify the file path
  - \*\*  Matches directories recursively.
  - \*    Matches any file
  - ?     Matches any one character
<<<<<<< HEAD

=======
  
>>>>>>> 68f4a9e04f4fe90150c9321186741dd6ef81fed6
    eg.  
    `-d '/home/**/*.rb'` matches all ruby files in home or subdirecory  
    `-d '/hello*/*'` matches all files in direcory which starts with 'hello'
 



----------------------
####version 1.3
capatible windows path like 'E:\Hello\*'

