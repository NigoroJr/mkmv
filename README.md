# mkmv

## Description

Does `mkdir` and `mv` in one command. Simple stupid script and I'm pretty sure
thousands of people have already written similar scripts, but hey, sometimes
you are too lazy to find them/feel like reinventing the wheel.

## Usage

You would normally use this script to create the destination directory and
perform a `mv` (1a and 1b in the following example).

The script guesses whether the destination you specify is a file (when you
want to move and rename the source) or a directory (2).

With the `-d` option, the destination is treated as a directory, even if it
looks like a file (3).

With the `-f` option, the destination is treated as a file, even if the
destination looks like a directory (4).

```console
# 1a. Create the path ~/foo/bar and move foo.txt into it
$ mkmv foo.txt ~/foo/bar
# 1b. Same but for multiple sources
$ mkmv foo.txt bar.txt baz.txt ~/foo/bar
# 2. Create the path ~/foo/bar and move foo.txt into it as baz.txt
$ mkmv foo.txt ~/foo/bar/baz.txt
# 3. Create the path ~/foo/bar/baz.txt and move foo.txt into it
$ mkmv -d foo.txt ~/foo/bar/baz.txt
# 4. Create the path ~/foo and move foo.txt into it as bar
$ mkmv -f foo.txt ~/foo/bar
```

## Author

Naoki Mizuno (nigorojr@gmail.com)

## License

MIT License
