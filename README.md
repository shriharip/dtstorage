# tstorage

A flutter package for simple storage of key value data.
The data is exposed using a stream provider and also exposes few details like the file that is stored. 

Uses native dart file io system for faster access.

## Getting Started

depend on the package using the package name tstorage in the pubspec.yaml file

create an instance like ```` Storage() ```` optionally you can pass the file path as ```` Storage(fpath: 'db.txt') ````.

read values as ```` Storage.read( 'key', defaultValue: 0); ````

write values as ```` Storage.write( 'key', data); ````

look at example folder for an example implementation