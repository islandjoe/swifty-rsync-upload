# Swift Upload

Whenever I upload a new post or update my static website I use the tried-and-tested `rsync` (I even made a post about it [here](http://bit.ly/2bToya2)). This is the `rsync` command
I type:

```bash
rsync -avzrO --no-perms --delete . compendium.xyz:/path/to/www --exclude=".DS_Store"
```

Every. Time.

While it works as intended, it forces me to be always on my toes. One day I will lose concentration for one second and mayhem could ensue. That's how powerful `rsync` is. I need to tread carefully all the time.

But, I'd like a command that gives me some safety, so that, for example, I won't burn myself if I momentarily lose focus  (like uploading the wrong files and deleting the ones in the server just because I'm not in the correct directory).

I'd like a command where it allows me to continue to be in cerebral mode after finishing a post, not forcing me to switch to Linux admin mode immediately, where the only thing required of me &mdash;even absentmindedly&mdash;is to remember the name of the command. So the best compromise I came up with was to wrap my current `rsync` incantation inside a shell script and give it a short and simple name.

So this whole thing started as a Bash script, but I just couldn't wrap my head around Bash's syntax and grammar that I abandoned it halfway. To make the long story short, I decided to use Swift because it gave me result in such a short time.

## Configure

Inside `SwiftUpload.swift` under the `// CONFIGURE HERE` section add your server host in `host` constant, destination directory (path of your website's directory) in `dest` constant, and the local build directory in `buildDir` constant. 

[](i/configure-here.png)

## Compile

Now compile the file into an executable by typing the command in terminal:

```bash
swiftc SwiftUpload.swift -o upload
```

The `-o upload` tells the compiler that the output of this process will result in an executable named `upload`. This saves you one less command too because you do not need to do `chmod +x upload` anymore.
